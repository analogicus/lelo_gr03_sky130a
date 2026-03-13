module counter_FSM(
    input  logic enable,
    input  logic clk,
    input  logic rst,

    output logic pwrupOSC,
    output logic cnt_enable,
    output logic cnt_rst,
    output logic capture
);

    typedef enum logic [1:0] {
        IDLE,
        PWRUP,
        PWRDWN,
        CAPTURE
    } state_t;

    state_t cur_state, next_state;

    ////////////////////////////
    ////// State register //////
    ////////////////////////////
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            cur_state <= IDLE;
        else
            cur_state <= next_state;
    end

    ////////////////////////////
    ///// Next state logic /////
    ////////////////////////////
    always_comb begin

        next_state = cur_state;

        case (cur_state)

            IDLE:
                if (enable)
                    next_state = PWRUP;

            PWRUP:
                next_state = PWRDWN;

            PWRDWN:
                next_state = CAPTURE;

            CAPTURE:
                next_state = IDLE;

        endcase

    end

    ////////////////////////////
    // Output logic
    ////////////////////////////
    always_comb begin

        pwrupOSC   = 0;
        cnt_enable = 0;
        cnt_rst    = 0;
        capture    = 0;

        case(cur_state)

            IDLE:
                cnt_rst = 1;

            PWRUP: begin
                pwrupOSC   = 1;
                cnt_enable = 1;
            end

            PWRDWN:
                pwrupOSC = 0;

            CAPTURE:
                capture = 1;

        endcase

    end

endmodule