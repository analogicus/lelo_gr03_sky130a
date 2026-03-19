`timescale 1ns/1ps
`default_nettype none

module tb_tempsens;

    parameter WIDTH = 16;
    parameter REF_CYCLES = 128;

    logic i_clk;
    logic i_rst;
    logic i_start;
    logic i_clk_osc;

    logic [WIDTH-1:0] o_osc_count;
    logic o_pwrup_osc;
    logic signed [15:0] o_temperature; // connect the temperature

    // DUT
    tempsens #(
        .WIDTH(WIDTH),
        .REF_CYCLES(REF_CYCLES)
    ) dut (
        .i_clk(i_clk),
        .i_rst(i_rst),
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
    // 32768 Hz (30.5 us period)
    initial i_clk = 0;
    always #15250 i_clk = ~i_clk;

    // 2 MHz (500 ns period)
    initial i_clk_osc = 0;
    always #250 i_clk_osc = ~i_clk_osc;


    // Stimulate my penis
    initial begin
        $display("Starting simulation..");

        i_rst = 1;
        i_start = 0;

        #100000;
        i_rst = 0;    // reset start

        #100000;
        i_start = 1;  // pulse start

        // keep high one reference clock trigger FSM
        #(2*30500);   // 2 i_clk periods, to latch i_start
        i_start = 0;  // let FSM run

        // wait long enough for COUNT+WAIT+CAPTURE
        #(128*30500 + 2*30500); // 128 ref cycles + WAIT+CAPTURE

        $display("Measured count = %0d", o_osc_count);
        $display("The temperature is = %0d", o_temperature);

        #100000;
        $finish;
    end

endmodule