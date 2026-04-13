`timescale 1ns/1ps
`default_nettype none

module tb_tempsens;

    parameter WIDTH = 16;
    parameter REF_CYCLES = 128;

    logic i_clk;
    logic i_rst_n;
    logic i_start;
    logic i_clk_osc;

    logic [WIDTH-2:0] o_osc_count;   // UPDATED WIDTH
    logic o_pwrup_osc;
    logic signed [15:0] o_temperature;

    // DUT
    tempsens #(
        .WIDTH(WIDTH),
        .REF_CYCLES(REF_CYCLES)
    ) dut (
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),   // UPDATED NAME
        .i_start(i_start),
        .i_clk_osc(i_clk_osc),
        .o_osc_count(o_osc_count),
        .o_pwrup_osc(o_pwrup_osc),
        .o_temperature(o_temperature)
    );

    // waves for dump
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_tempsens);
    end

    // Clocks
    initial i_clk = 0;
    always #15250 i_clk = ~i_clk;      // 32768 Hz

    initial i_clk_osc = 0;
    always #250 i_clk_osc = ~i_clk_osc; // 2 MHz

    // Stimulus
    initial begin
        $display("Starting simulation..");

        i_rst_n = 0;   // ASSERT reset (active-low)
        i_start = 0;

        #100000;
        i_rst_n = 1;   // DEASSERT reset

        #100000;
        i_start = 1;

        #(2*30500);
        i_start = 0;

        #(128*30500 + 2*30500);

        $display("Measured count = %0d", o_osc_count);
        $display("The temperature is = %0d", o_temperature);

        #100000;
        $finish;
    end

endmodule