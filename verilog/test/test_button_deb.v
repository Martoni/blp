`timescale 1ns/100ps
module test_button_deb;

`define DEBOUNCE_PER_MS 20
// clk freq in kHz
`define CLK_FREQ 95_000

reg clk = 0;
reg rst;
reg button_in;
wire button_valid;

/* Make a regular pulsing clock. */
always
    #5.26 clk = !clk;

/* Button connection */
button_deb #(95_000, 20) button(.clk(clk),
    .rst(rst),
    .button_in(button_in),
    .button_valid(button_valid));

/* Stimulis */
initial begin
    $display("begin stimulis");
    $dumpfile("simu/button_deb_tb.lxt");
    $dumpvars(1, clk, rst, button_in, button_valid, button);
    $monitor("At time %t, value = %h (%0d)",
        $time, button_in, button_in);
    rst = 1;
    button_in = 0;
    wait_ms(1);
    rst = 0;
    wait_ms(`DEBOUNCE_PER_MS);
    repeat(2) begin
        /* 0 to 1 */
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS * 5);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS * 5);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS * 8);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS * 8);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS * 10);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS * 10);
        button_in = 1;

        wait_ms(`DEBOUNCE_PER_MS * 2);

        /* 0 to 1 */
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS * 5);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS * 5);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS * 8);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS * 8);
        button_in = 0;
        wait_us(`DEBOUNCE_PER_MS * 10);
        button_in = 1;
        wait_us(`DEBOUNCE_PER_MS * 10);
        button_in = 0;

        wait_ms(`DEBOUNCE_PER_MS * 2);
    end

    $display("*** End of test ***");
    #1 $finish;
end

/* someusefull functions */
task wait_ms;
    input integer atime;
    begin
        repeat(atime) begin
            # 1_000_000;
        end
    end
endtask

/* some usefull functions */
task wait_us;
    input integer another_time;
    begin
        repeat(another_time) begin
            # 1_000;
        end
    end
endtask

endmodule
