WAVE=gtkwave
VCC=iverilog
VEXEC=vvp
SIMU_DIR=simu
GHDL_FLAGS=
VERILATOR=verilator
VERILATOR_FLAGS=--trace
VERILATOR_DIR=obj_dir

button_deb: test/test_button_deb.v src/button_deb.v
	mkdir -p $(SIMU_DIR)
	$(VCC) -o $(SIMU_DIR)/$@ $^
	$(VEXEC) $(SIMU_DIR)/$@ -lxt2

button_deb_view : $(SIMU_DIR)/button_deb_tb.lxt
	$(WAVE) $<

$(VERILATOR_DIR)/Vbutton_deb.h: src/button_deb.v test/test_button_deb.cpp
	$(VERILATOR) -Wall -cc src/button_deb.v $(VERILATOR_FLAGS)\
		--exe test/test_button_deb.cpp

verilator_button: $(VERILATOR_DIR)/Vbutton_deb.h
	$(MAKE) -C $(VERILATOR_DIR)/ -j -f Vbutton_deb.mk Vbutton_deb
	./$(VERILATOR_DIR)/Vbutton_deb

clean:
	-rm -rf $(SIMU_DIR)
	-rm -rf $(VERILATOR_DIR)
