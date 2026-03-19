// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsm_measure.h for the primary calling header

#include "Vfsm_measure__pch.h"
#include "Vfsm_measure__Syms.h"
#include "Vfsm_measure___024root.h"

VL_ATTR_COLD void Vfsm_measure___024root___eval_initial__TOP(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_initial__TOP\n"); );
    // Body
    vlSymsp->_vm_contextp__->dumpfile(std::string{"wave.vcd"});
    VL_PRINTF_MT("-Info: tb_fsm_measure.sv:39: $dumpvar ignored, as Verilated without --trace\n");
    vlSelf->tb_fsm_measure__DOT__clk_ref = 0U;
    vlSelf->tb_fsm_measure__DOT__osc_in = 0U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vfsm_measure___024root___dump_triggers__stl(Vfsm_measure___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vfsm_measure___024root___eval_triggers__stl(Vfsm_measure___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vfsm_measure__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfsm_measure___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vfsm_measure___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
