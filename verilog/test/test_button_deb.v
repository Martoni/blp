`timescale 10ns/100ps

module test_button_deb;

  /* Make a reset that pulses once. */
  reg rst = 1;
  initial begin
     # 17 rst = 1;
     # 11 rst = 0;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #0.526 clk = !clk;

  wire button_in;
  wire button_valid;
  button_deb button(clk, rst, button_in, button_valid);

  initial begin
    $dumpfile("simu/button_deb_tb.vcd");
    $dumpvars(0, clk, rst, button_in);
    $monitor("At time %t, value = %h (%0d)",
              $time, button_in, button_in);
    # 500 $finish;
  end

endmodule
