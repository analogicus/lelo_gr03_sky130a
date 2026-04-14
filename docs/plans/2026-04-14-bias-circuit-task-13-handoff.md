# BIAS_CIRCUIT — Task 13 handoff (klayout post-processing)

> **For Claude:** This document is a complete resumption note for continuing the `BIAS_CIRCUIT` layout recipe work. Read this file first, then `docs/plans/2026-04-13-bias-circuit-layout-recipe-design.md` for the design rationale, then the `BIAS_CIRCUIT.py` recipe. **Do NOT re-investigate everything from scratch** — everything material is captured here.

**Date:** 2026-04-14
**Current git HEAD:** `49b61d9` "Revert VDD strap and res intra-stack routes; defer to klayout post-process"
**Branch:** `main`

## 1. The plan we're executing

`docs/plans/2026-04-13-bias-circuit-layout-recipe.md` (Tasks 0–16). Tasks 0–12 are done and committed. Task 13 (full connectivity sweep) is **partially done**: cicpy reaches `shorts=0` but has 6 opens (`VB_N`, `VB_P`, `net5`, `net6`, `VSS`, `VDD_1V8`). Tasks 14 (DRC) and 15 (LVS) haven't completed cleanly yet.

The design document (`docs/plans/2026-04-13-bias-circuit-layout-recipe-design.md`) has the floorplan diagram, layer rules, and the schematic → instance mapping.

## 2. The user's floorplan constraint (load-bearing, don't second-guess)

The required floorplan is:
- **res** (resistors `xa4`/`xa5`/`xa6`) at the **top** of the cell
- **pmos** (`xb7`, `xc3`, `xc4` + tap/dummy) in the middle
- **nmos** (`xb5`, `xb6`, `xc1`, `xc2` + tap) at the bottom
- **`VB_P`** exits the **left** edge of the transistor column
- **`VB_N`** exits the **right** edge of the transistor column
- Cell must be **vertical tall, horizontally narrow**

**Why:** `VB_N` and `VB_P` must have a short parent-side distance to the current mirrors they drive in other blocks. A narrow cell with both bias rails on opposite edges of the transistor column minimizes the parent-side routing length between them.

**Forbidden alternatives:** putting `res` to the left or right of the transistor column would widen the cell and blow up the `VB_N`↔`VB_P` distance. The user considered and rejected `res.abutRight(pmos)` for this reason.

## 3. Current state of `BIAS_CIRCUIT.py` (at HEAD `49b61d9`)

The recipe does the following, all clean, no shorts:

- **`beforePlace`:** sets `noPowerRoute=True`, `place_xspace=[0]`, `place_yspace=[0]`, `place_groupbreak=[3]`.
- **`afterPlace`:** creates three `CellGroup`s (`res`, `pmos`, `nmos`) containing five `StackGroup`s (`res_stack`, `pmos_xc`, `pmos_xb`, `nmos_xc`, `nmos_xb`). Uses `abutLeft` to swap so `xc` is left of `xb` in both pmos and nmos (this is what puts the matched NCH pair `xb6↔xc2` horizontally adjacent). Calls `addTaps()` on all four transistor stacks. **Does NOT call `fillDummyTransistors`** — cicpy's dummy terminal routing created a 1394-rect M1 short merging 7 nets in Task 13. Uses `abutTop` for vertical stacking (`pmos` above `nmos`, `res` above `pmos`).
- **`beforeRoute`:** draws `addRouteRing("M1", "VDD_1V8", "t", ...)` and `addRouteRing("M1", "VSS", "b", ...)`, and `addPowerConnection("VSS", "^x[bc]\d+$", "bottom")`. The VDD `addPowerConnection` is intentionally omitted because any cicpy-drawn M1 strap from pmos up to the top VDD ring crosses `res`'s locali bulk frames (labeled VSS) and creates a cell-spanning short. Signal routes: `VB_N` orthogonal in nmos group (`track0`), `VB_P` local `||` strap scoped to `xc3`, `PWRUP_1V8` in nmos at `track2`, `PWRUP_N_1V8` in pmos at `track2`, `net2`/`net3` intra-nmos-stack at `track4`, `net4` intra-pmos-stack at `track4`, and the cross-group `net1` (`xa6↔xb7`) on `M4/M3` at `track0`.
- **`afterPorts`** (NOTE: hook is `afterPorts`, NOT `afterPaint`): exposes `VB_P`, `PWRUP_1V8`, `PWRUP_N_1V8` on the left edge and `VB_N` on the right edge, all on `M3` with `|-`/`-|` U-routes and tracks `track0`/`track2`/`track4`/`offset_track0`.

## 4. What's wrong and why (root cause analysis)

The `cicpy sch2mag` build produces `shorts=0`, but `OPT=--check-connectivity` reveals six opens. Three distinct root causes:

### 4.1 Diode-connected gate/drain split (`VB_N`, `VB_P`)

`xc3` (PCH diode, gate=drain=`VB_P`), `xb6` (NCH diode, gate=drain=`VB_N`), `xc2` (NCH cascode whose gate is `VB_N`) all expose their gate on `met1` (cicpy `M2`) and their drain on `li1` (cicpy `M1`). cicpy's `addConnectivityRoute` with a single layer only connects rectangles on that one layer. The orthogonal route with `accessLayer="M1"` does better but sometimes collides with neighbouring routes (notably `PWRUP_N_1V8` in pmos at the same y).

**Fix in post-process:** at each diode device, place a small `met1` (cicpy `M2`) patch plus a `mcon` (`met1↔li1`) via right at the device corner to bridge the gate and drain labels. Magic will merge them on extraction.

### 4.2 Resistor internal nets (`net5`, `net6`)

The three poly resistors (`xa4`/`xa5`/`xa6`) have their terminals on `li1`. Their internal shared nets `net5` (between `xa5` and `xa6`) and `net6` (between `xa4` and `xa5`) need metal bridges, but:
- `addConnectivityRoute("M2", ..., "||")` draws nothing because resistor terminals aren't on `M2`.
- `addConnectivityRoute("M1", ..., "||")` shorts to the resistor body frame (also labeled `VSS` on `li1` inside the resistor cell).
- `addOrthogonalConnectivityRoute("M2", "M3", ..., accessLayer="M1")` works for `net5` at `track0` but for `net6` (at `track0` or `track-4` or `track2`) it collides with the `VB_N` right-edge port extension from nmos.

**Fix in post-process:** bridge `net5` and `net6` on `met1` by drawing a small rectangle between the two adjacent resistor `N`/`P` label positions, with `licon1` vias at each endpoint.

### 4.3 VDD strap collides with `res` locali bulk frames

`res` (all three poly resistors) has `li1` rectangles labeled `B=VSS` (the resistor body tie). When `addPowerConnection("VDD_1V8", ..., "top")` is called, cicpy draws an `li1` vertical strap from each pmos source up to the top `VDD_1V8` ring — that strap physically overlaps `res`'s `li1` VSS bulk frames. Magic then sees one merged component containing `VDD_1V8` and `VSS`.

Attempted cicpy fixes:
- Move VDD ring to `M2` (met1) — shifts the collision onto other signal routes on the same layer.
- Move VDD ring to `M5` (met4) — VDD ring itself is isolated but the via stack from pmos source still crosses intermediate layers.
- `addRouteConnection(..., "M4", "top", ...)` — route builder auto-adds `fillvcut` which stuffs the via column across `PWRUP_N_1V8`'s M3 trunk.

**Fix in post-process:** draw the VDD strap on `met1` (cicpy `M2`, the layer `res` does NOT use) from each pmos source at a chosen `x` up to the top `VDD_1V8` ring, with `mcon`/`licon1` vias at the source end. The strap crosses res's bbox on a layer res doesn't occupy, so no short.

### 4.4 Bonus: the `VB_N` boundary port label is in the wrong place

`addPortOnEdge("M3", "VB_N", "right", "-|", "offset_track0")` places the port label on `met2` at `(22120, 46300)` (dbu, with `dbu=0.001 µm`). That's in the **resistor y-range**, not on the actual `met2` `VB_N` route in nmos. So the port label is floating in space rather than riding on the signal trunk. LVS sees it as a component disconnected from the rest of `VB_N`.

**Fix in post-process:** delete the stray `met2` `VB_N` label at `(22120, 46300)` and re-place it on one of the existing met2 rectangles in the nmos `VB_N` route (somewhere on the right-hand side of the nmos group, near `xb6`).

## 5. Current verification state

Run from `lelo_gr03_sky130a/work/`:

```bash
make mag CELL=BIAS_CIRCUIT OPT=--check-connectivity
```

Expected output (at HEAD `49b61d9`):

```
INFO: Route short report for BIAS_CIRCUIT: shorts=0 components=54 shapes=2811
INFO: Connectivity report for BIAS_CIRCUIT: shorts=0 opens=6 components=54 shapes=2811
WARNING: OPEN net=VB_N split_components=[11, 2362]
WARNING: OPEN net=net6 split_components=[10, 142]
WARNING: OPEN net=VSS split_components=[3, 135, 333, 1350]
WARNING: OPEN net=net5 split_components=[143, 341]
WARNING: OPEN net=VDD_1V8 split_components=[1100, 2052, 2229, 2243]
WARNING: OPEN net=VB_P split_components=[1592, 1782, 1818]
```

```bash
make drc CELL=BIAS_CIRCUIT
```
Expected: **DRC FAIL — 18 errors** (n-well spacing, poly/tap spacing, li spacing, layer overlap). These are separate from the connectivity issues and will need their own fix pass after LVS is clean.

```bash
make cdl lvs CELL=BIAS_CIRCUIT
```
Expected: **LVS FAIL**. Each of the opens above translates into a real LVS mismatch (device fanout wrong, port missing, etc).

**Note on VSS:** the cicpy connectivity check reports `VSS split_components=[3, 135, 333, 1350]` (4 components), but **Berkeley netgen LVS actually reports VSS as matching** (`JNWATR_NCH_4C5F0/B=2, JNWATR_NCH_8C1F2/S=2, JNWATR_NCH_8C1F2/B=2, JNWTR_RPPO4/B=1, sky130_fd_pr__res_high_po/3=1`). Magic's extractor merges `VSS`-labeled rectangles via label propagation even when they are not geometrically connected to the ring. So `VSS` is NOT a blocker for LVS; only the other five opens are.

`VDD_1V8` does NOT get the same label-propagation treatment — its extraction shows up as `xa6/XA1/a_828_1800#` (an auto-generated hierarchical name) because the `li1` geometry inside the pmos source subcells doesn't bubble up to a `VDD_1V8`-labeled top-level rect. This is why `VDD_1V8` IS a blocker.

## 6. Tooling set up during this session

### 6.1 Berkeley netgen LVS (built from source)

- **Source:** cloned from `https://github.com/RTimothyEdwards/netgen` to `/tmp/netgen-lvs`
- **Build:** `CFLAGS="-std=gnu89 -fcommon -Wno-error -I. -I.." CPPFLAGS="-I. -I.." ./configure --prefix=$HOME/.local && make -j$(nproc) && make install`
- **Installed to:** `$HOME/.local/bin/netgen` (shadows `/usr/bin/netgen` which is the Vienna 3D mesh tool)
- **Version:** Netgen 1.5.318 compiled 2026-04-14
- **Works with:** `make cdl lvs CELL=BIAS_CIRCUIT` from `work/`
- **Note:** The `-std=gnu89` flag is required because GCC 15 treats empty `()` function declarations as `(void)`, whereas the netgen source uses them as K&R-style "unspecified arguments".

### 6.2 klayout (already installed via Arch)

- **Version:** klayout 0.30.7 at `/usr/bin/klayout` (pacman package `extra/klayout`)
- **Python API:** `pya` module built into the klayout interpreter — usable ONLY inside `klayout -b -r script.py`, not from the uv venv's python
- **Batch invocation:** `klayout -b -r /path/to/script.py` from inside `lelo_gr03_sky130a/work/` so relative paths like `gds/BIAS_CIRCUIT.gds` resolve correctly
- **Tested:** yes, `import pya; ly = pya.Layout(); ly.read("gds/BIAS_CIRCUIT.gds")` all work

## 7. GDS layer map (sky130A)

From `klayout -b -r work/explore_gds.py` against the current `BIAS_CIRCUIT.gds`:

| Layer/datatype | sky130 name | Use in this cell |
|---|---|---|
| `64/20` | `nwell` | PCH well regions |
| `65/20` | `diff` | Diffusion |
| `66/20` | `poly` | Gates, poly resistor bodies |
| `66/44` | `licon1` | Contact poly/diff → li1 |
| `67/20` | `li1` (cicpy `M1`) | Local interconnect, **VSS/VDD rings**, resistor bulk frames, transistor bulks |
| `67/5` | `li1.label` | Text labels on li1 (VDD_1V8, VSS, B, N, P) |
| `67/44` | `li1.pin` | Pin shapes on li1 |
| `67/16` | (?) | Used by sky130 pin rendering |
| `68/20` | `met1` (cicpy `M2`) | Transistor G/D/S port rectangles, most signal routes |
| `68/5` | `met1.label` | Text labels on met1 (G, D, S) |
| `68/44` | `met1.pin` | Pin shapes on met1 |
| `69/20` | `met2` (cicpy `M3`) | Horizontal signal trunks (VB_N, VB_P, PWRUP), edge-port rectangles |
| `69/5` | `met2.label` | Text labels on met2 (VB_P, VB_N, PWRUP_1V8, PWRUP_N_1V8) |
| `69/44` | `met2.pin` | Pin shapes on met2 |
| `70/20` | `met3` (cicpy `M4`) | Cross-group vertical trunks (`net1`) |
| `70/44` | `met3.label` | (not used in this cell) |
| `235/4` | sky130 PR (placement) | Cell boundary |

Via layer numbers (from sky130 tech):
- `66/44` — `licon1` (contact to li1 from diff/poly, 0.17 µm square)
- `67/44` — `mcon` (contact li1 → met1, 0.17 µm square)
- `68/44` — `via` (met1 → met2)
- `69/44` — `via2` (met2 → met3)
- `70/44` — `via3` (met3 → met4)

(The naming of the label/pin datatypes `:5` and `:16` vs the contact/pin datatypes `:44` is a sky130 convention; confirm via `/opt/pdk/open_pdks/sky130/sky130A/libs.tech/klayout/tech/sky130A.lyp` before writing to them.)

## 8. Known subcell port locations (for post-process coordinate math)

From `klayout -b -r work/explore_ports.py` (all in dbu = 0.001 µm, **relative to subcell origin**):

**Transistor cells (`JNWATR_NCH_*`, `JNWATR_PCH_*`):**
- `B` (bulk/body) label on `li1` at `(0, 2000)`
- `G` (gate) label on `met1` at `(960, 2000)`
- `D` (drain) label on `met1` at `(5120, 400)` for 8C1F2 devices and `(3840, 400)` for 4C5F0 devices
- `S` (source) label on `met1` at `(1920, 3200)`

**Resistor cells (`JNWTR_RPPO4`, `JNWTR_RPPO16`):**
- `N` (neg terminal) label on `li1` at `(2540, 15200)` for RPPO4, `(540, 13200)` for the inner RES16
- `P` (pos terminal) label on `li1` at `(6860, 15200)` for RPPO4, `(17820, 13200)` for the inner RES16
- `B` (bulk, VSS) label on `li1` at `(4700, 360)` for RPPO4, `(11180, 360)` for RPPO16

**Top-level labels at HEAD `49b61d9`:**
- `VDD_1V8` on `li1.label` at `(11660, 83750)` (center of top ring)
- `VSS` on `li1.label` at `(11660, 450)` (center of bottom ring)
- `PWRUP_1V8` on `met2.label` at `(-440, 5900)` (left edge)
- `PWRUP_N_1V8` on `met2.label` at `(-1040, 20700)` (left edge)
- `VB_P` on `met2.label` at `(480, 8300)` (left edge, actually slightly inside)
- `VB_N` on `met2.label` at `(22120, 46300)` **← WRONG Y POSITION, should be in nmos range**

**Instance bounding boxes in top cell (dbu):**
```
JNWATR_NCH_8C1F2 xb5 @ (-125, 3575; 8125, 8225)
JNWATR_NCH_8CTAPBOT    @ (-125, 1500; 8125, 4225)
JNWATR_NCH_8C1F2 xc1 @ (8915, 3575; 17165, 8225)
JNWATR_NCH_8CTAPBOT    @ (8915, 1500; 17165, 4225)
JNWATR_NCH_4C5F0 xb6 @ (-125, 7575; 6845, 12225)
JNWATR_NCH_8CTAPTOP    @ (-125, 11575; 8125, 14300)
JNWATR_NCH_4C5F0 xc2 @ (8915, 7575; 15885, 12225)
JNWATR_NCH_8CTAPTOP    @ (8915, 11575; 17165, 14300)
JNWATR_PCH_4CTAPBOT    @ (-440, 15660; 7160, 19340)
JNWATR_PCH_8CTAPBOT    @ (8600, 15660; 17480, 19340)
JNWATR_PCH_4C5F0 xc3 @ (-440, 18060; 7160, 23340)
JNWATR_PCH_8C1F2 xc4 @ (8600, 18060; 17480, 23340)
JNWATR_PCH_8CTAPTOP    @ (8600, 22060; 17480, 25740)
JNWATR_PCH_4CTAPTOP    @ (-440, 26060; 7160, 29740)
JNWATR_PCH_8C1F2 xb7 @ (-440, 22060; 8440, 27340)
JNWTR_RPPO4   xa4 @ (355, 30975; 10005, 48425)
JNWTR_RPPO16  xa5 @ (355, 48175; 22965, 65625)
JNWTR_RPPO16  xa6 @ (355, 65375; 22965, 82825)
```

Note: I listed them in the natural schematic-instance order but the actual klayout ordering is by instance list. The bounding boxes are what matters.

⚠️ **The instance labels above assume a specific mapping from the klayout iteration order to schematic instance names. This must be verified by the post-process script — iterate the cell's `each_inst()` and correlate to schematic by either (a) instance `name` property, or (b) matching cell_name + x/y against the cicpy placement log.** The cicpy placement log in the build output shows lines like `INFO: addInstance(cktInst=xb5, cellName=JNWATR_NCH_8C1F2 x=..., y=...)` that can be parsed.

## 9. The klayout post-processing script — concrete TODO list

The goal is a script that takes `work/gds/BIAS_CIRCUIT.gds` as input and writes a repaired GDS (or directly edits the `.mag`) that is LVS-clean. The script should be deterministic and re-runnable.

### 9.1 File layout

- **Script location:** `work/post_process.py`. It's inside `work/` which is gitignored, so force-add with `git add -f work/post_process.py` when committing.
- **Driver Makefile target:** add a `postmag:` target in `work/Makefile` that runs `klayout -b -r post_process.py` after `make mag`. The full pipeline becomes `make mag postmag CELL=BIAS_CIRCUIT`.
- **Output:** the script should write `work/gds/BIAS_CIRCUIT_post.gds` and also re-import it into `../design/LELO_GR03_SKY130A/BIAS_CIRCUIT.mag` via a Magic Tcl step. Alternatively, edit the `.mag` directly — `.mag` is a text format and klayout also supports writing it via `pya.Layout.write("...", opts)` with Magic format options.

### 9.2 Required repairs (priority order)

**Priority 1 — VDD strap (blocking LVS).**

For each pmos instance in `{xb7, xc3, xc4}`:
1. Compute the absolute position of its `S` (source) port via the instance transform applied to the internal port coordinate `(1920, 3200)`. That's the `met1` source label; the underlying `met1` rectangle is nearby.
2. Read the pmos source rect on `met1` (layer 68/20) via `cell.begin_shapes_rec(met1_layer).each()` filtered by overlap with the instance bbox.
3. Draw a `met1` rectangle from the source rect up to `y = 83750` (the VDD ring y-center, see label position). Width ≈ 160 nm (one met1 minimum width).
4. Place `mcon` via (layer 67/44, or whatever sky130's via layer is) at both endpoints: one at the source to bridge `met1→li1`, one at the VDD ring to bridge `met1→li1` (the VDD ring is on `li1`).
5. Add a `met1.label` text `"VDD_1V8"` on the new strap.

**Caveat:** the strap must not hit the `res` bbox on `met1`, but since `res` doesn't use `met1` (only `li1` for its terminals and bulk), any x-position is fine. Check this by grepping the instance `RPPO16`/`RPPO4` cells for met1 shapes — there should be none.

**Priority 2 — Diode gate/drain bridges (blocking LVS for VB_N, VB_P).**

For each of `xc3`, `xb6`, `xc2`:
1. Compute absolute positions of the `G` port (cell-relative `(960, 2000)` on `met1`) and the `D` port (cell-relative `(5120, 400)` or `(3840, 400)` on `met1`) via the instance transform.
2. Draw a short `met1` rectangle connecting them (straight horizontal if they share a y, or an L-shape if not — given the port coords, they're at different y, so an L or a simple vertical met1 between them).
3. Add a `met1.label` text with the net name (`"VB_P"` for xc3, `"VB_N"` for xb6 and xc2). Even if labels already exist elsewhere, an explicit label on the new rect helps Magic merge them.

For `xc2` specifically: only the **gate** is `VB_N` (not the drain, which is `VB_P`). Re-read the schematic — `xc2` node list is `[VB_P, VB_N, net3, VSS]` = `[drain, gate, source, bulk]`. So `xc2` is NOT a diode-connected device; its gate `VB_N` is driven from elsewhere. The fix is: bridge `xc2.G` to the `VB_N` route on `met2` somewhere, not `xc2.G` to `xc2.D`.

For `xb6`: node list `[VB_N, VB_N, net2, VSS]` = `[drain, gate, source, bulk]` — YES, diode-connected. Bridge gate ↔ drain on `met1`.

For `xc3`: node list `[VB_P, VB_P, net4, VDD_1V8]` = `[drain, gate, source, bulk]` — YES, diode-connected. Bridge gate ↔ drain on `met1`.

So: 2 true diode bridges (`xc3`, `xb6`) + 1 "connect gate to existing VB_N route" fix for `xc2`.

**Priority 3 — Resistor internal nets `net5` and `net6` (blocking LVS for resistor instances).**

Schematic:
- `xa4` RPPO4: nodes `[VB_N, net6, VSS]` = `[N terminal, P terminal, B]` — `VB_N` is on the N terminal (left side of resistor), `net6` on the P terminal.
- `xa5` RPPO16: nodes `[net5, net6, VSS]` = `[N, P, B]`
- `xa6` RPPO16: nodes `[net5, net1, VSS]` = `[N, P, B]`

So: `net6` connects `xa4.P` and `xa5.P`. `net5` connects `xa5.N` and `xa6.N`.

For each bridge:
1. Get the two absolute label positions. For `net6`: `xa4.P@(6860,15200)` + `xa5.P@(17820,13200)`. These are on `li1`.
2. Draw a `met1` rectangle spanning both x positions at a suitable y (between the two labels' y values).
3. Place `mcon` vias at both endpoints to bridge `met1→li1`.
4. Add `met1.label` text for the net name.

Caveat: draw the `met1` bridge *above* or *below* the resistor body on `met1` so it doesn't conflict with anything. Since `res` doesn't use `met1`, there's free vertical space inside the res bbox on met1.

**Priority 4 — Re-place `VB_N` right-edge port label.**

The `met2.label` `VB_N` at `(22120, 46300)` is in the resistor area, disconnected from the actual `VB_N` `met2` route in nmos. Fix:
1. Delete the stray label at `(22120, 46300)`.
2. Find the existing nmos `VB_N` `met2` horizontal trunk — search for `met2` rectangles whose net (by label in the underlying extraction) is `VB_N`, and pick the rightmost one near the nmos y-range (y ≈ 7575–12225 per `xc2`/`xb6` bboxes).
3. Place a new `met2.label` `"VB_N"` at a coordinate on that rect near the cell's right edge (x ≈ 17165 or similar, y somewhere in 7575–12225).

### 9.3 Output and verification

After writing the repaired GDS/mag:
1. Run `make cdl lvs CELL=BIAS_CIRCUIT` — expect LVS to pass with at most cosmetic warnings.
2. Run `make drc CELL=BIAS_CIRCUIT` — expect DRC to still fail with the 18 violations (those are Task 14's scope, not Task 13's).
3. Commit `work/post_process.py` (force-add), the `postmag` Makefile target, and the repaired `.mag` **only if** the cic/mag policy allows (the project currently tracks the `.mag` from commit `9db9142`, so a new commit is consistent).

## 10. Gotchas and pitfalls

1. **`afterPaint` vs `afterPorts`.** `cicpy/docs/pycell.md` lists only `afterPaint` as the post-paint hook but the actual cicpy source at `cicpy/src/cicpy/core/layoutcell.py:1438` adds an **undocumented** `afterPorts(layout)` hook that runs *after* `addAllPorts()`. Port APIs like `addPortOnEdge` must live in `afterPorts`, NOT `afterPaint` — otherwise cicpy prints `ERROR: <name> not a port` for each call and silently drops them. Memory: `project_cicpy_hook_order.md`.

2. **Layer naming conflict.** cicpy's `M1` is Magic's `locali` (sky130's `li1`), cicpy's `M2` is Magic's `metal1` (sky130's `met1`), etc. The one-off offset catches everyone. Memory: `project_cicpy_pycell_api.md` + `reference_layout_lecture_pdf.md`.

3. **`addPowerConnection` layer.** The strap layer is inherited from the ring layer; there is no layer override parameter in `addPowerConnection`. If you need a different layer you must use `addRouteConnection` or draw the strap manually. `addRouteConnection` with `location="top"` automatically appends `onTopB,fillvcut` to the options, which stuffs a vertical via column across any M3 route at the same x — don't use it for power straps through crowded areas.

4. **`addConnectivityRoute` silently drops.** If no rectangles match the regex on the given layer inside the scope, the call logs nothing useful and simply draws nothing. Verify by counting `net=<name>` log lines after calling.

5. **`addOrthogonalConnectivityRoute` on a 1- or 2-device net.** The M3 horizontal trunk extends to cover ALL matching rectangles within the `includeInstances` scope. For `VB_P` at `xc3` the trunk spans the device's gate-to-drain bounding box, but for `PWRUP_N_1V8` the trunk spans from `xc4` to `xb7` — horizontally crossing the whole pmos group. If a 2-device net's trunk crosses a 1-device net's trunk at the same y, they short. Track numbers don't always help because the trunk y is anchored to the terminal positions, not the track offset.

6. **Track tuning is limited.** `track0` through `track-4` to `track6` shift the trunk in `ROUTE.horizontalgrid` increments but are clipped to stay inside the group's bbox. If the only collision-free y is outside the group, no track value helps.

7. **`fillDummyTransistors + routeDummyDevices` is unsafe for narrow groups.** The dummy routing creates M1 (locali) bars across the entire group width and wires them to adjacent net labels, causing a 1000+ rect cell-spanning short. For `BIAS_CIRCUIT`'s pmos group we explicitly do NOT call it; the `pmos_xb` stack is left one device short of `pmos_xc`. DRC may complain about uneven stack heights — that's Task 14's problem.

8. **Regenerated `.cic`/`.mag` artifacts.** These files are tracked from commit `9db9142` but get rewritten on every `make mag`. Don't stage them in commits unless the commit is intentionally updating the layout snapshot. The plan's discipline is: commit `.py` and Makefile changes only; leave regenerated `.cic`/`.mag` in the working tree dirty.

9. **`work/` is gitignored.** `work/Makefile` is already tracked so `git add -u work/Makefile` works, but any NEW file in `work/` (like `post_process.py`, `explore_gds.py`, `explore_ports.py`) needs `git add -f`.

10. **`docs/plans/` is gitignored** but the existing design docs there (2026-03-14-*, 2026-04-13-*) are tracked from before the rule was added. Use `git add -f` for new files in `docs/plans/`.

## 11. Relevant files (read these in this order when resuming)

1. **This file** — `docs/plans/2026-04-14-bias-circuit-task-13-handoff.md`
2. **Design doc** — `docs/plans/2026-04-13-bias-circuit-layout-recipe-design.md`
3. **Implementation plan** — `docs/plans/2026-04-13-bias-circuit-layout-recipe.md` (Tasks 0–16)
4. **Current recipe** — `design/LELO_GR03_SKY130A/BIAS_CIRCUIT.py` at HEAD `49b61d9`
5. **Schematic** — `design/LELO_GR03_SKY130A/BIAS_CIRCUIT.sch` (xschem)
6. **Sister recipe (reference)** — `../lelo_temp_sky130a/design/LELO_TEMP_SKY130A/LELOTEMP_CMP.py`
7. **cicpy pycell API** — `../cicpy/docs/pycell.md`
8. **cicpy routes API** — `../cicpy/tests/routes/routes.md`
9. **cicpy CellGroup source** — `../cicpy/src/cicpy/core/cellgroup.py`
10. **cicpy hook dispatch** — `../cicpy/src/cicpy/core/layoutcell.py` lines 1408–1438
11. **sky130 tech file** (for layer numbers) — `/opt/pdk/open_pdks/sky130/sky130A/libs.tech/klayout/tech/sky130A.lyp`

## 12. Exploration scripts (save these)

The following scripts were written during this session for inspecting the GDS. They're in `work/` (gitignored) — consider copying their content into the handoff or force-adding them.

**`work/explore_gds.py`** — prints top-cell bbox, layer list, shape counts per layer, top-level instances with bboxes. Run with `klayout -b -r work/explore_gds.py` from `lelo_gr03_sky130a/work/`.

**`work/explore_ports.py`** — prints all label rectangles across all cells, grouped by layer. Useful for finding subcell port coordinates.

Both scripts are short (~30 lines each) and reusable for the post-process development.

## 13. Active memory entries (`/home/kim/.claude/projects/-home-kim-pro-aicex-ip-lelo-gr03-sky130a/memory/`)

- `feedback_proper_planning.md` — use brainstorming + writing-plans for non-trivial work
- `feedback_no_rotation.md` — no 90° rotation of transistors or resistors
- `reference_python_venv.md` — uv venv at `ip/aic/`
- `reference_layout_lecture_pdf.md` — ECEN474 lecture PDF is canonical layout reference
- `project_cicpy_pycell_api.md` — cicpy pycell API is real after 2026-04-13 git pull
- `project_cicpy_hook_order.md` — cicpy has undocumented `afterPorts` hook; `addPortOnEdge` must live there

TODO: add a new memory entry after the klayout script work is done:
- `project_klayout_post_process.md` — the klayout pya API is the escape hatch when cicpy's routing can't handle a floorplan constraint; access via `klayout -b -r script.py` (not uv venv python); pattern is "cicpy does clean structural work, klayout post-processes specific repairs".

## 14. Git commit summary of this work

| SHA | Message |
|---|---|
| `da476ba` | Add mag target to BIAS_CIRCUIT work Makefile |
| `2f581b1` | Create BIAS_CIRCUIT.py with data dict for resetOrigins |
| `edd4348` | Add beforePlace flags to BIAS_CIRCUIT.py |
| `ca69e94` | Add afterPlace group/stack hierarchy for BIAS_CIRCUIT |
| `6c0947d` | Rename layout._scopes to layout._route_scopes for sister-recipe parity |
| `1faa460` | Swap xc/xb columns in BIAS_CIRCUIT so xc is on the left |
| `0c89dc4` | Add taps and dummy fill to BIAS_CIRCUIT stacks |
| `57f20cf` | Stack BIAS_CIRCUIT groups vertically (res top, pmos mid, nmos bot) |
| `a70460e` | Add VDD/VSS power rings and connections to BIAS_CIRCUIT |
| `b1ac5d7` | Remove unused s local from beforeRoute in BIAS_CIRCUIT.py |
| `bdc82b1` | Route VB_N across nmos group in BIAS_CIRCUIT |
| `91d2c2a` | Route VB_P in pmos group of BIAS_CIRCUIT |
| `604864d` | Route PWRUP_1V8 and PWRUP_N_1V8 in BIAS_CIRCUIT |
| `8edf651` | Route net1 from res chain to pmos PWRUP in BIAS_CIRCUIT |
| `a8ea4fa` | Add afterPorts boundary ports to BIAS_CIRCUIT (VB_P/VB_N/PWRUP) |
| `aaa338d` | WIP snapshot: drop fillDummyTransistors, filter power, add intra-stack routes |
| `af09785` | Task 13 milestone: shorts=0, 4 opens remain |
| `c1a9786` | Task 13: shorts=0, VB_N port back, net6 uses local M2 strap |
| `f47488c` | Task 13 WIP: restore VDD addPowerConnection to let Magic/LVS extract |
| `49b61d9` | **[CURRENT HEAD]** Revert VDD strap and res intra-stack routes; defer to klayout post-process |

## 15. First action on resume

```bash
cd /home/kim/pro/aicex/ip/lelo_gr03_sky130a
git log --oneline -5   # confirm HEAD is 49b61d9
cd work
make mag CELL=BIAS_CIRCUIT OPT=--check-connectivity   # confirm shorts=0, opens=6
make cdl lvs CELL=BIAS_CIRCUIT || true                 # confirm LVS failure with known mismatches
ls -la $HOME/.local/bin/netgen                         # confirm Berkeley netgen still installed
which klayout                                          # confirm klayout still installed
```

Then write `work/post_process.py` per Section 9, iterate on each priority fix in Section 9.2, verify with `make cdl lvs`, and commit.

**Do NOT** re-investigate cicpy routing API, don't re-explore the GDS structure, don't re-derive the layer map, don't re-try `addPowerConnection` with different layers — all of that is captured above and the answer is "klayout post-process is the right tool for this."

Good luck, future me.
