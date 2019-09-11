SIM=icarus
export COCOTB_REDUCED_LOG_FMT=1
TOPLEVEL=RisingEdge
VERILOG_SOURCES = $(PWD)/$(TOPLEVEL)Cocotb.v
MODULE=test_RisingEdge
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim

$(PWD)/$(TOPLEVEL)Cocotb.v: $(PWD)/../$(TOPLEVEL).v
	python cocotbify.py -v $(PWD)/../$(TOPLEVEL).v -o $(PWD)/$(TOPLEVEL)Cocotb.v

$(PWD)/../$(TOPLEVEL).v: $(PWD)/../src/main/scala/risingedge.scala
	cd $(PWD)/../; make

mrproper:
	- rm $(PWD)/../$(TOPLEVEL).v
	- rm $(PWD)/$(TOPLEVEL)Cocotb.v
