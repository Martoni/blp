Testing blinking led on kintex7. The objective it to test new Module class
hierarchy of chisel3.

Installing Chisel3
==================
Chisel3 installation guide is given on official github :
https://github.com/ucb-bar/chisel3

To test new Module hierarchy, use the branch modhier:

```shell
$ git merge upstream/modhier
$ sbt publish-local
```


Converting verilog
==================

To convert it in verilog type :

```shell
$ sbt "run-main TopBlinkDriver" 
```
