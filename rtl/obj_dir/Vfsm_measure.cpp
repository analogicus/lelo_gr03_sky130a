// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vfsm_measure__pch.h"

//============================================================
// Constructors

Vfsm_measure::Vfsm_measure(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vfsm_measure__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vfsm_measure::Vfsm_measure(const char* _vcname__)
    : Vfsm_measure(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vfsm_measure::~Vfsm_measure() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vfsm_measure___024root___eval_debug_assertions(Vfsm_measure___024root* vlSelf);
#endif  // VL_DEBUG
void Vfsm_measure___024root___eval_static(Vfsm_measure___024root* vlSelf);
void Vfsm_measure___024root___eval_initial(Vfsm_measure___024root* vlSelf);
void Vfsm_measure___024root___eval_settle(Vfsm_measure___024root* vlSelf);
void Vfsm_measure___024root___eval(Vfsm_measure___024root* vlSelf);

void Vfsm_measure::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vfsm_measure::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vfsm_measure___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vfsm_measure___024root___eval_static(&(vlSymsp->TOP));
        Vfsm_measure___024root___eval_initial(&(vlSymsp->TOP));
        Vfsm_measure___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vfsm_measure___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vfsm_measure::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vfsm_measure::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vfsm_measure::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vfsm_measure___024root___eval_final(Vfsm_measure___024root* vlSelf);

VL_ATTR_COLD void Vfsm_measure::final() {
    Vfsm_measure___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vfsm_measure::hierName() const { return vlSymsp->name(); }
const char* Vfsm_measure::modelName() const { return "Vfsm_measure"; }
unsigned Vfsm_measure::threads() const { return 1; }
void Vfsm_measure::prepareClone() const { contextp()->prepareClone(); }
void Vfsm_measure::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void Vfsm_measure::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'Vfsm_measure::trace()' called on model that was Verilated without --trace option");
}
