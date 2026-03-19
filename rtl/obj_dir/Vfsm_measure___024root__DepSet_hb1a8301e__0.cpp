// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsm_measure.h for the primary calling header

#include "Vfsm_measure__pch.h"
#include "Vfsm_measure___024root.h"

VL_ATTR_COLD void Vfsm_measure___024root___eval_initial__TOP(Vfsm_measure___024root* vlSelf);
VlCoroutine Vfsm_measure___024root___eval_initial__TOP__Vtiming__0(Vfsm_measure___024root* vlSelf);
VlCoroutine Vfsm_measure___024root___eval_initial__TOP__Vtiming__1(Vfsm_measure___024root* vlSelf);
VlCoroutine Vfsm_measure___024root___eval_initial__TOP__Vtiming__2(Vfsm_measure___024root* vlSelf);

void Vfsm_measure___024root___eval_initial(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_initial\n"); );
    // Body
    Vfsm_measure___024root___eval_initial__TOP(vlSelf);
    Vfsm_measure___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vfsm_measure___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    Vfsm_measure___024root___eval_initial__TOP__Vtiming__2(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__clk_ref__0 
        = vlSelf->tb_fsm_measure__DOT__clk_ref;
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__rst_n__0 
        = vlSelf->tb_fsm_measure__DOT__rst_n;
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__done__0 
        = vlSelf->tb_fsm_measure__DOT__done;
}

VL_INLINE_OPT VlCoroutine Vfsm_measure___024root___eval_initial__TOP__Vtiming__0(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_initial__TOP__Vtiming__0\n"); );
    // Body
    VL_WRITEF("Starting simulation...\n");
    vlSelf->tb_fsm_measure__DOT__rst_n = 0U;
    vlSelf->tb_fsm_measure__DOT__start = 0U;
    co_await vlSelf->__VdlySched.delay(0x1e8480ULL, 
                                       nullptr, "tb_fsm_measure.sv", 
                                       65);
    vlSelf->tb_fsm_measure__DOT__rst_n = 1U;
    co_await vlSelf->__VdlySched.delay(0x1e8480ULL, 
                                       nullptr, "tb_fsm_measure.sv", 
                                       68);
    vlSelf->tb_fsm_measure__DOT__start = 1U;
    co_await vlSelf->__VdlySched.delay(0xf4240ULL, 
                                       nullptr, "tb_fsm_measure.sv", 
                                       71);
    vlSelf->tb_fsm_measure__DOT__start = 0U;
    while ((1U & (~ (IData)(vlSelf->tb_fsm_measure__DOT__done)))) {
        co_await vlSelf->__VtrigSched_hefcf8835__0.trigger(1U, 
                                                           nullptr, 
                                                           "@([changed] tb_fsm_measure.done)", 
                                                           "tb_fsm_measure.sv", 
                                                           75);
    }
    VL_WRITEF("Measurement done!\nOscillator count = %10#\nExpected approx ~8000\n",
              32,vlSelf->tb_fsm_measure__DOT__count_out);
    co_await vlSelf->__VdlySched.delay(0x1e8480ULL, 
                                       nullptr, "tb_fsm_measure.sv", 
                                       81);
    VL_FINISH_MT("tb_fsm_measure.sv", 82, "");
}

VL_INLINE_OPT VlCoroutine Vfsm_measure___024root___eval_initial__TOP__Vtiming__1(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_initial__TOP__Vtiming__1\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0x1f40ULL, 
                                           nullptr, 
                                           "tb_fsm_measure.sv", 
                                           52);
        vlSelf->tb_fsm_measure__DOT__osc_in = (1U & 
                                               (~ (IData)(vlSelf->tb_fsm_measure__DOT__osc_in)));
    }
}

VL_INLINE_OPT VlCoroutine Vfsm_measure___024root___eval_initial__TOP__Vtiming__2(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_initial__TOP__Vtiming__2\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0x7a120ULL, 
                                           nullptr, 
                                           "tb_fsm_measure.sv", 
                                           49);
        vlSelf->tb_fsm_measure__DOT__clk_ref = (1U 
                                                & (~ (IData)(vlSelf->tb_fsm_measure__DOT__clk_ref)));
    }
}

VL_INLINE_OPT void Vfsm_measure___024root___act_comb__TOP__0(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___act_comb__TOP__0\n"); );
    // Body
    vlSelf->tb_fsm_measure__DOT__dut__DOT__next_state 
        = ((0U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))
            ? ((IData)(vlSelf->tb_fsm_measure__DOT__start)
                ? 1U : 0U) : ((1U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))
                               ? ((0x80U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__ref_counter))
                                   ? 2U : 1U) : 0U));
}

void Vfsm_measure___024root___eval_act(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_act\n"); );
    // Body
    if ((6ULL & vlSelf->__VactTriggered.word(0U))) {
        Vfsm_measure___024root___act_comb__TOP__0(vlSelf);
    }
}

extern const VlUnpacked<CData/*0:0*/, 4> Vfsm_measure__ConstPool__TABLE_hb34e3fe2_0;

VL_INLINE_OPT void Vfsm_measure___024root___nba_sequent__TOP__0(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*1:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    SData/*15:0*/ __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter;
    __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter = 0;
    IData/*31:0*/ __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter;
    __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter = 0;
    // Body
    __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter 
        = vlSelf->tb_fsm_measure__DOT__dut__DOT__osc_counter;
    __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter 
        = vlSelf->tb_fsm_measure__DOT__dut__DOT__ref_counter;
    if (vlSelf->tb_fsm_measure__DOT__rst_n) {
        if ((0U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))) {
            __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter = 0U;
            __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter = 0U;
        } else if ((1U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))) {
            __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter 
                = (0xffffU & ((IData)(1U) + (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__ref_counter)));
            if (vlSelf->tb_fsm_measure__DOT__osc_in) {
                __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter 
                    = ((IData)(1U) + vlSelf->tb_fsm_measure__DOT__dut__DOT__osc_counter);
            }
        } else {
            if ((2U != (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))) {
                __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter = 0U;
            }
            if ((2U == (IData)(vlSelf->tb_fsm_measure__DOT__dut__DOT__state))) {
                vlSelf->tb_fsm_measure__DOT__count_out 
                    = vlSelf->tb_fsm_measure__DOT__dut__DOT__osc_counter;
            } else {
                __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter = 0U;
                vlSelf->tb_fsm_measure__DOT__count_out = 0U;
            }
        }
        vlSelf->tb_fsm_measure__DOT__dut__DOT__state 
            = vlSelf->tb_fsm_measure__DOT__dut__DOT__next_state;
    } else {
        __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter = 0U;
        __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter = 0U;
        vlSelf->tb_fsm_measure__DOT__count_out = 0U;
        vlSelf->tb_fsm_measure__DOT__dut__DOT__state = 0U;
    }
    vlSelf->tb_fsm_measure__DOT__dut__DOT__ref_counter 
        = __Vdly__tb_fsm_measure__DOT__dut__DOT__ref_counter;
    vlSelf->tb_fsm_measure__DOT__dut__DOT__osc_counter 
        = __Vdly__tb_fsm_measure__DOT__dut__DOT__osc_counter;
    __Vtableidx1 = vlSelf->tb_fsm_measure__DOT__dut__DOT__state;
    vlSelf->tb_fsm_measure__DOT__done = Vfsm_measure__ConstPool__TABLE_hb34e3fe2_0
        [__Vtableidx1];
}

void Vfsm_measure___024root___eval_nba(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vfsm_measure___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((7ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vfsm_measure___024root___act_comb__TOP__0(vlSelf);
    }
}

void Vfsm_measure___024root___timing_commit(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___timing_commit\n"); );
    // Body
    if ((! (4ULL & vlSelf->__VactTriggered.word(0U)))) {
        vlSelf->__VtrigSched_hefcf8835__0.commit("@([changed] tb_fsm_measure.done)");
    }
}

void Vfsm_measure___024root___timing_resume(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___timing_resume\n"); );
    // Body
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VtrigSched_hefcf8835__0.resume("@([changed] tb_fsm_measure.done)");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

void Vfsm_measure___024root___eval_triggers__act(Vfsm_measure___024root* vlSelf);

bool Vfsm_measure___024root___eval_phase__act(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<3> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vfsm_measure___024root___eval_triggers__act(vlSelf);
    Vfsm_measure___024root___timing_commit(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vfsm_measure___024root___timing_resume(vlSelf);
        Vfsm_measure___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vfsm_measure___024root___eval_phase__nba(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vfsm_measure___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__nba(Vfsm_measure___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__act(Vfsm_measure___024root* vlSelf);
#endif  // VL_DEBUG

void Vfsm_measure___024root___eval(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vfsm_measure___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("tb_fsm_measure.sv", 5, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vfsm_measure___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("tb_fsm_measure.sv", 5, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vfsm_measure___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vfsm_measure___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vfsm_measure___024root___eval_debug_assertions(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
