# Two independent clock domains.
#   i_clk     : 32.768 kHz reference (given 3x margin -> 100 kHz).
#   i_clk_osc : ~2 MHz temperature-dependent oscillator.
create_clock -name i_clk     -period 10000 [get_ports i_clk]
create_clock -name i_clk_osc -period   500 [get_ports i_clk_osc]

# The FSM's WAIT state is the async CDC synchroniser, so STA should not
# try to time between these two domains.
set_clock_groups -asynchronous -group {i_clk} -group {i_clk_osc}

# Zero input/output delays: all block-level I/O hands off to async pads
# or to the analog feedback loop, neither of which STA covers.
set_input_delay  -clock i_clk 0 [all_inputs]
set_output_delay -clock i_clk 0 [all_outputs]
set_load 0.1 [all_outputs]
