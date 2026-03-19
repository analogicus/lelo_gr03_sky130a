
/* verilator lint_off MODDUP */
`timescale 1ns/1ps

module tb_fsm_measure;

    reg clk_ref;
    reg rst_n;
    reg start;
    reg osc_in;

    /* verilator lint_off UNUSED */
    wire enableOsc;
    wire cnt_rst;
    /* verilator lint_on UNUSED */

    wire done;
    wire [31:0] count_out;

    // Instantiate DUT
    fsm_measure #(
        .REF_COUNT_MAX(128)
    ) dut (
        .clk_ref(clk_ref),
        .rst_n(rst_n),
        .start(start),
        .osc_in(osc_in),
        .enableOsc(enableOsc),
        .cnt_rst(cnt_rst),
        .done(done),
        .count_out(count_out)
    );

    // -------------------------
    // Waveform generation
    // -------------------------
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_fsm_measure);
    end

    // -------------------------
    // Clock generation
    // -------------------------
    initial clk_ref = 0;

    /* verilator lint_off BLKSEQ */

    always #500 clk_ref = ~clk_ref; // 1 MHz

    initial osc_in = 0;
    always #8 osc_in = ~osc_in;     // ~62.5 MHz

    /* verilator lint_on BLKSEQ */
    
    // -------------------------
    // Stimulus
    // -------------------------
    initial begin
        $display("Starting simulation...");

        rst_n = 0;
        start = 0;

        #2000;
        rst_n = 1;

        #2000;
        start = 1;

        #1000;
        start = 0;

        // Wait for done
        wait(done);

        $display("Measurement done!");
        $display("Oscillator count = %d", count_out);
        $display("Expected approx ~8000");

        #2000;
        $finish;
    end

endmodule

/* verilator lint_on MODDUP */

