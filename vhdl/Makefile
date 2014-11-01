WAVE=gtkwave
GHDL=ghdl
SIMU_DIR=simu
GHDL_FLAGS = --workdir=$(SIMU_DIR) --work=work --ieee=synopsys

button_deb: test/test_button_deb.vhd src/button_deb.vhd
	mkdir -p $(SIMU_DIR)
	$(GHDL) -i $(GHDL_FLAGS) $<
	$(GHDL) -m $(GHDL_FLAGS) $@
