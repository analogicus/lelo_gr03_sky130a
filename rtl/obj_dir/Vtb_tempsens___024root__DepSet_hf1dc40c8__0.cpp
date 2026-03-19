// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_tempsens.h for the primary calling header

#include "Vtb_tempsens__pch.h"
#include "Vtb_tempsens__Syms.h"
#include "Vtb_tempsens___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__act(Vtb_tempsens___024root* vlSelf);
#endif  // VL_DEBUG

void Vtb_tempsens___024root___eval_triggers__act(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, (((IData)(vlSelf->tb_tempsens__DOT__i_clk) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk__0))) 
                                     | ((IData)(vlSelf->tb_tempsens__DOT__i_rst) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_rst__0)))));
    vlSelf->__VactTriggered.set(1U, (((IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__dut__DOT__cnt_rst__0))) 
                                     | ((IData)(vlSelf->tb_tempsens__DOT__i_clk_osc) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk_osc__0)))));
    vlSelf->__VactTriggered.set(2U, (((IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__dut__DOT__cnt_rst__0))) 
                                     | ((~ (IData)(vlSelf->tb_tempsens__DOT__i_clk_osc)) 
                                        & (IData)(vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk_osc__0))));
    vlSelf->__VactTriggered.set(3U, vlSelf->__VdlySched.awaitingCurrentTime());
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk__0 
        = vlSelf->tb_tempsens__DOT__i_clk;
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_rst__0 
        = vlSelf->tb_tempsens__DOT__i_rst;
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__dut__DOT__cnt_rst__0 
        = vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst;
    vlSelf->__Vtrigprevexpr___TOP__tb_tempsens__DOT__i_clk_osc__0 
        = vlSelf->tb_tempsens__DOT__i_clk_osc;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtb_tempsens___024root___dump_triggers__act(vlSelf);
    }
#endif
}
