module test_button_deb;

  /* Make a reset that pulses once. */
  reg rst = 0;
  initial begin
     # 17 rst = 1;
     # 11 rst = 0;
     # 100 $stop;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #5 clk = !clk;

  wire button_in;
  wire button_valid;
  button_deb button(clk, rst, button_in, button_valid);

  initial
     $display("At time %t, value = %h (%0d)",
              $time, button_in, button_in);
endmodule
