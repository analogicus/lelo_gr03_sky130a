// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfsm_measure.h for the primary calling header

#include "Vfsm_measure__pch.h"
#include "Vfsm_measure__Syms.h"
#include "Vfsm_measure___024root.h"

void Vfsm_measure___024root___ctor_var_reset(Vfsm_measure___024root* vlSelf);

Vfsm_measure___024root::Vfsm_measure___024root(Vfsm_measure__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vfsm_measure___024root___ctor_var_reset(this);
}

void Vfsm_measure___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vfsm_measure___024root::~Vfsm_measure___024root() {
}
