#include "Vbutton_deb.h"
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);
    Vbutton_deb* top = new Vbutton_deb;
   
    int i;

    top->rst = 1;
    top->eval();
    for(i=0; i < 10; i++) {
        top->clk = 0;
        top->rst = 0;
        top->eval();
        top->clk = 1;
    }

    delete top;
    exit(0);
}
