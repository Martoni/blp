WAVE=gtkwave
VCC=iverilog
VEXEC=vvp
SIMU_DIR=simu
GHDL_FLAGS=
VERILATOR=verilator
VERILATOR_FLAGS=

button_deb: test/test_button_deb.v src/button_deb.v
	mkdir -p $(SIMU_DIR)
	$(VCC) -o $(SIMU_DIR)/$@ $^
	$(VEXEC) $(SIMU_DIR)/$@ -lxt2

button_deb_view : $(SIMU_DIR)/button_deb_tb.lxt
	$(WAVE) $<

verilator_button: src/button_deb.v test/test_button_deb.cpp
	$(VERILATOR) -Wall -cc src/button_deb.v $(VERILATOR_FLAGS)\
		--exe test/test_button_deb.cpp
	make -C obj_dir/ -j -f Vbutton_deb.mk Vbutton_deb

clean:
	-rm -rf $(SIMU_DIR)
	-rm -rf obj_dir
