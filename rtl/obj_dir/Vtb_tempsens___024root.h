// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtb_tempsens.h for the primary calling header

#ifndef VERILATED_VTB_TEMPSENS___024ROOT_H_
#define VERILATED_VTB_TEMPSENS___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtb_tempsens__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtb_tempsens___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ tb_tempsens__DOT__i_clk;
    CData/*0:0*/ tb_tempsens__DOT__i_rst;
    CData/*0:0*/ tb_tempsens__DOT__i_clk_osc;
    CData/*0:0*/ tb_tempsens__DOT__dut__DOT__cnt_rst;
    CData/*0:0*/ tb_tempsens__DOT__i_start;
    CData/*1:0*/ tb_tempsens__DOT__dut__DOT__cur_state;
    CData/*1:0*/ tb_tempsens__DOT__dut__DOT__next_state;
    CData/*7:0*/ tb_tempsens__DOT__dut__DOT__ref_cnt;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_tempsens__DOT__i_rst__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_tempsens__DOT__dut__DOT__cnt_rst__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk_osc__0;
    CData/*0:0*/ __VactContinue;
    SData/*15:0*/ tb_tempsens__DOT__o_osc_count;
    SData/*15:0*/ tb_tempsens__DOT__o_temperature;
    SData/*15:0*/ tb_tempsens__DOT__dut__DOT__count;
    SData/*14:0*/ tb_tempsens__DOT__dut__DOT__cnt_r;
    SData/*14:0*/ tb_tempsens__DOT__dut__DOT__cnt_f;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<4> __VactTriggered;
    VlTriggerVec<4> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtb_tempsens__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtb_tempsens___024root(Vtb_tempsens__Syms* symsp, const char* v__name);
    ~Vtb_tempsens___024root();
    VL_UNCOPYABLE(Vtb_tempsens___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
