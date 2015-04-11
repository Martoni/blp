WAVE=gtkwave
GHDL=ghdl
SIMU_DIR=simu
GHDL_FLAGS=--workdir=$(SIMU_DIR) --work=work --ieee=synopsys

buslib: buslib_tb.vhd buslib_pkg.vhd avlreg.vhd
	mkdir -p $(SIMU_DIR)
	$(GHDL) -i $(GHDL_FLAGS) $^
	$(GHDL) -m $(GHDL_FLAGS) $@_tb
	mv $@_tb $(SIMU_DIR)/
	time -o simu_time.txt ./$(SIMU_DIR)/$@_tb --assert-level=error --wave=$(SIMU_DIR)/$@_tb.ghw || exit 0
	echo "End of test"

buslib_view : $(SIMU_DIR)/buslib_tb
	$(WAVE) $<.ghw

clean:
	rm -rf $(SIMU_DIR)
