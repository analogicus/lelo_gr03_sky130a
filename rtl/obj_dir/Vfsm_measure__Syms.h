// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VFSM_MEASURE__SYMS_H_
#define VERILATED_VFSM_MEASURE__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vfsm_measure.h"

// INCLUDE MODULE CLASSES
#include "Vfsm_measure___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vfsm_measure__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vfsm_measure* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vfsm_measure___024root         TOP;

    // CONSTRUCTORS
    Vfsm_measure__Syms(VerilatedContext* contextp, const char* namep, Vfsm_measure* modelp);
    ~Vfsm_measure__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
