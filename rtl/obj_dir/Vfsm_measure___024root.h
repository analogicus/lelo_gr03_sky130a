// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vfsm_measure.h for the primary calling header

#ifndef VERILATED_VFSM_MEASURE___024ROOT_H_
#define VERILATED_VFSM_MEASURE___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vfsm_measure__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vfsm_measure___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ tb_fsm_measure__DOT__clk_ref;
    CData/*0:0*/ tb_fsm_measure__DOT__rst_n;
    CData/*0:0*/ tb_fsm_measure__DOT__start;
    CData/*0:0*/ tb_fsm_measure__DOT__osc_in;
    CData/*0:0*/ tb_fsm_measure__DOT__done;
    CData/*1:0*/ tb_fsm_measure__DOT__dut__DOT__state;
    CData/*1:0*/ tb_fsm_measure__DOT__dut__DOT__next_state;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_fsm_measure__DOT__clk_ref__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_fsm_measure__DOT__rst_n__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_fsm_measure__DOT__done__0;
    CData/*0:0*/ __VactDidInit;
    CData/*0:0*/ __VactContinue;
    SData/*15:0*/ tb_fsm_measure__DOT__dut__DOT__ref_counter;
    IData/*31:0*/ tb_fsm_measure__DOT__count_out;
    IData/*31:0*/ tb_fsm_measure__DOT__dut__DOT__osc_counter;
    IData/*31:0*/ __VactIterCount;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hefcf8835__0;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vfsm_measure__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vfsm_measure___024root(Vfsm_measure__Syms* symsp, const char* v__name);
    ~Vfsm_measure___024root();
    VL_UNCOPYABLE(Vfsm_measure___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
