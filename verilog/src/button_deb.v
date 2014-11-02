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

reg button_in_s;
reg button_in_old;

    // synchronize button_in
    always@(posedge clk, posedge rst)
    begin
        if (rst) begin
            button_in_s <= 1'b0;
            button_in_old <= 1'b0;
        end else begin
        end
    end
endmodule
