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
