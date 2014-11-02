WAVE=gtkwave
VCC=iverilog
VEXEC=vvp
SIMU_DIR=simu
GHDL_FLAGS=

button_deb: test/test_button_deb.v src/button_deb.v
	mkdir -p $(SIMU_DIR)
	$(VCC) -o $(SIMU_DIR)/$@ $^
	$(VEXEC) $(SIMU_DIR)/$@ -vcd=$(SIMU_DIR)/$@.vcd

button_deb_view : $(SIMU_DIR)/button_deb_tb

clean:
	rm -rf $(SIMU_DIR)
