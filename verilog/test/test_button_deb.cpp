#include "Vbutton_deb.h"
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <iostream>

/* Clock frequency in kHz */
#define CLK_FREQ 95000
#define DEBOUNCE_PER_MS 20

#define BASE_TIME_NS ((1000*1000)/(CLK_FREQ*2))
int base_time = 0;

/* the time is passing */
void time_pass(VerilatedVcdC *tfp, Vbutton_deb *top) {
        top->clk = !top->clk;
        tfp->dump(base_time*BASE_TIME_NS);
        top->eval();
        base_time++;
}

/* wait for us */
void wait_us(VerilatedVcdC *tfp, Vbutton_deb *top, int timeus) {
    int wait_time = 0;
    while((wait_time * BASE_TIME_NS) < (timeus * 1000)) {
        wait_time++;
        time_pass(tfp, top);
    }
}

/* wait for ms */
void wait_ms(VerilatedVcdC *tfp, Vbutton_deb *top, int timems) {
    int wait_time = 0;
    while((wait_time * BASE_TIME_NS) < (timems * 1000 * 1000)) {
        wait_time++;
        time_pass(tfp, top);
    }
}

/* Main stimulus program */
int main(int argc, char **argv, char **env)
{
    int i;
    Verilated::commandArgs(argc, argv);
    Vbutton_deb* top = new Vbutton_deb;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("simu/verilator_button.vcd");

    /* init */
    top->rst = 1;
    top->button_in = 0;
    wait_ms(tfp, top, 1);
    top->rst = 0;
    wait_ms(tfp, top, DEBOUNCE_PER_MS);
    for(i = 0; i < 2; i++) {
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 5);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 5);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 8);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 8);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 10);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 10);
        top->button_in = 1;

        wait_ms(tfp, top, DEBOUNCE_PER_MS * 2);

        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 5);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 5);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 8);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 8);
        top->button_in = 0;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 10);
        top->button_in = 1;
        wait_us(tfp, top, DEBOUNCE_PER_MS * 10);
        top->button_in = 0;

        wait_ms(tfp, top, DEBOUNCE_PER_MS * 2);
    }
    cout << "Total simulation time : " << (base_time*BASE_TIME_NS) << " ns" << endl;
    cout << "Total simulation time : " << (base_time*BASE_TIME_NS)/1000000 << " ms" << endl;
    /* test end */
    tfp->close();
    delete top;
    cout << "end of tests " << endl;
    exit(0);
}
