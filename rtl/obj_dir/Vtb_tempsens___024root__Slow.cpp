// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_tempsens.h for the primary calling header

#include "Vtb_tempsens__pch.h"
#include "Vtb_tempsens__Syms.h"
#include "Vtb_tempsens___024root.h"

void Vtb_tempsens___024root___ctor_var_reset(Vtb_tempsens___024root* vlSelf);

Vtb_tempsens___024root::Vtb_tempsens___024root(Vtb_tempsens__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtb_tempsens___024root___ctor_var_reset(this);
}

void Vtb_tempsens___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vtb_tempsens___024root::~Vtb_tempsens___024root() {
}
