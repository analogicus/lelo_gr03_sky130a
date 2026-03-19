// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsm_measure.h for the primary calling header

#include "Vfsm_measure__pch.h"
#include "Vfsm_measure__Syms.h"
#include "Vfsm_measure___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__act(Vfsm_measure___024root* vlSelf);
#endif  // VL_DEBUG

void Vfsm_measure___024root___eval_triggers__act(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, (((IData)(vlSelf->tb_fsm_measure__DOT__clk_ref) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__clk_ref__0))) 
                                     | ((~ (IData)(vlSelf->tb_fsm_measure__DOT__rst_n)) 
                                        & (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__rst_n__0))));
    vlSelf->__VactTriggered.set(1U, vlSelf->__VdlySched.awaitingCurrentTime());
    vlSelf->__VactTriggered.set(2U, ((IData)(vlSelf->tb_fsm_measure__DOT__done) 
                                     != (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__done__0)));
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__clk_ref__0 
        = vlSelf->tb_fsm_measure__DOT__clk_ref;
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__rst_n__0 
        = vlSelf->tb_fsm_measure__DOT__rst_n;
    vlSelf->__Vtrigprevexpr___TOP__tb_fsm_measure__DOT__done__0 
        = vlSelf->tb_fsm_measure__DOT__done;
    if (VL_UNLIKELY((1U & (~ (IData)(vlSelf->__VactDidInit))))) {
        vlSelf->__VactDidInit = 1U;
        vlSelf->__VactTriggered.set(2U, 1U);
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfsm_measure___024root___dump_triggers__act(vlSelf);
    }
#endif
}
