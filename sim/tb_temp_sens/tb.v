`timescale 1 ns / 1 ps

`ifndef WIDTH
`define WIDTH 9
`endif

module tb;

  // 32768 Hz reference clock
  localparam LFCLK_HALF = 15259; // ns (half period)

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

  temp_sens #(
    .WIDTH(`WIDTH)
  ) u_dut (
    .i_clk(clk),
    .i_rst_n(rst_n),
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

    // Reset sequence: assert rst (0->1 posedge), then release
    rst_n = 0;
    #100 rst_n = 1;

    // Wait a few clocks for FSM to settle in IDLE
    repeat (4) @(posedge clk);

    // Temperature sweep
    for (temperature = -40; temperature <= 125; temperature = temperature + 1) begin
      // Trigger measurement
      @(posedge clk) start = 1;
      @(posedge clk) start = 0;

      // Wait for FSM: COUNT + WAIT + CAPTURE + back to IDLE = 4 edges
      repeat (5) @(posedge clk);

      $fwrite(file, "%0d,%0d\n", temperature, osc_count);
    end

    $fclose(file);
    $finish;
  end

endmodule
