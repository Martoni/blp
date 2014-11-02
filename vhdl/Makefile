WAVE=gtkwave
GHDL=ghdl
SIMU_DIR=simu
GHDL_FLAGS=--workdir=$(SIMU_DIR) --work=work --ieee=synopsys

button_deb: test/test_button_deb.vhd src/button_deb.vhd
	mkdir -p $(SIMU_DIR)
	$(GHDL) -i $(GHDL_FLAGS) $^
	$(GHDL) -m $(GHDL_FLAGS) $@_tb
	mv $@_tb $(SIMU_DIR)/
	./$(SIMU_DIR)/$@_tb --assert-level=error --wave=$(SIMU_DIR)/$@_tb.ghw || exit 0
	echo "End of test"

button_deb_view : $(SIMU_DIR)/button_deb_tb
	$(WAVE) $<.ghw

clean:
	rm -rf $(SIMU_DIR)
