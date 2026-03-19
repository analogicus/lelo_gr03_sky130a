`default_nettype none
`timescale 1ns/1ps

module tempsens #(
    parameter int WIDTH = 16,
    parameter int REF_CYCLES = 128,

    // calibration constants (for fine tuning later maybe?)
    parameter int TEMP_A = 1,     // scale param
    parameter int TEMP_B = 0      // offset param
) (
    input  logic i_clk,
    input  logic i_rst,
    input  logic i_start,
    input  logic i_clk_osc,

    output logic [WIDTH-1:0] o_osc_count,
    output logic o_pwrup_osc,
    output logic signed [15:0] o_temperature
);

  typedef enum logic [1:0] {
    IDLE    = 2'b00,
    COUNT   = 2'b01,
    WAIT    = 2'b11,
    CAPTURE = 2'b10
  } state_t;

  state_t cur_state, next_state;

  logic cnt_rst;
  logic [WIDTH-1:0] count;
  logic [WIDTH-2:0] cnt_r, cnt_f;

  logic [$clog2(REF_CYCLES):0] ref_cnt;

  // FSM register
  always_ff @(posedge i_clk or posedge i_rst) begin
    if (i_rst) cur_state <= IDLE;
    else       cur_state <= next_state;
  end

  // FSM logic
  always_comb begin
    case (cur_state)
      IDLE:    next_state = (i_start) ? COUNT : IDLE;
      COUNT:   next_state = (ref_cnt == REF_CYCLES-1) ? WAIT : COUNT;
      WAIT:    next_state = CAPTURE;
      CAPTURE: next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end

  // reference counter
  always_ff @(posedge i_clk or posedge i_rst) begin
    if (i_rst) ref_cnt <= 0;
    else if (cur_state == COUNT) ref_cnt <= ref_cnt + 1;
    else ref_cnt <= 0;
  end

  assign o_pwrup_osc = (cur_state == COUNT);
  assign cnt_rst     = (cur_state == IDLE);

  // oscillator counter
  always_ff @(posedge i_clk_osc or posedge cnt_rst) begin
    if (cnt_rst) cnt_r <= '0;
    else if (o_pwrup_osc) cnt_r <= cnt_r + 1;
  end

  always_ff @(negedge i_clk_osc or posedge cnt_rst) begin
    if (cnt_rst) cnt_f <= '0;
    else if (o_pwrup_osc) cnt_f <= cnt_f + 1;
  end

  assign count = {1'b0, cnt_r} + {1'b0, cnt_f};

  // capture count
  always_ff @(posedge i_clk or posedge i_rst) begin
    if (i_rst)
      o_osc_count <= 0;
    else if (cur_state == CAPTURE)
      o_osc_count <= count;
  end


  // temperature calculation
  always_ff @(posedge i_clk or posedge i_rst) begin
      if (i_rst)
          o_temperature <= 0;
      else if (cur_state == CAPTURE)
          o_temperature <= (count * TEMP_A + REF_CYCLES/2) / REF_CYCLES + TEMP_B;
  end

endmodule

