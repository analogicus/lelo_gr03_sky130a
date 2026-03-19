// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtb_tempsens__Syms.h"


VL_ATTR_COLD void Vtb_tempsens___024root__trace_init_sub__TOP__0(Vtb_tempsens___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushPrefix("tb_tempsens", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+15,0,"WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+16,0,"REF_CYCLES",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+7,0,"i_clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+8,0,"i_rst",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"i_start",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+10,0,"i_clk_osc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+1,0,"o_osc_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+2,0,"o_pwrup_osc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+3,0,"o_temperature",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("dut", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+17,0,"WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+18,0,"REF_CYCLES",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+19,0,"TEMP_A",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+20,0,"TEMP_B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBit(c+7,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+8,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"i_start",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+10,0,"i_clk_osc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+1,0,"o_osc_count",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+2,0,"o_pwrup_osc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+3,0,"o_temperature",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+4,0,"cur_state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+11,0,"next_state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+5,0,"cnt_rst",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+12,0,"count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+13,0,"cnt_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 14,0);
    tracep->declBus(c+14,0,"cnt_f",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 14,0);
    tracep->declBus(c+6,0,"ref_cnt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vtb_tempsens___024root__trace_init_top(Vtb_tempsens___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_init_top\n"); );
    // Body
    Vtb_tempsens___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vtb_tempsens___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vtb_tempsens___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtb_tempsens___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtb_tempsens___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vtb_tempsens___024root__trace_register(Vtb_tempsens___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_register\n"); );
    // Body
    tracep->addConstCb(&Vtb_tempsens___024root__trace_const_0, 0U, vlSelf);
    tracep->addFullCb(&Vtb_tempsens___024root__trace_full_0, 0U, vlSelf);
    tracep->addChgCb(&Vtb_tempsens___024root__trace_chg_0, 0U, vlSelf);
    tracep->addCleanupCb(&Vtb_tempsens___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtb_tempsens___024root__trace_const_0_sub_0(Vtb_tempsens___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtb_tempsens___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_const_0\n"); );
    // Init
    Vtb_tempsens___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtb_tempsens___024root*>(voidSelf);
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtb_tempsens___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtb_tempsens___024root__trace_const_0_sub_0(Vtb_tempsens___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_const_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+15,(0x10U),32);
    bufp->fullIData(oldp+16,(0x80U),32);
    bufp->fullIData(oldp+17,(0x10U),32);
    bufp->fullIData(oldp+18,(0x80U),32);
    bufp->fullIData(oldp+19,(1U),32);
    bufp->fullIData(oldp+20,(0U),32);
}

VL_ATTR_COLD void Vtb_tempsens___024root__trace_full_0_sub_0(Vtb_tempsens___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtb_tempsens___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_full_0\n"); );
    // Init
    Vtb_tempsens___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtb_tempsens___024root*>(voidSelf);
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtb_tempsens___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtb_tempsens___024root__trace_full_0_sub_0(Vtb_tempsens___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_tempsens__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_tempsens___024root__trace_full_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullSData(oldp+1,(vlSelf->tb_tempsens__DOT__o_osc_count),16);
    bufp->fullBit(oldp+2,((1U == (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))));
    bufp->fullSData(oldp+3,(vlSelf->tb_tempsens__DOT__o_temperature),16);
    bufp->fullCData(oldp+4,(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state),2);
    bufp->fullBit(oldp+5,(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_rst));
    bufp->fullCData(oldp+6,(vlSelf->tb_tempsens__DOT__dut__DOT__ref_cnt),8);
    bufp->fullBit(oldp+7,(vlSelf->tb_tempsens__DOT__i_clk));
    bufp->fullBit(oldp+8,(vlSelf->tb_tempsens__DOT__i_rst));
    bufp->fullBit(oldp+9,(vlSelf->tb_tempsens__DOT__i_start));
    bufp->fullBit(oldp+10,(vlSelf->tb_tempsens__DOT__i_clk_osc));
    bufp->fullCData(oldp+11,(((2U & (IData)(vlSelf->tb_tempsens__DOT__dut__DOT__cur_state))
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
    bufp->fullSData(oldp+12,(vlSelf->tb_tempsens__DOT__dut__DOT__count),16);
    bufp->fullSData(oldp+13,(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_r),15);
    bufp->fullSData(oldp+14,(vlSelf->tb_tempsens__DOT__dut__DOT__cnt_f),15);
}
