# TempSens Digital Improvements Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers-extended-cc:executing-plans to implement this plan task-by-task.

**Goal:** Implement three digital improvements (dual-edge counting, IIR averaging, curvature correction) to the temperature sensor and benchmark each against the baseline to measure actual error reduction.

**Architecture:** Each RTL improvement is controlled by a parameter (`DUAL_EDGE`, `IIR_SHIFT`) so configurations can be toggled independently. Curvature correction lives in the calibration script (`tb.py`). A benchmark system runs all configurations across all process corners and generates a comparison plot.

**Tech Stack:** SystemVerilog (iverilog), Verilog testbench, Python (numpy, matplotlib, pandas)

---

### Task 0: Capture baseline metrics

**Files:**
- Run: `sim/tb_temp_sens/Makefile` (existing `all-corners` target)

**Step 1: Run baseline simulation across all corners**

```bash
cd sim/tb_temp_sens
make clean && make all-corners
```

**Step 2: Save baseline output for comparison**

```bash
cp -r output output_baseline
```

**Step 3: Note baseline error values from the generated SVG**

Check `svgs/temp_sens_measurement.svg` for current 1-pt and 2-pt calibration errors.

---

### Task 1: Implement dual-edge counting in RTL

**Files:**
- Modify: `rtl/temp_sens.sv`

**Step 1: Add DUAL_EDGE parameter and dual-edge counter logic**

Add `parameter bit DUAL_EDGE = 0` to the module. Replace the single counter with a generate block:

```systemverilog
// --- Section: Oscillator edge counter ---
generate
  if (DUAL_EDGE) begin : g_dual
    logic [WIDTH-2:0] cnt_r, cnt_f;

    always_ff @(posedge i_clk_osc, posedge cnt_rst) begin
      if (cnt_rst)          cnt_r <= '0;
      else if (o_pwrup_osc) cnt_r <= cnt_r + 1'b1;
    end

    always_ff @(negedge i_clk_osc, posedge cnt_rst) begin
      if (cnt_rst)          cnt_f <= '0;
      else if (o_pwrup_osc) cnt_f <= cnt_f + 1'b1;
    end

    assign count = {1'b0, cnt_r} + {1'b0, cnt_f};
  end else begin : g_single
    always_ff @(posedge i_clk_osc, posedge cnt_rst) begin
      if (cnt_rst)          count <= '0;
      else if (o_pwrup_osc) count <= count + 1'b1;
      else                  count <= count;
    end
  end
endgenerate
```

The `count` wire is declared at module scope so both generate branches and the capture logic can reference it.

**Step 2: Verify compilation**

```bash
cd sim/tb_temp_sens
iverilog -g2012 -o design osc_model.v ../../rtl/temp_sens.sv tb.v
```

Expected: compiles without errors.

---

### Task 2: Implement IIR averaging in RTL

**Files:**
- Modify: `rtl/temp_sens.sv`

**Step 1: Add IIR_SHIFT parameter and IIR filter logic**

Add `parameter int IIR_SHIFT = 0` to the module. Replace the capture register with a generate block:

```systemverilog
// --- Section: Capture register with optional IIR ---
generate
  if (IIR_SHIFT > 0) begin : g_iir
    localparam int ACC_W = WIDTH + IIR_SHIFT;
    logic [ACC_W-1:0] acc;
    logic signed [ACC_W:0] delta;

    always_ff @(posedge i_clk, posedge i_rst) begin
      if (i_rst) begin
        acc <= '0;
      end else if (cur_state == CAPTURE) begin
        delta = $signed({1'b0, count, {IIR_SHIFT{1'b0}}}) - $signed({1'b0, acc});
        acc <= $unsigned($signed({1'b0, acc}) + (delta >>> IIR_SHIFT));
      end
    end

    assign o_osc_count = acc[ACC_W-1:IIR_SHIFT];
  end else begin : g_no_iir
    always_ff @(posedge i_clk, posedge i_rst) begin
      if (i_rst)                      o_osc_count <= '0;
      else if (cur_state == CAPTURE)  o_osc_count <= count;
      else                            o_osc_count <= o_osc_count;
    end
  end
endgenerate
```

The IIR uses fixed-point arithmetic with IIR_SHIFT fractional bits. Output is the integer part of the accumulator.

**Step 2: Verify compilation with IIR enabled**

```bash
iverilog -g2012 -DIIR_SHIFT=2 -o design osc_model.v ../../rtl/temp_sens.sv tb.v
```

---

### Task 3: Update testbench for parameterized configurations

**Files:**
- Modify: `sim/tb_temp_sens/tb.v`

**Step 1: Add preprocessor defaults and parameterized DUT**

Add at top of tb.v:
```verilog
`ifndef WIDTH
`define WIDTH 8
`endif
`ifndef DUAL_EDGE
`define DUAL_EDGE 0
`endif
`ifndef IIR_SHIFT
`define IIR_SHIFT 0
`endif
`ifndef IIR_WARMUP
`define IIR_WARMUP 0
`endif
`ifndef JITTER_PS
`define JITTER_PS 0
`endif
```

Change DUT instantiation to:
```verilog
wire [`WIDTH-1:0] osc_count;

TempSens #(
  .WIDTH(`WIDTH),
  .DUAL_EDGE(`DUAL_EDGE),
  .IIR_SHIFT(`IIR_SHIFT)
) u_dut (
  .i_clk(clk), .i_rst(rst), .i_start(start),
  .i_clk_osc(clk_osc),
  .o_osc_count(osc_count), .o_pwrup_osc(pwrup_osc)
);
```

**Step 2: Add IIR warm-up loop before recording**

In the temperature sweep, add warm-up pulses for IIR convergence:
```verilog
for (temperature = -40; temperature <= 125; temperature = temperature + 1) begin
  // IIR warm-up: run extra measurements without recording
  repeat (`IIR_WARMUP) begin
    @(posedge clk) start = 1;
    @(posedge clk) start = 0;
    repeat (5) @(posedge clk);
  end
  // Actual measurement
  @(posedge clk) start = 1;
  @(posedge clk) start = 0;
  repeat (5) @(posedge clk);
  $fwrite(file, "%0d,%0d\n", temperature, osc_count);
end
```

**Step 3: Pass JITTER_PS to osc_model**

Pass the jitter parameter to the oscillator model instantiation.

---

### Task 4: Add oscillator jitter to osc_model

**Files:**
- Modify: `sim/tb_temp_sens/osc_model.v`

**Step 1: Add jitter to oscillator half-period**

```verilog
`ifndef JITTER_PS
`define JITTER_PS 0
`endif

always begin
  t = $itor(temperature);
  freq_hz = `OSC_COEFF_A * t * t + `OSC_COEFF_B * t + `OSC_COEFF_C;
  half_period_ns = 1.0e9 / (2.0 * freq_hz);
  if (`JITTER_PS > 0) begin
    half_period_ns = half_period_ns
      + ($itor($urandom % `JITTER_PS) - `JITTER_PS / 2.0) * 0.001;
  end
  #(half_period_ns) clk = ~clk;
end
```

This adds uniform random jitter of ±(JITTER_PS/2) picoseconds to each half-period, simulating real oscillator noise.

---

### Task 5: Add curvature correction to tb.py

**Files:**
- Modify: `sim/tb_temp_sens/tb.py`

**Step 1: Add 3-point quadratic calibration**

Add a new error computation in `_plot_corners()` that uses 3 calibration points (-10°C, 25°C, 85°C) to fit a quadratic `T = a*f² + b*f + c`:

```python
# 3-point quadratic calibration
f_m10 = float(np.interp(-10, t_arr, freq))
f25 = float(np.interp(25, t_arr, freq))
f85 = float(np.interp(85, t_arr, freq))
A = np.array([[f_m10**2, f_m10, 1],
              [f25**2,   f25,   1],
              [f85**2,   f85,   1]])
b_vec = np.array([-10.0, 25.0, 85.0])
quad_coeffs = np.linalg.solve(A, b_vec)
t_meas_quad = quad_coeffs[0]*freq**2 + quad_coeffs[1]*freq + quad_coeffs[2]
err_quad = t_meas_quad - t_arr
```

**Step 2: Add 5th and 6th subplot for curvature-corrected errors**

Expand the figure from 2x2 to 3x2, adding:
- Panel 5: 3-pt quadratic calibration error
- Panel 6: Comparison bar chart (max error per method in 0-70°C range)

---

### Task 6: Update Makefile for benchmark configurations

**Files:**
- Modify: `sim/tb_temp_sens/Makefile`

**Step 1: Add benchmark target**

```makefile
IVFLAGS = -g2012

# Benchmark configurations
CONFIGS = baseline dual_edge dual_edge_iir dual_edge_jitter_iir

benchmark: fit
	@mkdir -p output
	@for c in $(CORNERS); do \
		echo "=== $$c baseline ==="; \
		python3 fit_osc.py $$c && \
		iverilog $(IVFLAGS) -DWIDTH=8 -o design osc_model.v ../../rtl/temp_sens.sv tb.v && \
		vvp -n design && mv tb.csv output/tb_$$c.csv; \
		echo "=== $$c dual_edge ==="; \
		iverilog $(IVFLAGS) -DWIDTH=9 -DDUAL_EDGE=1 -o design osc_model.v ../../rtl/temp_sens.sv tb.v && \
		vvp -n design && mv tb.csv output/tb_$${c}_dual.csv; \
		echo "=== $$c dual_edge_iir ==="; \
		iverilog $(IVFLAGS) -DWIDTH=9 -DDUAL_EDGE=1 -DIIR_SHIFT=2 -DIIR_WARMUP=16 -o design osc_model.v ../../rtl/temp_sens.sv tb.v && \
		vvp -n design && mv tb.csv output/tb_$${c}_dual_iir.csv; \
		echo "=== $$c dual_edge_jitter_iir ==="; \
		iverilog $(IVFLAGS) -DWIDTH=9 -DDUAL_EDGE=1 -DIIR_SHIFT=2 -DIIR_WARMUP=16 -DJITTER_PS=500 -o design osc_model.v ../../rtl/temp_sens.sv tb.v && \
		vvp -n design && mv tb.csv output/tb_$${c}_dual_jitter_iir.csv; \
	done
	python3 tb.py
```

---

### Task 7: Update tb.py for benchmark comparison

**Files:**
- Modify: `sim/tb_temp_sens/tb.py`

**Step 1: Update _load_corners to group by configuration**

Detect config suffix in filenames (`_dual`, `_dual_iir`, `_dual_jitter_iir`) and group results.

**Step 2: Generate comparison summary**

Print a table showing max absolute error in 0-70°C range for each config:
```
Config               | 1-pt max err | 2-pt max err | 3-pt max err
baseline             |   X.X °C     |   X.X °C     |   X.X °C
dual_edge            |   X.X °C     |   X.X °C     |   X.X °C
dual_edge_iir        |   X.X °C     |   X.X °C     |   X.X °C
dual_edge_jitter_iir |   X.X °C     |   X.X °C     |   X.X °C
```

**Step 3: Add comparison bar chart panel**

---

### Task 8: Run full benchmark and verify results

**Step 1: Run benchmark**
```bash
cd sim/tb_temp_sens
make clean && make benchmark
```

**Step 2: Review comparison plot and error table**

Check `svgs/temp_sens_measurement.svg` for the comparison.

**Step 3: Commit all changes**
```bash
git add rtl/temp_sens.sv sim/tb_temp_sens/
git commit -m "feat: add dual-edge counting, IIR averaging, curvature correction with benchmarks"
```
