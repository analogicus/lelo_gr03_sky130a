#include "Vfsm_measure.h"
#include "verilated.h"

int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);
    Vfsm_measure* top = new Vfsm_measure;

    while (!Verilated::gotFinish()) {
        top->eval();  // evaluate one timestep
    }

    delete top;
    return 0;
}