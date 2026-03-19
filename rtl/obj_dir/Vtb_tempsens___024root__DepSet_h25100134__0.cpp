// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_tempsens.h for the primary calling header

#include "Vtb_tempsens__pch.h"
#include "Vtb_tempsens___024root.h"

VL_ATTR_COLD void Vtb_tempsens___024root___eval_initial__TOP(Vtb_tempsens___024root* vlSelf);
VlCoroutine Vtb_tempsens___024root___eval_initial__TOP__Vtiming__0(Vtb_tempsens___024root* vlSelf);
VlCoroutine Vtb_tempsens___024root___eval_initial__TOP__Vtiming__1(Vtb_tempsens___024root* vlSelf);
VlCoroutine Vtb_tempsens___024root___eval_initial__TOP__Vtiming__2(Vtb_tempsens___024root* vlSelf);

void Vtb_tempsens___024root___eval_initial(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_initial\n"); );
    // Body
    Vtb_tempsens___024root___eval_initial__TOP(vlSelf);
    Vtb_tempsens___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtb_tempsens___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    Vtb_tempsens___024root___eval_initial__TOP__Vtiming__2(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk__0 
        = vlSelf->tb_tempsens__DOT__i_clk;
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_rst__0 
        = vlSelf->tb_tempsens__DOT__i_rst;
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__dut__DOT__cnt_rst__0 
        = vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst;
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk_osc__0 
        = vlSelf->tb_tempsens__DOT__i_clk_osc;
}

VL_INLINE_OPT VlCoroutine Vtb_tempsens___024root___eval_initial__TOP__Vtiming__0(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_initial__TOP__Vtiming__0\n"); );
    // Body
    VL_WRITEF("Starting simulation..\n");
    vlSelf->tb_tempsens__DOT__i_rst = 1U;
    vlSelf->tb_tempsens__DOT__i_start = 0U;
    co_await vlSelf->__VdlySched.delay(0x5f5e100ULL, 
                                       nullptr, "tb_temp_sens.sv", 
                                       55);
    vlSelf->tb_tempsens__DOT__i_rst = 0U;
    co_await vlSelf->__VdlySched.delay(0x5f5e100ULL, 
                                       nullptr, "tb_temp_sens.sv", 
                                       58);
    vlSelf->tb_tempsens__DOT__i_start = 1U;
    co_await vlSelf->__VdlySched.delay(0x3a2c940ULL, 
                                       nullptr, "tb_temp_sens.sv", 
                                       62);
    vlSelf->tb_tempsens__DOT__i_start = 0U;
    co_await vlSelf->__VdlySched.delay(0xec551940ULL, 
                                       nullptr, "tb_temp_sens.sv", 
                                       66);
    VL_WRITEF("Measured count = %0#\nThe temperature is = %0d\n",
              16,vlSelf->tb_tempsens__DOT__o_osc_count,
              16,(IData)(vlSelf->tb_tempsens__DOT__o_temperature));
    co_await vlSelf->__VdlySched.delay(0x5f5e100ULL, 
                                       nullptr, "tb_temp_sens.sv", 
                                       71);
    VL_FINISH_MT("tb_temp_sens.sv", 72, "");
}

VL_INLINE_OPT VlCoroutine Vtb_tempsens___024root___eval_initial__TOP__Vtiming__1(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_initial__TOP__Vtiming__1\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0x3d090ULL, 
                                           nullptr, 
                                           "tb_temp_sens.sv", 
                                           45);
        vlSelf->tb_tempsens__DOT__i_clk_osc = (1U & 
                                               (~ (IData)(vlSelf->tb_tempsens__DOT__i_clk_osc)));
    }
}

VL_INLINE_OPT VlCoroutine Vtb_tempsens___024root___eval_initial__TOP__Vtiming__2(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_initial__TOP__Vtiming__2\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0xe8b250ULL, 
                                           nullptr, 
                                           "tb_temp_sens.sv", 
                                           41);
        vlSelf->tb_tempsens__DOT__i_clk = (1U & (~ (IData)(vlSelf->tb_tempsens__DOT__i_clk)));
    }
}

VL_INLINE_OPT void Vtb_tempsens___024root___act_sequent__TOP__0(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___act_sequent__TOP__0\n"); );
    // Body
    vlSelf->tb_tempsens__DOT__dut__DOT__next_state 
        = ((2U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
            ? ((1U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                ? 2U : 0U) : ((1U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                               ? ((0x7fU == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt))
                                   ? 3U : 1U) : ((IData)(vlSelf->tb_tempsens__DOT__i_start)
                                                  ? 1U
                                                  : 0U)));
}

void Vtb_tempsens___024root___eval_act(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_act\n"); );
    // Body
    if ((8ULL & vlSelf->__VactTriggered.word(0U))) {
        Vtb_tempsens___024root___act_sequent__TOP__0(vlSelf);
    }
}

VL_INLINE_OPT void Vtb_tempsens___024root___nba_sequent__TOP__0(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___nba_sequent__TOP__0\n"); );
    // Init
    SData/*14:0*/ __Vdly__tb_tempsens__DOT__dut__DOT__cnt_r;
    __Vdly__tb_tempsens__DOT__dut__DOT__cnt_r = 0;
    // Body
    __Vdly__tb_tempsens__DOT__dut__DOT__cnt_r = vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r;
    if (vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst) {
        __Vdly__tb_tempsens__DOT__dut__DOT__cnt_r = 0U;
    } else if ((1U == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))) {
        __Vdly__tb_tempsens__DOT__dut__DOT__cnt_r = 
            (0x7fffU & ((IData)(1U) + (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r)));
    }
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r = __Vdly__tb_tempsens__DOT__dut__DOT__cnt_r;
}

VL_INLINE_OPT void Vtb_tempsens___024root___nba_sequent__TOP__1(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___nba_sequent__TOP__1\n"); );
    // Init
    SData/*14:0*/ __Vdly__tb_tempsens__DOT__dut__DOT__cnt_f;
    __Vdly__tb_tempsens__DOT__dut__DOT__cnt_f = 0;
    // Body
    __Vdly__tb_tempsens__DOT__dut__DOT__cnt_f = vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f;
    if (vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst) {
        __Vdly__tb_tempsens__DOT__dut__DOT__cnt_f = 0U;
    } else if ((1U == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))) {
        __Vdly__tb_tempsens__DOT__dut__DOT__cnt_f = 
            (0x7fffU & ((IData)(1U) + (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f)));
    }
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f = __Vdly__tb_tempsens__DOT__dut__DOT__cnt_f;
}

VL_INLINE_OPT void Vtb_tempsens___024root___nba_sequent__TOP__2(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___nba_sequent__TOP__2\n"); );
    // Body
    if (vlSelf->tb_tempsens__DOT__i_rst) {
        vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt = 0U;
        vlSelf->tb_tempsens__DOT__o_temperature = 0U;
        vlSelf->tb_tempsens__DOT__o_osc_count = 0U;
        vlSelf->tb_tempsens__DOT__dut__DOT__cur_state = 0U;
    } else {
        vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt 
            = ((1U == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                ? (0xffU & ((IData)(1U) + (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt)))
                : 0U);
        if ((2U == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))) {
            vlSelf->tb_tempsens__DOT__o_temperature 
                = (0xffffU & (((IData)(0x40U) + (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__count)) 
                              >> 7U));
            vlSelf->tb_tempsens__DOT__o_osc_count = vlSelf->tb_tempsens__DOT__dut__DOT__count;
        }
        vlSelf->tb_tempsens__DOT__dut__DOT__cur_state 
            = vlSelf->tb_tempsens__DOT__dut__DOT__next_state;
    }
    vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst = (0U 
                                                   == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state));
}

VL_INLINE_OPT void Vtb_tempsens___024root___nba_comb__TOP__0(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___nba_comb__TOP__0\n"); );
    // Body
    vlSelf->tb_tempsens__DOT__dut__DOT__count = (0xffffU 
                                                 & ((IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r) 
                                                    + (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f)));
}

void Vtb_tempsens___024root___eval_nba(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_nba\n"); );
    // Body
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtb_tempsens___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtb_tempsens___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtb_tempsens___024root___nba_sequent__TOP__2(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    if ((6ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtb_tempsens___024root___nba_comb__TOP__0(vlSelf);
    }
    if ((9ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtb_tempsens___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vtb_tempsens___024root___timing_resume(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___timing_resume\n"); );
    // Body
    if ((8ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

void Vtb_tempsens___024root___eval_triggers__act(Vtb_tempsens___024root* vlSelf);

bool Vtb_tempsens___024root___eval_phase__act(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<4> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vtb_tempsens___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vtb_tempsens___024root___timing_resume(vlSelf);
        Vtb_tempsens___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vtb_tempsens___024root___eval_phase__nba(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vtb_tempsens___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__nba(Vtb_tempsens___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__act(Vtb_tempsens___024root* vlSelf);
#endif  // VL_DEBUG

void Vtb_tempsens___024root___eval(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vtb_tempsens___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("tb_temp_sens.sv", 4, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vtb_tempsens___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("tb_temp_sens.sv", 4, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vtb_tempsens___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vtb_tempsens___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vtb_tempsens___024root___eval_debug_assertions(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
