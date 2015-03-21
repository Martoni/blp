WAVE=gtkwave
VCC=iverilog
VEXEC=vvp
SIMU_DIR=simu
GHDL_FLAGS=
VERILATOR=verilator
VERILATOR_FLAGS=--trace
VERILATOR_DIR=obj_dir

button_deb: test/test_button_deb.v src/button_deb.v
	echo "Button_deb" >> time.txt
	date >> time.txt
	mkdir -p $(SIMU_DIR)
	$(VCC) -o $(SIMU_DIR)/$@ $^
	$(VEXEC) $(SIMU_DIR)/$@ -lvcd
	echo "end Button_deb" >> time.txt
	date >> time.txt

button_deb_view : $(SIMU_DIR)/button_deb_tb.vcd
	$(WAVE) $<

$(VERILATOR_DIR)/Vbutton_deb.h: src/button_deb.v test/test_button_deb.cpp
	echo "convert verilog model in C++ model" >> time.txt
	date >> time.txt
	$(VERILATOR) -Wall -cc src/button_deb.v $(VERILATOR_FLAGS)\
		--exe test/test_button_deb.cpp
	echo "end of convertion" >> time.txt
	date >> time.txt

verilator_button: $(VERILATOR_DIR)/Vbutton_deb.h
	echo "simulate verilator model" >> time.txt
	date >> time.txt
	$(MAKE) -C $(VERILATOR_DIR)/ -j -f Vbutton_deb.mk Vbutton_deb
	./$(VERILATOR_DIR)/Vbutton_deb
	echo "end of simulation" >> time.txt
	date >> time.txt

clean:
	-rm -rf $(SIMU_DIR)
	-rm -rf $(VERILATOR_DIR)
	-rm time.txt
