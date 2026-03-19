// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtb_tempsens__Syms.h"


void Vtb_tempsens___024root__trace_chg_0_sub_0(Vtb_tempsens___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtb_tempsens___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_chg_0\n"); );
    // Init
    Vtb_tempsens___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtb_tempsens___024root*>(voidSelf);
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtb_tempsens___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtb_tempsens___024root__trace_chg_0_sub_0(Vtb_tempsens___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgSData(oldp+0,(vlSelf->tb_tempsens__DOT__o_osc_count),16);
        bufp->chgBit(oldp+1,((1U == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))));
        bufp->chgSData(oldp+2,(vlSelf->tb_tempsens__DOT__o_temperature),16);
        bufp->chgCData(oldp+3,(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state),2);
        bufp->chgBit(oldp+4,(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst));
        bufp->chgCData(oldp+5,(vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt),8);
    }
    bufp->chgBit(oldp+6,(vlSelf->tb_tempsens__DOT__i_clk));
    bufp->chgBit(oldp+7,(vlSelf->tb_tempsens__DOT__i_rst));
    bufp->chgBit(oldp+8,(vlSelf->tb_tempsens__DOT__i_start));
    bufp->chgBit(oldp+9,(vlSelf->tb_tempsens__DOT__i_clk_osc));
    bufp->chgCData(oldp+10,(((2U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                              ? ((1U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                                  ? 2U : 0U) : ((1U 
                                                 & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
                                                 ? 
                                                ((0x7fU 
                                                  == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt))
                                                  ? 3U
                                                  : 1U)
                                                 : 
                                                ((IData)(vlSelf->tb_tempsens__DOT__i_start)
                                                  ? 1U
                                                  : 0U)))),2);
    bufp->chgSData(oldp+11,(vlSelf->tb_tempsens__DOT__dut__DOT__count),16);
    bufp->chgSData(oldp+12,(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r),15);
    bufp->chgSData(oldp+13,(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f),15);
}

void Vtb_tempsens___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_cleanup\n"); );
    // Init
    Vtb_tempsens___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtb_tempsens___024root*>(voidSelf);
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
