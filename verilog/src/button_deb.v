// Author : Fabien Marteau <fabien.marteau@armadeus.com>
// Creation Date : 02/11/2014

module button_deb(clk, rst, button_in, button_valid);

//Generics parameters
parameter clk_freq = 95000; // clock frequency in kHz
parameter debounce_per_ms = 20;

// sync design
input    clk;
input    rst;
// in-out
input    button_in;
output   button_valid;

endmodule
