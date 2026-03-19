// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_tempsens.h for the primary calling header

#include "Vtb_tempsens__pch.h"
#include "Vtb_tempsens___024root.h"

VL_ATTR_COLD void Vtb_tempsens___024root___eval_static(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vtb_tempsens___024root___eval_final(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__stl(Vtb_tempsens___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtb_tempsens___024root___eval_phase__stl(Vtb_tempsens___024root* vlSelf);

VL_ATTR_COLD void Vtb_tempsens___024root___eval_settle(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_settle\n"); );
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
            Vtb_tempsens___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("tb_temp_sens.sv", 4, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vtb_tempsens___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__stl(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtb_tempsens___024root___stl_sequent__TOP__0(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst = (0U 
                                                   == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state));
    vlSelf->tb_tempsens__DOT__dut__DOT__count = (0xffffU 
                                                 & ((IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r) 
                                                    + (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f)));
    vlSelf->tb_tempsens__DOT__dut__DOT__next_state 
        = ((2U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
            ? ((1U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                ? 2U : 0U) : ((1U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                               ? ((0x7fU == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt))
                                   ? 3U : 1U) : ((IData)(vlSelf->tb_tempsens__DOT__i_start)
                                                  ? 1U
                                                  : 0U)));
}

VL_ATTR_COLD void Vtb_tempsens___024root___eval_stl(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vtb_tempsens___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

VL_ATTR_COLD void Vtb_tempsens___024root___eval_triggers__stl(Vtb_tempsens___024root* vlSelf);

VL_ATTR_COLD bool Vtb_tempsens___024root___eval_phase__stl(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtb_tempsens___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vtb_tempsens___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__act(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge tb_tempsens.i_clk or posedge tb_tempsens.i_rst)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(posedge tb_tempsens.dut.cnt_rst or posedge tb_tempsens.i_clk_osc)\n");
    }
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @(posedge tb_tempsens.dut.cnt_rst or negedge tb_tempsens.i_clk_osc)\n");
    }
    if ((8ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 3 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__nba(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge tb_tempsens.i_clk or posedge tb_tempsens.i_rst)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(posedge tb_tempsens.dut.cnt_rst or posedge tb_tempsens.i_clk_osc)\n");
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @(posedge tb_tempsens.dut.cnt_rst or negedge tb_tempsens.i_clk_osc)\n");
    }
    if ((8ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 3 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtb_tempsens___024root___ctor_var_reset(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->tb_tempsens__DOT__i_clk = VL_RAND_RESET_I(1);
    vlSelf->tb_tempsens__DOT__i_rst = VL_RAND_RESET_I(1);
    vlSelf->tb_tempsens__DOT__i_start = VL_RAND_RESET_I(1);
    vlSelf->tb_tempsens__DOT__i_clk_osc = VL_RAND_RESET_I(1);
    vlSelf->tb_tempsens__DOT__o_osc_count = VL_RAND_RESET_I(16);
    vlSelf->tb_tempsens__DOT__o_temperature = VL_RAND_RESET_I(16);
    vlSelf->tb_tempsens__DOT__dut__DOT__cur_state = VL_RAND_RESET_I(2);
    vlSelf->tb_tempsens__DOT__dut__DOT__next_state = VL_RAND_RESET_I(2);
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst = VL_RAND_RESET_I(1);
    vlSelf->tb_tempsens__DOT__dut__DOT__count = VL_RAND_RESET_I(16);
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r = VL_RAND_RESET_I(15);
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f = VL_RAND_RESET_I(15);
    vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt = VL_RAND_RESET_I(8);
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_rst__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__dut__DOT__cnt_rst__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk_osc__0 = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
