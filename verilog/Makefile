WAVE=gtkwave
VCC=iverilog
VEXEC=vvp
SIMU_DIR=simu
GHDL_FLAGS=
VERILATOR=verilator
VERILATOR_FLAGS=-Wno-REALCVT

button_deb: test/test_button_deb.v src/button_deb.v
	mkdir -p $(SIMU_DIR)
	$(VCC) -o $(SIMU_DIR)/$@ $^
	$(VEXEC) $(SIMU_DIR)/$@ -lxt2

button_deb_view : $(SIMU_DIR)/button_deb_tb.lxt
	$(WAVE) $<

verilator_button: src/button_deb.v
	$(VERILATOR) -cc $^ $(VERILATOR_FLAGS)

clean:
	rm -rf $(SIMU_DIR)
