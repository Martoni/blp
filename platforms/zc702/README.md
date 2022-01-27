# To blink led on Zynq dev kit zc702

- Create a Vivado project
- use part XC7Z020CLG484-1
- add following file :
  - `blink.v`
  - `blink.ucf`
  - `rst_gen.v`
- set `blink.v` as top hierarchy
- launch bitstream generation
- load bitstream with [openFPGALoader](https://github.com/trabucayre/openFPGALoader) :

```
$ openFPGALoader -c digilent blink.bit
Jtag frequency : requested 6.00MHz   -> real 6.00MHz  
Open file DONE
Parse file DONE
load program
Flash SRAM: [===================================================] 100.00%
Done
```

- enjoy
