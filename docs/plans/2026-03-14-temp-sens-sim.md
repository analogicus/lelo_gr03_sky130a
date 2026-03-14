# TempSens Digital Simulation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers-extended-cc:executing-plans to implement this plan task-by-task.

**Goal:** Simulate TempSens RTL end-to-end with a behavioral oscillator model fitted to SPICE data, producing calibration error plots.

**Architecture:** Python script extracts frequency-vs-temperature polynomial from existing OSCILLATOR_TB YAML data. A behavioral Verilog oscillator model uses those coefficients to generate a temperature-dependent clock. iverilog testbench sweeps -40 to 125°C, writes CSV. Python plots 1-point and 2-point calibration error to SVG.

**Tech Stack:** iverilog, Python 3 (numpy, matplotlib, PyYAML, pandas)

---

### Task 1: Create fit_osc.py — extract polynomial from YAML

**Files:**
- Create: `sim/tb_temp_sens/fit_osc.py`

**Step 1: Write fit_osc.py**

The script reads OSCILLATOR_TB YAML data, computes `freq = 4 / (t2 - t1)` for each temperature point, fits a 2nd-order polynomial, and writes `osc_params.vh`.

```python
#!/usr/bin/env python3
"""Fit oscillator freq-vs-temp from SPICE YAML data, write Verilog params."""

import re
import sys
from pathlib import Path

import numpy as np
import yaml

YAML_DIR = Path(__file__).parent / "../OSCILLATOR_TB/output_tran"
DEFAULT_CORNER = "KttTtVt"


def find_yaml(corner: str) -> Path:
    """Find the YAML file matching the given corner name."""
    for f in sorted(YAML_DIR.glob("tran_*.yaml")):
        if re.search(r"_\d+$", f.stem):
            continue
        if corner in f.stem:
            return f
    raise FileNotFoundError(f"No YAML found for corner {corner} in {YAML_DIR}")


def extract_freq(yaml_path: Path) -> tuple[np.ndarray, np.ndarray]:
    """Extract (temperatures, frequencies_Hz) from a YAML measurement file."""
    with yaml_path.open() as f:
        obj = yaml.safe_load(f)

    t1_vals, t2_vals = {}, {}
    for key, val in obj.items():
        if key.startswith("t1_"):
            t1_vals[int(key.split("_")[1])] = float(val)
        elif key.startswith("t2_"):
            t2_vals[int(key.split("_")[1])] = float(val)

    temps = sorted(t for t in t1_vals if t in t2_vals)
    freqs = [4.0 / (t2_vals[t] - t1_vals[t]) for t in temps]
    return np.array(temps, dtype=float), np.array(freqs)


def main():
    corner = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_CORNER
    yaml_path = find_yaml(corner)
    temps, freqs = extract_freq(yaml_path)
    coeffs = np.polyfit(temps, freqs, 2)

    out = Path(__file__).parent / "osc_params.vh"
    with out.open("w") as f:
        f.write(f"// Auto-generated from {yaml_path.name} (corner: {corner})\n")
        f.write(f"// Polynomial: freq = a*T^2 + b*T + c  [Hz]\n")
        f.write(f"`define OSC_COEFF_A {coeffs[0]:.6e}\n")
        f.write(f"`define OSC_COEFF_B {coeffs[1]:.6e}\n")
        f.write(f"`define OSC_COEFF_C {coeffs[2]:.6e}\n")

    print(f"Fitted {corner} ({len(temps)} points) -> {out}")
    print(f"  a={coeffs[0]:.4e}  b={coeffs[1]:.4e}  c={coeffs[2]:.4e}")


if __name__ == "__main__":
    main()
```

**Step 2: Run and verify output**

Run: `cd sim/tb_temp_sens && python3 fit_osc.py`
Expected: prints coefficients, creates `osc_params.vh` with three \`define lines.

**Step 3: Commit**

```bash
git add sim/tb_temp_sens/fit_osc.py
git commit -m "Add fit_osc.py: extract oscillator polynomial from SPICE YAML"
```

---

### Task 2: Create osc_model.v — behavioral oscillator

**Files:**
- Create: `sim/tb_temp_sens/osc_model.v`

**Step 1: Write osc_model.v**

Behavioral model that generates F_OUT at the polynomial-predicted frequency, gated by PWRUP.

```verilog
`timescale 1 ns / 1 ps
`include "osc_params.vh"

module osc_model (
    input  wire PWRUP,
    output wire F_OUT,
    input  integer temperature
);

  real freq_hz, half_period_ns;
  real t;
  reg  clk = 0;

  assign F_OUT = PWRUP & clk;

  always begin
    t = $itor(temperature);
    freq_hz = `OSC_COEFF_A * t * t + `OSC_COEFF_B * t + `OSC_COEFF_C;
    half_period_ns = 1.0e9 / (2.0 * freq_hz);
    #(half_period_ns) clk = ~clk;
  end

endmodule
```

**Step 2: Verify it compiles**

Run: `cd sim/tb_temp_sens && python3 fit_osc.py && iverilog -g2012 -c /dev/null osc_model.v -o /dev/null 2>&1 || true`
Expected: compiles without errors (may warn about no top module, that's fine).

**Step 3: Commit**

```bash
git add sim/tb_temp_sens/osc_model.v
git commit -m "Add osc_model.v: behavioral oscillator from polynomial fit"
```

---

### Task 3: Create tb.v — testbench

**Files:**
- Create: `sim/tb_temp_sens/tb.v`

**Step 1: Write tb.v**

Testbench instantiates TempSens + osc_model, sweeps temperature, writes CSV.

```verilog
`timescale 1 ns / 1 ps

module tb;

  // 32768 Hz reference clock
  localparam LFCLK_HALF = 15259; // ns (half period)

  reg clk = 0;
  reg rst = 1;
  reg start = 0;
  wire clk_osc;
  wire [7:0] osc_count;
  wire pwrup_osc;

  always #(LFCLK_HALF) clk = ~clk;

  integer temperature;

  osc_model u_osc (
    .PWRUP(pwrup_osc),
    .F_OUT(clk_osc),
    .temperature(temperature)
  );

  TempSens #(.WIDTH(8)) u_dut (
    .i_clk(clk),
    .i_rst(rst),
    .i_start(start),
    .i_clk_osc(clk_osc),
    .o_osc_count(osc_count),
    .o_pwrup_osc(pwrup_osc)
  );

  integer file;

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);

    file = $fopen("tb.csv", "w");
    $fwrite(file, "temperature,count\n");

    temperature = 25;

    // Reset sequence
    #100 rst = 0;

    // Wait a few clocks for FSM to settle in IDLE
    #(LFCLK_HALF * 4);

    // Temperature sweep
    for (temperature = -40; temperature <= 125; temperature = temperature + 1) begin
      // Trigger measurement
      @(posedge clk) start = 1;
      @(posedge clk) start = 0;

      // Wait for FSM: COUNT + WAIT + CAPTURE + back to IDLE = 4 clk edges
      repeat (5) @(posedge clk);

      $fwrite(file, "%0d,%0d\n", temperature, osc_count);
    end

    $fclose(file);
    $finish;
  end

endmodule
```

**Step 2: Compile and run**

Run: `cd sim/tb_temp_sens && iverilog -g2012 -o design osc_model.v ../../rtl/temp_sens.sv tb.v && vvp -n design`
Expected: creates `tb.csv` with 166 rows (header + -40..125).

**Step 3: Verify CSV**

Run: `head -5 sim/tb_temp_sens/tb.csv`
Expected: header row, then rows like `-40,64` with plausible count values.

**Step 4: Commit**

```bash
git add sim/tb_temp_sens/tb.v
git commit -m "Add tb.v: TempSens testbench with temperature sweep"
```

---

### Task 4: Create tb.py — plot results

**Files:**
- Create: `sim/tb_temp_sens/tb.py`

**Step 1: Write tb.py**

Reads CSV, applies 1-point and 2-point calibration, plots 4-panel SVG.

```python
#!/usr/bin/env python3
"""Plot TempSens simulation results with calibration error analysis."""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

STYLE = {"facecolor": "#fafafa"}


def main():
    df = pd.read_csv(Path(__file__).parent / "tb.csv")
    t = df["temperature"].values.astype(float)
    count = df["count"].values.astype(float)

    # Frequency = count * 32768 Hz (one ref period)
    freq = count * 32768

    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(10, 7), **STYLE)
    for ax in (ax1, ax2, ax3, ax4):
        ax.set_facecolor("#fafafa")
        ax.grid(visible=True, linewidth=0.4, alpha=0.5)
        ax.tick_params(labelsize=8)
        ax.title.set_fontsize(9)
        ax.xaxis.label.set_fontsize(8)
        ax.yaxis.label.set_fontsize(8)

    kw = {"color": "#636363", "linewidth": 1.8}

    # Panel 1: Frequency vs temperature
    ax1.plot(t, freq / 1e6, **kw)
    ax1.set_title("Frequency vs Temperature")
    ax1.set_xlabel("Temperature [°C]")
    ax1.set_ylabel("Frequency [MHz]")

    # Panel 2: 1-point calibration error (25°C)
    # Use nominal slope from linear fit, offset at 25°C
    coeffs = np.polyfit(freq, t, 1)
    f25 = np.interp(25, t, freq)
    offset_1pt = 25 - coeffs[0] * f25
    t_est_1pt = coeffs[0] * freq + offset_1pt
    ax2.plot(t, t_est_1pt - t, **kw)
    ax2.axhline(y=10, color="#cccccc", linewidth=0.8, zorder=0)
    ax2.axhline(y=-10, color="#cccccc", linewidth=0.8, zorder=0)
    ax2.set_title("Temp Error (1-pt cal, 25°C)")
    ax2.set_xlabel("Temperature [°C]")
    ax2.set_ylabel("Error [°C]")

    # Panel 3: Count vs temperature
    ax3.plot(t, count, **kw)
    ax3.set_title("Oscillator Count vs Temperature")
    ax3.set_xlabel("Temperature [°C]")
    ax3.set_ylabel("Count [LSB]")

    # Panel 4: 2-point calibration error (25°C, 85°C)
    f85 = np.interp(85, t, freq)
    slope_2pt = (85 - 25) / (f85 - f25)
    offset_2pt = 25 - slope_2pt * f25
    t_est_2pt = slope_2pt * freq + offset_2pt
    ax4.plot(t, t_est_2pt - t, **kw)
    ax4.axhline(y=5, color="#cccccc", linewidth=0.8, zorder=0)
    ax4.axhline(y=-5, color="#cccccc", linewidth=0.8, zorder=0)
    ax4.set_title("Temp Error (2-pt cal, 25°C & 85°C)")
    ax4.set_xlabel("Temperature [°C]")
    ax4.set_ylabel("Error [°C]")

    fig.tight_layout()
    svg_path = Path(__file__).parent / "../../svgs/temp_sens_measurement.svg"
    fig.savefig(svg_path, bbox_inches="tight", facecolor=fig.get_facecolor())
    print(f"Saved {svg_path}")


if __name__ == "__main__":
    main()
```

**Step 2: Run and verify SVG**

Run: `cd sim/tb_temp_sens && python3 tb.py`
Expected: creates `svgs/temp_sens_measurement.svg`.

**Step 3: Commit**

```bash
git add sim/tb_temp_sens/tb.py
git commit -m "Add tb.py: TempSens calibration error plots"
```

---

### Task 5: Create Makefile — tie it all together

**Files:**
- Create: `sim/tb_temp_sens/Makefile`

**Step 1: Write Makefile**

```makefile
CORNER ?= KttTtVt

all: fit tb plot

fit:
	python3 fit_osc.py $(CORNER)

tb: fit
	iverilog -g2012 -o design osc_model.v ../../rtl/temp_sens.sv tb.v
	vvp -n design

plot:
	python3 tb.py

clean:
	-rm -f design tb.vcd tb.csv osc_params.vh
```

**Step 2: Run full flow**

Run: `cd sim/tb_temp_sens && make clean && make`
Expected: fit prints coefficients, iverilog compiles and runs, SVG is generated.

**Step 3: Verify SVG exists**

Run: `ls -la svgs/temp_sens_measurement.svg`
Expected: file exists with recent timestamp.

**Step 4: Commit**

```bash
git add sim/tb_temp_sens/Makefile
git commit -m "Add Makefile for TempSens digital simulation flow"
```

---

### Task 6: End-to-end verification

**Step 1: Clean run**

Run: `cd sim/tb_temp_sens && make clean && make`
Expected: full pipeline succeeds.

**Step 2: Verify count values are plausible**

Check that at 25°C typical, count ≈ 116 (3.8 MHz * 30.5 µs). Check that count increases with temperature (PTAT oscillator).

**Step 3: Verify calibration errors**

- 1-point error should be within ±10°C over 0-70°C range
- 2-point error should be within ±5°C over 0-70°C range

**Step 4: Try alternate corner**

Run: `make clean && make CORNER=KffThVh`
Expected: pipeline succeeds with different frequency range.

**Step 5: Add generated files to .gitignore, commit everything**

```bash
echo "sim/tb_temp_sens/osc_params.vh" >> .gitignore
echo "sim/tb_temp_sens/design" >> .gitignore
echo "sim/tb_temp_sens/tb.vcd" >> .gitignore
echo "sim/tb_temp_sens/tb.csv" >> .gitignore
git add .gitignore sim/tb_temp_sens/
git commit -m "Complete TempSens digital simulation with calibration plots"
```
