# Digital Layout Shrink — `temp_sens` — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use `superpowers-extended-cc:executing-plans` to implement this plan task-by-task.

**Goal:** Shrink the `temp_sens` synthesised layout from 4 436 µm² without changing RTL, add STA coverage for `i_clk_osc`, and move the two oscillator-feedback pins to the south edge of the block. Every step gated by verification — GLS + SDF calibration error must not regress vs RTL on any corner.

**Architecture:** Config-only change to `rtl/config.json` + new SDC + rewritten `pin_order.cfg`. LibreLane runs locally via Nix flake (PDK at `/opt/pdk/open_pdks`). Verification is a three-tier stack: RTL simulation regression (byte-identical before/after config edit), LibreLane built-in STA/DRC/LVS sign-off, then post-synth gate-level simulation with SDF back-annotation.

**Tech Stack:** LibreLane (Nix flake), OpenROAD, Yosys, Magic, netgen, iverilog, sky130_fd_sc_hd, Python (numpy + pandas for calibration diff).

**Design doc:** `docs/plans/2026-04-17-digital-layout-shrink-design.md` (commit `40ad3de`).

**Branch:** `digital-layout-shrink` (already checked out).

---

## Task 0: Capture RTL-sim baseline

Before any config change, freeze the current RTL behaviour per corner so Task 4 can diff against it byte-for-byte.

**Files:**
- Read: `sim/tb_temp_sens/Makefile`
- Produces (outside repo): `/tmp/rtl-baseline/tb_tran_<corner>.csv` × 11

**Step 1:** Run the full corner sweep.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
make clean
make all-corners
```

Expected: `output/tb_tran_SchGtK??T?V?.csv` × 11 (one per PVT corner listed by `python3 fit_osc.py --list`).

**Step 2:** Snapshot to `/tmp`.

```fish
rm -rf /tmp/rtl-baseline
cp -r output /tmp/rtl-baseline
ls /tmp/rtl-baseline | wc -l
```

Expected: count ≥ 11.

**Step 3:** Record the peak calibration error per corner (used later as the pass/fail bar for GLS).

Create `sim/tb_temp_sens/compare_calibration.py` — it is used now to extract per-corner peak error, and re-used in Task 12 to compare RTL vs GLS.

```python
#!/usr/bin/env python3
"""Extract peak 1-pt and 2-pt calibration error from a temp/count CSV."""
import sys
from pathlib import Path

import numpy as np
import pandas as pd


def peak_errors(csv_path: Path) -> tuple[float, float]:
    df = pd.read_csv(csv_path)
    t = df["temperature"].astype(float).to_numpy()
    count = df["count"].astype(float).to_numpy()
    freq = count * 32768.0

    coeffs = np.polyfit(freq, t, 1)
    f25 = float(np.interp(25, t, freq))
    f85 = float(np.interp(85, t, freq))

    offset_1pt = 25 - coeffs[0] * f25
    t_1pt = coeffs[0] * freq + offset_1pt
    e1 = float(np.max(np.abs(t_1pt - t)))

    slope_2pt = (85 - 25) / (f85 - f25)
    offset_2pt = 25 - slope_2pt * f25
    t_2pt = slope_2pt * freq + offset_2pt
    e2 = float(np.max(np.abs(t_2pt - t)))

    return e1, e2


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: compare_calibration.py <rtl.csv> [<gls.csv>]", file=sys.stderr)
        return 2

    rtl_path = Path(sys.argv[1])
    rtl_e1, rtl_e2 = peak_errors(rtl_path)

    if len(sys.argv) == 2:
        print(f"{rtl_path.name}: 1pt={rtl_e1:.3f}  2pt={rtl_e2:.3f}")
        return 0

    gls_path = Path(sys.argv[2])
    gls_e1, gls_e2 = peak_errors(gls_path)
    ok = gls_e1 <= rtl_e1 + 1e-6 and gls_e2 <= rtl_e2 + 1e-6
    verdict = "OK" if ok else "FAIL"
    print(
        f"{rtl_path.name} vs {gls_path.name}: "
        f"rtl[1pt={rtl_e1:.3f} 2pt={rtl_e2:.3f}] "
        f"gls[1pt={gls_e1:.3f} 2pt={gls_e2:.3f}] {verdict}"
    )
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
```

**Step 4:** Record baseline errors.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
for f in /tmp/rtl-baseline/*.csv
    python3 compare_calibration.py $f
end | tee /tmp/rtl-baseline-errors.txt
```

Expected: 11 lines like `tb_tran_SchGtKttTtVt.csv: 1pt=X.XXX 2pt=Y.YYY`.

**Step 5:** Commit the helper script.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add sim/tb_temp_sens/compare_calibration.py
git commit -m "Add compare_calibration.py: peak 1pt/2pt calibration error extractor"
```

---

## Task 1: Finalise Nix for LibreLane

One-time system setup. User has `nix` installed but daemon + flakes are not enabled yet.

**Files:**
- System: `/etc/nix/nix.conf`

**Step 1:** Enable the Nix daemon.

```fish
sudo systemctl enable --now nix-daemon.socket
systemctl is-active nix-daemon.socket
```

Expected: `active`.

**Step 2:** Enable flakes if not already (check first).

```fish
grep -q 'experimental-features = nix-command flakes' /etc/nix/nix.conf ; or \
    echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
grep 'experimental-features' /etc/nix/nix.conf
```

Expected: line present.

**Step 3:** Verify flakes work end-to-end without fetching LibreLane yet.

```fish
nix flake --help 2>&1 | head -3
```

Expected: help text starting with `Usage: nix flake`. If you see `experimental feature 'flakes' is disabled`, restart the terminal so the updated config is picked up.

**No commit** — system-level change.

---

## Task 2: Create `rtl/temp_sens.sdc`

SDC constraining both clock domains. Must be created **before** editing `config.json` so the `SDC_FILE` reference resolves on the first LibreLane run.

**Files:**
- Create: `rtl/temp_sens.sdc`

**Step 1:** Write the file.

```tcl
# Two independent clock domains.
#   i_clk     : 32.768 kHz reference (given 3x margin -> 100 kHz).
#   i_clk_osc : ~2 MHz temperature-dependent oscillator.
create_clock -name i_clk     -period 10000 [get_ports i_clk]
create_clock -name i_clk_osc -period   500 [get_ports i_clk_osc]

# The FSM's WAIT state is the async CDC synchroniser, so STA should not
# try to time between these two domains.
set_clock_groups -asynchronous -group {i_clk} -group {i_clk_osc}

# Zero input/output delays: all block-level I/O hands off to async pads
# or to the analog feedback loop, neither of which STA covers.
set_input_delay  -clock i_clk 0 [all_inputs]
set_output_delay -clock i_clk 0 [all_outputs]
set_load 0.1 [all_outputs]
```

**Step 2:** Commit.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add rtl/temp_sens.sdc
git commit -m "Add rtl/temp_sens.sdc with both clock domains and async grouping"
```

---

## Task 3: Update `rtl/config.json`

**Files:**
- Modify: `rtl/config.json`

**Step 1:** Replace the file contents.

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

**Step 2:** Validate JSON is syntactically clean.

```fish
python3 -c "import json; json.load(open('/home/kim/pro/aicex/ip/lelo_gr03_sky130a/rtl/config.json'))"
```

Expected: no output, exit 0.

**Step 3:** Commit.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add rtl/config.json
git commit -m "Relax temp_sens synth: 10us clock, _1 drives, util 65, drop SYNTH_MAX_FANOUT"
```

---

## Task 4: Rewrite `rtl/pin_order.cfg`

**Files:**
- Modify: `rtl/pin_order.cfg`

**Step 1:** Replace contents.

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

**Step 2:** Commit.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add rtl/pin_order.cfg
git commit -m "Move oscillator feedback pins to south edge (abut COMPARATOR/BIAS)"
```

---

## Task 5: RTL-sim regression check

The RTL itself didn't change, so the full corner sweep must produce **byte-identical** CSVs. Any diff means something unintended happened — abort and investigate.

**Step 1:** Clean and re-run the corner sweep.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
make clean
make all-corners
```

**Step 2:** Diff against the baseline captured in Task 0.

```fish
diff -qr output/ /tmp/rtl-baseline/
```

Expected: empty output, exit 0.

**Step 3 (abort path):** If any file differs, STOP. Don't run LibreLane. Inspect what changed — very likely an accidental edit to `rtl/temp_sens.sv` — and revert before proceeding.

**No commit.**

---

## Task 6: Run LibreLane via Nix

**Files produced:**
- `rtl/runs/<timestamp>/final/mag/temp_sens.mag`
- `rtl/runs/<timestamp>/final/pnl/temp_sens.nl.v`
- `rtl/runs/<timestamp>/final/signoff/*.sdf`
- `rtl/runs/<timestamp>/final_summary.log`

**Step 1:** Invoke LibreLane, pinning to `main` (Task 7 records the exact SHA).

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/rtl
nix run 'github:librelane/librelane#librelane' -- \
    --pdk-root /opt/pdk/open_pdks \
    config.json 2>&1 | tee /tmp/librelane-run.log
```

Expected: tool runs end-to-end (5–15 min on first invocation, faster after flake cache warms). Final line includes `flow completed successfully` or similar. If it complains about PDK version hash mismatch, retry with `nix run 'github:librelane/librelane#librelane' -- --pdk-root $HOME/.ciel ...` — LibreLane will fetch its own pinned PDK.

**Step 2:** Locate the newest run directory.

```fish
set RUN_DIR (ls -td /home/kim/pro/aicex/ip/lelo_gr03_sky130a/rtl/runs/*/ | head -1)
echo $RUN_DIR
```

Expected: a path like `rtl/runs/RUN_2026-04-17_<HH-MM>/`.

**Step 3:** Confirm the three critical artefacts exist.

```fish
test -f $RUN_DIR/final/mag/temp_sens.mag ; and echo "mag OK" ; or echo "MAG MISSING"
test -f $RUN_DIR/final/pnl/temp_sens.nl.v ; and echo "nl OK" ; or echo "NL MISSING"
ls $RUN_DIR/final/signoff/*.sdf | head -1
```

Expected: `mag OK`, `nl OK`, at least one SDF file listed.

**Step 4 (abort path):** If any artefact is missing, read `/tmp/librelane-run.log` and the per-step logs under `$RUN_DIR/<stepname>/`. Common causes: STA violation (see Task 8), DRC/LVS fail (see Task 8), or PDK version mismatch (see Task 6 Step 1 fallback).

**No commit.**

---

## Task 7: Record LibreLane commit SHA

The `nix run github:librelane/librelane` command floats on `main`. Record the exact revision used so CI and the colleague reviewing can reproduce.

**Step 1:** Extract the SHA from Nix's flake lock.

```fish
set LIBRELANE_SHA (nix flake metadata 'github:librelane/librelane' --json | python3 -c "import json,sys; print(json.load(sys.stdin)['locks']['nodes']['root']['inputs'] if False else __import__('json').load(open('/dev/stdin'))['revision'] if False else '')")
# Simpler:
nix flake metadata 'github:librelane/librelane' --json | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('revision') or d.get('original',{}).get('rev') or d.get('locked',{}).get('rev'))"
```

Expected: a 40-char hex SHA printed.

**Step 2:** Save it to `/tmp/librelane-sha.txt` for the PR description.

```fish
nix flake metadata 'github:librelane/librelane' --json | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('revision') or d.get('locked',{}).get('rev'))" > /tmp/librelane-sha.txt
cat /tmp/librelane-sha.txt
```

**No commit** — the SHA only lives in the PR body.

---

## Task 8: Inspect STA / DRC / LVS reports

**Step 1:** STA summary — both clocks must be clean.

```fish
grep -E "wns|tns|VIOLATED" $RUN_DIR/final/reports/signoff/*.rpt $RUN_DIR/*/reports/sta*.rpt 2>/dev/null | head -40
```

Expected: WNS and TNS values ≥ 0 on each clock. No `VIOLATED` lines. If `i_clk_osc` does not appear in the report, check `final/reports/signoff/multi_corner_sta.log` for the list of clocks actually seen.

**Step 2:** DRC.

```fish
grep -E "DRC|drc" $RUN_DIR/final_summary.log | head -5
cat $RUN_DIR/*-drc/reports/*.rpt 2>/dev/null | tail -20
```

Expected: `DRC violations: 0` or equivalent.

**Step 3:** LVS.

```fish
grep -E "LVS|lvs" $RUN_DIR/final_summary.log | head -5
grep -E "Netlists (do not )?match" $RUN_DIR/*lvs*/reports/*.rpt 2>/dev/null | head -5
```

Expected: `Netlists match`.

**Step 4 (abort path):** If any check fails, do not proceed to copy the new .mag. Consult the design doc Section 5 (Risks) for the fallback for the specific failure mode.

**No commit.**

---

## Task 9: Copy regenerated `.mag` + measure new area

**Step 1:** Copy the mag from the run output into the tracked `design/` tree.

```fish
cp $RUN_DIR/final/mag/temp_sens.mag \
   /home/kim/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_GR03_SKY130A/temp_sens.mag
```

**Step 2:** Measure the new bounding box using the same awk calc used for baseline.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
awk '
  /^rect/ {
    if($2<minx||minx=="")minx=$2;
    if($3<miny||miny=="")miny=$3;
    if($4>maxx)maxx=$4;
    if($5>maxy)maxy=$5;
  }
  END {
    w=(maxx-minx); h=(maxy-miny);
    printf "width=%.2f um  height=%.2f um  area=%.1f um^2\n", w*0.005, h*0.005, w*h*0.005*0.005
  }
' design/LELO_GR03_SKY130A/temp_sens.mag | tee /tmp/new-area.txt
```

Expected: area strictly less than 4 436 µm². If not, stop and revisit knobs (see design doc Section 5 row 6).

**Step 3:** Cell-type histogram for the new layout (helps understand what changed).

```fish
awk '/^use sky130_fd_sc_hd__/{
  gsub("sky130_fd_sc_hd__","",$2);
  n=split($2,a,"_");
  base=a[1]; for(i=2;i<n;i++) base=base"_"a[i];
  print base
}' design/LELO_GR03_SKY130A/temp_sens.mag | sort | uniq -c | sort -rn | head -20 | tee /tmp/new-cells.txt
```

Record for the PR description.

**Step 4:** Commit, embedding the area delta.

```fish
set NEW_AREA (cat /tmp/new-area.txt)
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add design/LELO_GR03_SKY130A/temp_sens.mag
git commit -m "Regenerate temp_sens.mag via LibreLane ($NEW_AREA, was 4436 um^2)"
```

---

## Task 10: Create `sim/tb_temp_sens/tb_gls.v`

**Files:**
- Create: `sim/tb_temp_sens/tb_gls.v`

**Step 1:** Write the GLS testbench.

```verilog
`timescale 1 ns / 1 ps

`ifndef WIDTH
`define WIDTH 9
`endif

module tb;

  localparam LFCLK_HALF = 15259;

  reg clk = 0;
  reg rst_n = 0;
  reg start = 0;
  wire clk_osc_w;
  reg  clk_osc;
  always @(*) clk_osc = clk_osc_w;
  wire [`WIDTH-2:0] osc_count;
  wire pwrup_osc;

  always #(LFCLK_HALF) clk = ~clk;

  integer temperature;

  osc_model u_osc (
    .PWRUP(pwrup_osc),
    .F_OUT(clk_osc_w),
    .temperature(temperature)
  );

  // Gate-level netlist DUT. Power pin connections match sky130_fd_sc_hd
  // cell conventions; LibreLane emits them on the netlist module port list.
  wire VPWR = 1'b1;
  wire VGND = 1'b0;

  temp_sens u_dut (
`ifdef USE_POWER_PINS
    .VPWR(VPWR),
    .VGND(VGND),
`endif
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_start(start),
    .i_clk_osc(clk_osc),
    .o_osc_count(osc_count),
    .o_pwrup_osc(pwrup_osc)
  );

`ifdef SDF_FILE
  initial $sdf_annotate(`SDF_FILE, u_dut);
`endif

  integer file;

  initial begin
    $dumpfile("gls.vcd");
    $dumpvars(0, tb);

    file = $fopen("gls.csv", "w");
    $fwrite(file, "temperature,count\n");

    temperature = 25;
    rst_n = 0;
    #100 rst_n = 1;
    repeat (4) @(posedge clk);

    for (temperature = -40; temperature <= 125; temperature = temperature + 1) begin
      @(posedge clk) start = 1;
      @(posedge clk) start = 0;
      repeat (5) @(posedge clk);
      $fwrite(file, "%0d,%0d\n", temperature, osc_count);
    end

    $fclose(file);
    $finish;
  end

endmodule
```

**Step 2:** Compile-check (syntax only — DUT netlist is generated fresh per run).

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
iverilog -g2012 -t null tb_gls.v 2>&1 | head -5
```

Expected: maybe a few "module temp_sens not found" style warnings (fine — it's linked at `make gls` time), no syntax errors.

**Step 3:** Commit.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add sim/tb_temp_sens/tb_gls.v
git commit -m "Add tb_gls.v: gate-level testbench with SDF annotation"
```

---

## Task 11: Extend `sim/tb_temp_sens/Makefile` with `gls` target

**Files:**
- Modify: `sim/tb_temp_sens/Makefile`

**Step 1:** Append these targets to the Makefile (keep everything already in it).

```makefile

# ------------------------------------------------------------
# Gate-level simulation with SDF back-annotation.
#   Consumes LibreLane outputs under ../../rtl/runs/<latest>/final/
# ------------------------------------------------------------
RUN_DIR := $(shell ls -td ../../rtl/runs/*/ 2>/dev/null | head -1)
NL      := $(RUN_DIR)final/pnl/temp_sens.nl.v
SDF     := $(shell ls $(RUN_DIR)final/signoff/*.sdf 2>/dev/null | head -1)
SKY130V := /opt/pdk/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/verilog
CELLS   := $(SKY130V)/primitives.v $(SKY130V)/sky130_fd_sc_hd.v

gls: fit
	@test -f $(NL)  || (echo "ERROR: netlist missing: $(NL)"; exit 1)
	@test -f $(SDF) || (echo "ERROR: SDF missing: $(SDF)"; exit 1)
	iverilog $(IVFLAGS) -DFUNCTIONAL -DSDF_FILE=\"$(SDF)\" \
	    -o gls_design $(CELLS) $(NL) osc_model.v tb_gls.v
	vvp -n gls_design
	mv gls.csv gls_$(CORNER).csv
	python3 compare_calibration.py /tmp/rtl-baseline/tb_tran_$(CORNER).csv gls_$(CORNER).csv

gls-all:
	@for c in $$(python3 fit_osc.py --list) ; do \
	    echo "=== GLS $$c ===" ; \
	    python3 fit_osc.py $$c && $(MAKE) gls CORNER=$$c || exit 1 ; \
	done
```

**Step 2:** Smoke test that the variables resolve (without running yet).

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
make -n gls CORNER=KttTtVt 2>&1 | head -5
```

Expected: output prints the iverilog command with concrete paths (no `$(...)` remaining).

**Step 3:** Commit.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git add sim/tb_temp_sens/Makefile
git commit -m "Add gls and gls-all Makefile targets with SDF back-annotation"
```

---

## Task 12: GLS + SDF on typical corner

Smoke test before full sweep.

**Step 1:** Run on the typical PVT corner first.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
make gls CORNER=KttTtVt 2>&1 | tee /tmp/gls-ktttt.log
```

Expected: compile OK, sim runs through 166 temperature points, last line from `compare_calibration.py` ends with `OK`.

**Step 2 (abort path):** If `FAIL`, inspect `gls.vcd` around the first failing temperature — usually either (a) X on a flip-flop Q due to incomplete reset (fix the testbench: longer `#100 rst_n = 1`), or (b) a real behavioural regression (stop and review the LibreLane synthesis strategy).

**No commit.**

---

## Task 13: GLS + SDF across all corners

**Step 1:** Run the full sweep.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a/sim/tb_temp_sens
make gls-all 2>&1 | tee /tmp/gls-all.log
```

Expected: 11 `=== GLS <corner> ===` blocks, each ending in an `OK` line from `compare_calibration.py`.

**Step 2:** Assert every corner passed.

```fish
grep -c " OK$" /tmp/gls-all.log
grep " FAIL$" /tmp/gls-all.log ; or echo "no failures"
```

Expected: OK count ≥ 11, `no failures`.

**Step 3:** Collect the comparison table for the PR body.

```fish
grep -E "rtl\[|gls\[" /tmp/gls-all.log | tee /tmp/gls-summary.txt
```

**No commit.**

---

## Task 14: Push branch and open draft PR

**Step 1:** Final tree check.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git status
git log --oneline main..HEAD
```

Expected: clean tree, 6–7 new commits on the branch.

**Step 2:** Push.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git push -u origin digital-layout-shrink
```

**Step 3:** Open the PR as a draft against `main`.

```fish
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
set LIBRELANE_SHA (cat /tmp/librelane-sha.txt)
set NEW_AREA (cat /tmp/new-area.txt)

gh pr create --draft --base main --title "Shrink temp_sens digital layout" --body "$(cat <<EOF
## Summary

Shrinks the synthesised \`temp_sens\` layout and adds STA coverage for the second clock domain. RTL is unchanged.

## Area

- Before: 64.33 x 68.96 um = **4 436 um^2** (562 cells)
- After: $NEW_AREA
- Cell histogram (top 20): see /tmp/new-cells.txt locally.

## Config changes

- \`CLOCK_PERIOD\`: 200 ns -> 10 000 ns (3x margin on 32.768 kHz reference)
- \`SYNTH_MAX_FANOUT\`: removed (deprecated; PDK default 10 applies)
- Added \`SDC_FILE\` pointing at new \`rtl/temp_sens.sdc\` (both clock domains + async grouping)
- \`SYNTH_DRIVING_CELL\`, \`SYNTH_BUFFER_CELL\`: forced to \`_1\` variants
- \`FP_CORE_UTIL\`: 65 (was default 50)
- \`rtl/pin_order.cfg\`: moved \`i_clk_osc\` and \`o_pwrup_osc\` from West to South to abut the COMPARATOR FF and BIAS blocks respectively.

## Tooling

- LibreLane commit: \`$LIBRELANE_SHA\`
- PDK: \`/opt/pdk/open_pdks\`

## Verification

- STA: WNS >= 0, TNS = 0 on both \`i_clk\` (10 000 ns) and \`i_clk_osc\` (500 ns).
- DRC: 0 violations.
- LVS: matches.
- RTL sim: byte-identical before/after config edit (corner sweep via \`make all-corners\`).
- GLS+SDF: peak calibration error <= RTL per corner for all 11 corners (see /tmp/gls-summary.txt).

## Out of scope

README.md intentionally untouched — active edits on main.

## Test plan

- [ ] CI \`gds.yaml\` regenerates layout from committed \`.mag\`.
- [ ] CI \`drc.yaml\` clean.
- [ ] CI \`lvs.yaml\` clean.
- [ ] Colleague merges README changes on main; rebase this branch before marking ready-for-review.
EOF
)"
```

Expected: `gh` prints the PR URL.

**Step 4:** Record the URL.

```fish
gh pr view --json url --jq .url | tee /tmp/pr-url.txt
```

**No commit** — PR metadata lives on GitHub.

---

## Acceptance checklist

All items must be green before marking the PR ready for review.

- [ ] Task 5 `diff -qr` exited clean (RTL byte-identical).
- [ ] Task 8 STA WNS/TNS ≥ 0 on both clocks; DRC 0 violations; LVS matches.
- [ ] Task 9 new area strictly < 4 436 µm².
- [ ] Task 13 all 11 corners pass GLS+SDF calibration comparison.
- [ ] Task 14 draft PR open, URL recorded.
- [ ] README.md untouched (verified via `git diff main..HEAD -- README.md` showing no output).
