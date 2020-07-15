SIM=icarus
export COCOTB_REDUCED_LOG_FMT=1
VERILOG_SOURCES = $(PWD)/../src/button_deb.v
TOPLEVEL=button_deb
MODULE=test_$(TOPLEVEL)

include $(shell cocotb-config --makefile)/Makefile.sim
