// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_tempsens.h for the primary calling header

#include "Vtb_tempsens__pch.h"
#include "Vtb_tempsens__Syms.h"
#include "Vtb_tempsens___024root.h"

VL_ATTR_COLD void Vtb_tempsens___024root___eval_initial__TOP(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_initial__TOP\n"); );
    // Body
    vlSymsp->_vm_contextp__->dumpfile(std::string{"wave.vcd"});
    vlSymsp->_traceDumpOpen();
    vlSelf->tb_tempsens__DOT__i_clk = 0U;
    vlSelf->tb_tempsens__DOT__i_clk_osc = 0U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_tempsens___024root___dump_triggers__stl(Vtb_tempsens___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtb_tempsens___024root___eval_triggers__stl(Vtb_tempsens___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtb_tempsens___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
