`timescale 1 ns / 1 ps
`include "osc_params.vh"

module osc_model (
    input  wire    PWRUP,
    output wire    F_OUT,
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
