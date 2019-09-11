## This is a reproducer for a bug of 'risingedge'

This bug is reproduced with :
* Chisel3 : for HDL verilog generating code
* Icarus verilog : for simulation
* Cocotb : for testbench.

To reproduce bug uncomment and comment lines in source risingedge.scala as following:


  // seems to not work with icarus + cocotb
  def risingedge(x: Bool) = x && !RegNext(x)
  def fallingedge(x: Bool) = !x && RegNext(x)
  // works with icarus + cocotb
  //def risingedge(x: Bool) = x && !RegNext(RegNext(x))
  //def fallingedge(x: Bool) = !x && RegNext(RegNext(x))

Then go to directory chisel/risingedge/cocotb and do make :

$ make

Once simulation done see the wave with gtkwave :

$ gtkwave RisingEdge.vcd 


