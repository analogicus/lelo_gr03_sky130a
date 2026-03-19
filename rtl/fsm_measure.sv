`timescale 1ns/1ps

module fsm_measure #(
    parameter REF_COUNT_MAX = 128
)(
    input wire clk_ref,       // 32768 Hz
    input wire rst_n,
    input wire start,

    input wire osc_in,        // F_IN

    output reg enableOsc,
    output reg cnt_rst,
    output reg done,

    output reg [31:0] count_out
);

    typedef enum reg [1:0] {
        IDLE,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;

    reg [15:0] ref_counter;
    reg [31:0] osc_counter;

    // State register
    always @(posedge clk_ref or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:
                next_state = start ? COUNT : IDLE;

            COUNT:
                next_state = (ref_counter == REF_COUNT_MAX) ? DONE : COUNT;

            DONE:
                next_state = IDLE;

            default:
                next_state = IDLE;
        endcase
    end

    // Control + counters
    always @(posedge clk_ref or negedge rst_n) begin
        if (!rst_n) begin
            ref_counter <= 0;
            osc_counter <= 0;
            count_out   <= 0;
        end else begin
            case (state)

                IDLE: begin
                    ref_counter <= 0;
                    osc_counter <= 0;
                end

                COUNT: begin
                    ref_counter <= ref_counter + 1;

                    if (osc_in)
                        osc_counter <= osc_counter + 1;
                end

                DONE: begin
                    count_out <= osc_counter;
                end

                default: begin
                    ref_counter <= 0;
                    osc_counter <= 0;
                    count_out   <= 0;
                    end
            endcase
        end
    end

    // Outputs
    always @(*) begin
        case (state)

            IDLE: begin
                enableOsc = 0;
                cnt_rst   = 1;
                done      = 0;
            end

            COUNT: begin
                enableOsc = 1;
                cnt_rst   = 0;
                done      = 0;
            end

            DONE: begin
                enableOsc = 0;
                cnt_rst   = 0;
                done      = 1;
            end

            default: begin
                enableOsc = 0;
                cnt_rst   = 1;
                done      = 0;
                end
        endcase
    end

endmodule


