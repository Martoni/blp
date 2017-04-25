SIM=ghdl
VHDL_SOURCES = $(PWD)/../src/button_deb.vhd
TOPLEVEL=button_deb
MODULE=test_$(TOPLEVEL)
SIM_ARGS=--vcd=$(TOPLEVEL).vcd
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
