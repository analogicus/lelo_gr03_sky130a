# Digital Layout Shrink — `temp_sens`

> **For Claude:** REQUIRED SUB-SKILL — use `superpowers-extended-cc:writing-plans` to turn this design into an executable implementation plan.

**Goal.** Shrink the synthesised `temp_sens` layout (currently 4 436 µm², 562 cells) without touching the RTL, add STA coverage for the second clock domain, and adjust pin placement to match the analog neighbourhood in the top-level. Functional behaviour across PVT must be preserved or improved; **it MUST NOT become worse**.

**Constraints from user.**

- No manual cell placement — LibreLane only.
- Do not merge the dual-edge counter (`cnt_r` / `cnt_f` stay separate).
- Do not touch `README.md` — colleague is editing it on `main`.
- Stay off `main`. Work on branch `digital-layout-shrink`.
- GLS + SDF peak calibration error ≤ RTL peak calibration error, per corner.

---

## 1. Baseline (2026-04-17)

| Metric | Value |
|---|---|
| Layout file | `design/LELO_GR03_SKY130A/temp_sens.mag` |
| Bounding box | 64.33 × 68.96 µm |
| Area | **4 436 µm²** |
| Cell count | 562 total |
| &nbsp;&nbsp;• flip-flops (`dfrtp_2`, `dfstp_2`) | 28 |
| &nbsp;&nbsp;• logic gates (non-FF) | ~113 |
| &nbsp;&nbsp;• clock-tree (`clkdlybuf`, `dlygate`, `clkbuf`) | 42 |
| &nbsp;&nbsp;• well-taps | 46 |
| &nbsp;&nbsp;• decap + fill | 333 |
| Standard-cell library | `sky130_fd_sc_hd` (drive strength `_2` dominant) |
| Synthesis tool | LibreLane (Nix flake) |
| Config file | `rtl/config.json` |
| SDC file | none — clocks declared inline in config only |
| `i_clk_osc` (2 MHz, dual-edge counter clock) | **unconstrained** — STA silently skips it |

### Why it is large (ranked)

1. `CLOCK_PERIOD: 200` ns is ~150× tighter than the real `i_clk` period (32.768 kHz → 30 518 ns). Forces `_2` drive strength everywhere and grows a 42-cell clock tree for 28 flops.
2. `SYNTH_MAX_FANOUT: 6` is deprecated in OpenLane/LibreLane and low. Inserts extra buffers/inverters early.
3. Default `FP_CORE_UTIL: 50` leaves half the die as decap/fill.
4. `i_clk_osc` is undeclared → CTS heuristics over-compensate on `i_clk`; STA never sign-off the oscillator domain.
5. `i_clk_osc` pin is currently on **West** of the block, but its driver (comparator output FF) sits directly below `temp_sens`. Unnecessary routing detour.

---

## 2. Target configuration

### 2.1 `rtl/config.json`

```json
{
    "DESIGN_NAME": "temp_sens",
    "VERILOG_FILES": ["dir::temp_sens.sv"],
    "CLOCK_PERIOD": 10000,
    "CLOCK_PORT": "i_clk",
    "SDC_FILE": "dir::temp_sens.sdc",
    "SYNTH_DRIVING_CELL": "sky130_fd_sc_hd__inv_1/Y",
    "SYNTH_BUFFER_CELL":  "sky130_fd_sc_hd__buf_1/A/X",
    "FP_CORE_UTIL": 65,
    "IO_PIN_ORDER_CFG": "dir::pin_order.cfg"
}
```

Changes vs current:

| Key | Before | After | Reason |
|---|---|---|---|
| `CLOCK_PERIOD` | 200 ns | 10 000 ns | 3× margin over real 32.768 kHz reference; enables `_1` drive everywhere. |
| `SYNTH_MAX_FANOUT` | 6 | *removed* | Deprecated in OpenLane docs; PDK default (`MAX_FANOUT_CONSTRAINT = 10`) takes over. |
| `SDC_FILE` | — | `dir::temp_sens.sdc` | Declare both clock domains + async grouping. |
| `SYNTH_DRIVING_CELL` | — | `inv_1/Y` | Tells Yosys to assume weakly-driven inputs → discourages upsizing. |
| `SYNTH_BUFFER_CELL` | — | `buf_1/A/X` | Forces buffer insertions to use minimum drive. |
| `FP_CORE_UTIL` | — (default 50) | 65 | Small-block regime; `PL_TARGET_DENSITY` auto-computes to ~0.75. |
| `IO_PIN_ORDER_CFG` | unchanged | unchanged | Still points at `pin_order.cfg`. |

`PL_TARGET_DENSITY` is intentionally omitted — LibreLane's formula `(FP_CORE_UTIL + 10 + 5 × GPL_CELL_PADDING) / 100` will derive it.

### 2.2 `rtl/temp_sens.sdc` (new)

```tcl
create_clock -name i_clk     -period 10000 [get_ports i_clk]
create_clock -name i_clk_osc -period   500 [get_ports i_clk_osc]
set_clock_groups -asynchronous -group {i_clk} -group {i_clk_osc}
set_input_delay  -clock i_clk 0 [all_inputs]
set_output_delay -clock i_clk 0 [all_outputs]
set_load 0.1 [all_outputs]
```

- `i_clk` at 10 000 ns (100 kHz) — 3× margin on the 32.768 kHz reference.
- `i_clk_osc` at 500 ns (2 MHz) — matches the oscillator output.
- `set_clock_groups -asynchronous` suppresses STA between the two domains (they *are* asynchronous — the `WAIT` state in the FSM is the CDC synchroniser).
- Zero input/output delays are fine because the block is bounded by large async paths on both sides; we only care about internal timing.

### 2.3 `rtl/pin_order.cfg` (replace)

```
#N
i_start
i_clk
i_rst_n
o_osc_count.*

#S
o_pwrup_osc
i_clk_osc
```

Reasoning against the observed top-level:

- Top-level `tt_um_lelo_gr03_analogicus.mag` has every external pad as `flabel metal4` at y=22104–22304 with orientation `s` → all chip I/O enters from the **top edge**.
- Relative to `temp_sens` (placed at top-right of `LELO_GR03`):
  - North of `temp_sens` → tt_um pads (external signals come down from above).
  - South of `temp_sens` → COMPARATOR block + its output flip-flop (source of `i_clk_osc`).
  - West of `temp_sens` → BIAS block (which contains the oscillator subcircuits the user confirmed).
  - East of `temp_sens` → chip edge, unused.
- `#N` therefore stays for the four tt_um-sourced signals and the 8-bit count output.
- `#S` groups both feedback-loop signals:
  - `o_pwrup_osc` listed first → lands on the **left** side of the south edge → towards BIAS / oscillator subcircuits (x range 12 300–17 348).
  - `i_clk_osc` listed second → lands on the **right** side of the south edge → ~ directly above the comparator FF at x=27 768.

### 2.4 `sim/tb_temp_sens/tb_gls.v` (new)

Copy of `sim/tb_temp_sens/tb.v` with three modifications:

1. DUT compiled from the LibreLane output netlist (`runs/<latest>/final/pnl/temp_sens.nl.v`) instead of the RTL `temp_sens.sv`.
2. Link against sky130 cell Verilog models at `/opt/pdk/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/verilog/`.
3. Annotate SDF inside the DUT scope:
   ```verilog
   initial $sdf_annotate("runs/<latest>/final/signoff/temp_sens.sdf", u_dut);
   ```

`timescale 1 ns / 1 ps` already matches SDF default.

### 2.5 `sim/tb_temp_sens/Makefile` (extend)

Add two targets:

- `gls CORNER=<name>` — compile `tb_gls.v` + netlist + sky130 models, annotate the SDF for that corner, run, write `gls_<corner>.csv`.
- `gls-all` — iterate over every corner exported by `fit_osc.py --list`.

Existing `tb` / `all-corners` targets remain unchanged.

### 2.6 `.gitignore`

No changes required — the existing rules already cover everything this task generates:

| Path | Already-ignored by |
|---|---|
| `rtl/runs/` (LibreLane run outputs) | explicit `rtl/runs/` line |
| `work/` (all analog tooling artefacts) | explicit `work/` line |
| `sim/tb_temp_sens/gls*.csv` | `sim/tb_temp_sens/*.csv` |
| `docs/plans/` | explicit `docs/plans/` line (design docs must be force-added, following the existing convention for `2026-04-14-bias-circuit-task-13-handoff.md`) |

### 2.7 `design/LELO_GR03_SKY130A/temp_sens.mag` (regenerated)

Overwritten by the LibreLane output after all verification passes. The current file is preserved in git history for rollback.

---

## 3. Implementation order

| # | Step | Output |
|---|---|---|
| 1 | `git checkout -b digital-layout-shrink` | Branch created (done before writing this doc). |
| 2 | Commit this design doc. | `docs/plans/2026-04-17-digital-layout-shrink-design.md` in history. |
| 3 | Capture RTL-sim baseline: `cd sim/tb_temp_sens && make clean && make all-corners`, copy `output/` to `/tmp/rtl-baseline/`. | 11 per-corner CSVs saved outside repo. |
| 4 | Apply config changes: edit `rtl/config.json`, create `rtl/temp_sens.sdc`, replace `rtl/pin_order.cfg`, append to `.gitignore`. One commit per logical change. | 3–4 commits. |
| 5 | Re-run RTL sim. `diff -qr output/ /tmp/rtl-baseline/` must be empty. | Byte-identical confirmation. |
| 6 | Finalise Nix setup (`experimental-features = nix-command flakes` in `/etc/nix/nix.conf`, `sudo systemctl enable --now nix-daemon.socket`). | Nix flakes usable. |
| 7 | Run LibreLane via Nix flake, pinning a known-good commit: `nix run github:librelane/librelane/<sha> -- --pdk-root /opt/pdk/open_pdks rtl/config.json`. | `runs/<timestamp>/final/…`. |
| 8 | Inspect `final_summary.log` + signoff reports. STA, DRC, LVS must all pass; WNS ≥ 0 and TNS = 0 on both clock domains. | Clean sign-off. |
| 9 | Copy `runs/<latest>/final/mag/temp_sens.mag` into `design/LELO_GR03_SKY130A/temp_sens.mag`. Recompute area using the `awk` bounding-box approach from baseline. | New area value. |
| 10 | Write `sim/tb_temp_sens/tb_gls.v`. Extend Makefile with `gls` and `gls-all` targets. | GLS infrastructure. |
| 11 | Run `make gls-all`. Run `tb.py` on each `gls_<corner>.csv` to extract peak calibration error. Compare per corner to the RTL baseline. | Per-corner error ≤ baseline. |
| 12 | Commit regenerated `temp_sens.mag` with before/after area in the commit message. Commit GLS files. | Final commit(s). |
| 13 | `git push -u origin digital-layout-shrink`; `gh pr create --draft --base main`. | Draft PR open. |

---

## 4. Verification bar

All must be green before the PR is marked non-draft.

1. LibreLane runs end-to-end via Nix without user intervention after the first invocation.
2. New `temp_sens.mag` area **< 4 436 µm²** (strictly smaller).
3. STA WNS ≥ 0 and TNS = 0 on both `i_clk` (10 000 ns) and `i_clk_osc` (500 ns).
4. DRC: 0 violations (Magic + LibreLane).
5. LVS: netlists match (netgen + LibreLane).
6. RTL sim `output/` byte-identical before and after config changes (the RTL does not change).
7. GLS + SDF peak calibration error ≤ RTL peak calibration error for **every** PVT corner. Better or equal accepted; worse is a hard fail.
8. `digital-layout-shrink` pushed, draft PR opened, CI (`gds.yaml`, `drc.yaml`, `lvs.yaml`) green.

---

## 5. Risks & fallbacks

| # | Risk | Mitigation |
|---|---|---|
| 1 | Nix flake fetch fails (network, ~5 GB first-run pull). | Retry; fall back to CI-only verification if persistent. |
| 2 | System PDK at `/opt/pdk/open_pdks` version-drifts from the one LibreLane's flake pins. | Re-run LibreLane letting it fetch its own pinned PDK (`--ciel` / `volare`). |
| 3 | STA fails on `i_clk_osc` (500 ns). Unlikely for a counter. | Inspect violating path; add `set_false_path` on async-reset edges, or relax period to 1 000 ns. |
| 4 | Routing congestion at 65 % utilisation. | Drop `FP_CORE_UTIL` to 60 and re-run. |
| 5 | GLS + SDF uncovers X-propagation hidden by RTL sim. | Fix in the GLS testbench first (longer reset, explicit `initial`). Only touch RTL if the X is a real design bug. |
| 6 | Resulting layout not meaningfully smaller. | Histogram the cells; if clock-tree-heavy, inspect CTS reports; if fill/decap-heavy, try `FP_CORE_UTIL: 70`. |
| 7 | LibreLane `main` drifts between our run and CI's run. | Pin the flake commit explicitly (`github:librelane/librelane/<sha>`); record the SHA in the PR description. |
| 8 | `pin_order.cfg` format incompatibility with current LibreLane. | If LibreLane warns/errors, drop `IO_PIN_ORDER_CFG` entirely — placer will pick its own order. |

Hard rollback: `git checkout main -- rtl/ design/LELO_GR03_SKY130A/temp_sens.mag sim/tb_temp_sens/` restores everything.

---

## 6. Out of scope

- README edits (colleague's active work on `main`).
- Manual cell placement.
- Merging `cnt_r` / `cnt_f`.
- Switching to `sky130_fd_sc_hdll` (lower leakage, same footprint — no area benefit).
- Any analog block layout changes.
- Any change to the top-level `tt_um_lelo_gr03_analogicus.mag` (only `temp_sens` inside it changes; the top-level must still abut cleanly).

---

## 7. Expected outcome (non-binding estimate)

- Area: 1 500–2 500 µm² (50–65 % reduction). Actual number comes from the tool.
- Cells: ~250–350.
- Drive strengths: overwhelmingly `_1`.
- Clock tree: a small handful of buffers.
- `i_clk_osc` route from comparator FF: short vertical drop instead of the current detour.
- STA clean on both domains for the first time in this project.

If the actual shrink is < 20 %, re-open this plan and iterate on `FP_CORE_UTIL` / cell exclusion list.

---

## Task IDs (created during brainstorm)

- #1 Explore project context — done
- #2 Ask clarifying questions — done
- #3 Propose approach options — done
- #4 Present design sections — done
- #5 Write design doc — this file
- #6 Invoke writing-plans — next
