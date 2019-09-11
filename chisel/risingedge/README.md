# This is a reproducer for a bug of 'risingedge'

Question on stackoverflow : [RisingEdge example doesn't work for module input signal in Chisel3](https://stackoverflow.com/questions/57866167/risingedge-example-doesnt-work-for-module-input-signal-in-chisel3)

This bug is reproduced with :
* Chisel3 : for HDL verilog generating code
* Icarus verilog : for simulation
* Cocotb : for testbench.

To reproduce bug uncomment and comment lines in source risingedge.scala as following:

```scala
  // seems to not work with icarus + cocotb
  def risingedge(x: Bool) = x && !RegNext(x)
  def fallingedge(x: Bool) = !x && RegNext(x)
  // works with icarus + cocotb
  //def risingedge(x: Bool) = x && !RegNext(RegNext(x))
  //def fallingedge(x: Bool) = !x && RegNext(RegNext(x))
```

Then go to directory chisel/risingedge/cocotb and do make :
```bash
$ make
```
Once simulation done see the wave with gtkwave :

```bash
$ gtkwave RisingEdge.vcd 
```

