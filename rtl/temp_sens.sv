// Copyright (c) 2026 All rights reserved.
`default_nettype none
module temp_sens #(
    parameter int WIDTH = 9
) (
    input var logic i_clk
    , input var logic i_rst
    , input var logic i_start
    , input var logic i_clk_osc
    , output var logic [WIDTH-1:0] o_osc_count
    , output var logic o_pwrup_osc
);

  typedef enum logic [1:0] {
    IDLE    = 2'b00
    , COUNT   = 2'b01
    , WAIT    = 2'b11
    , CAPTURE = 2'b10
  } state_t;

  state_t cur_state, next_state;
  logic cnt_rst;
  logic [WIDTH-1:0] count;
  logic [WIDTH-2:0] cnt_r, cnt_f;

  // ---------------------------------------------------------------
  // FSM
  // ---------------------------------------------------------------
  always_ff @(posedge i_clk, posedge i_rst) begin
    if (i_rst) begin
      cur_state <= IDLE;
    end else begin
      cur_state <= next_state;
    end
  end

  // COUNT lasts exactly one reference clock cycle (~30 us at 32768 Hz).
  // WAIT lets the counter settle before CAPTURE samples it (CDC safety).
  always_comb begin
    case (cur_state)
      IDLE:
        if (i_start) next_state = COUNT;
        else next_state = IDLE;
      COUNT:   next_state = WAIT;
      WAIT:    next_state = CAPTURE;
      CAPTURE: next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end

  assign o_pwrup_osc = (cur_state == COUNT);
  assign cnt_rst     = (cur_state == IDLE);

  // ---------------------------------------------------------------
  // Dual-edge oscillator counter (i_clk_osc domain)
  //   Counts both rising and falling edges for 2x resolution.
  // ---------------------------------------------------------------
  always_ff @(posedge i_clk_osc, posedge cnt_rst) begin
    if (cnt_rst) cnt_r <= '0;
    else if (o_pwrup_osc) cnt_r <= cnt_r + 1'b1;
    else cnt_r <= cnt_r;
  end

  always_ff @(negedge i_clk_osc, posedge cnt_rst) begin
    if (cnt_rst) cnt_f <= '0;
    else if (o_pwrup_osc) cnt_f <= cnt_f + 1'b1;
    else cnt_f <= cnt_f;
  end

  assign count = {1'b0, cnt_r} + {1'b0, cnt_f};

  // ---------------------------------------------------------------
  // Capture register (i_clk domain)
  // ---------------------------------------------------------------
  always_ff @(posedge i_clk, posedge i_rst) begin
    if (i_rst) o_osc_count <= 0;
    else if (cur_state == CAPTURE) o_osc_count <= count;
    else o_osc_count <= o_osc_count;
  end

endmodule
