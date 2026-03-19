// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsm_measure.h for the primary calling header

#include "Vfsm_measure__pch.h"
#include "Vfsm_measure___024root.h"

VL_ATTR_COLD void Vfsm_measure___024root___eval_static(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vfsm_measure___024root___eval_final(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__stl(Vfsm_measure___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vfsm_measure___024root___eval_phase__stl(Vfsm_measure___024root* vlSelf);

VL_ATTR_COLD void Vfsm_measure___024root___eval_settle(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vfsm_measure___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("tb_fsm_measure.sv", 5, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vfsm_measure___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__stl(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

extern const VlUnpacked<CData/*0:0*/, 4> Vfsm_measure__ConstPool__TABLE_hb34e3fe2_0;

VL_ATTR_COLD void Vfsm_measure___024root___stl_sequent__TOP__0(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___stl_sequent__TOP__0\n"); );
    // Init
    CData/*1:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    // Body
    vlSelf->tb_fsm_measure__DOT__dut__DOT__next_state 
        = ((0U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))
            ? ((IData)(vlSelf->tb_fsm_measure__DOT__start)
                ? 1U : 0U) : ((1U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))
                               ? ((0x80U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__ref_counter))
                                   ? 2U : 1U) : 0U));
    __Vtableidx1 = vlSelf->tb_fsm_measure__DOT__dut__DOT__state;
    vlSelf->tb_fsm_measure__DOT__done = Vfsm_measure__ConstPool__TABLE_hb34e3fe2_0
        [__Vtableidx1];
}

VL_ATTR_COLD void Vfsm_measure___024root___eval_stl(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vfsm_measure___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vfsm_measure___024root___eval_triggers__stl(Vfsm_measure___024root* vlSelf);

VL_ATTR_COLD bool Vfsm_measure___024root___eval_phase__stl(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vfsm_measure___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vfsm_measure___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__act(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge tb_fsm_measure.clk_ref or negedge tb_fsm_measure.rst_n)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @([changed] tb_fsm_measure.done)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__nba(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge tb_fsm_measure.clk_ref or negedge tb_fsm_measure.rst_n)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @([changed] tb_fsm_measure.done)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vfsm_measure___024root___ctor_var_reset(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->tb_fsm_measure__DOT__clk_ref = VL_RAND_RESET_I(1);
    vlSelf->tb_fsm_measure__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_fsm_measure__DOT__start = VL_RAND_RESET_I(1);
    vlSelf->tb_fsm_measure__DOT__osc_in = VL_RAND_RESET_I(1);
    vlSelf->tb_fsm_measure__DOT__done = VL_RAND_RESET_I(1);
    vlSelf->tb_fsm_measure__DOT__count_out = VL_RAND_RESET_I(32);
    vlSelf->tb_fsm_measure__DOT__dut__DOT__state = VL_RAND_RESET_I(2);
    vlSelf->tb_fsm_measure__DOT__dut__DOT__next_state = VL_RAND_RESET_I(2);
    vlSelf->tb_fsm_measure__DOT__dut__DOT__ref_counter = VL_RAND_RESET_I(16);
    vlSelf->tb_fsm_measure__DOT__dut__DOT__osc_counter = VL_RAND_RESET_I(32);
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__clk_ref__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__rst_n__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__done__0 = VL_RAND_RESET_I(1);
    vlSelf->__VactDidInit = 0;
}
