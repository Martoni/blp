WAVE=gtkwave
GHDL=ghdl
NVC=nvc
PROJECT_NAME=button_deb
SIMU_DIR=simu
GHDL_FLAGS=--workdir=$(SIMU_DIR) --work=work --ieee=synopsys

button_deb: test/test_$(PROJECT_NAME).vhd src/$(PROJECT_NAME).vhd
	mkdir -p $(SIMU_DIR)
	$(GHDL) -i $(GHDL_FLAGS) $^
	$(GHDL) -m $(GHDL_FLAGS) $@_tb
	mv $@_tb $(SIMU_DIR)/
	time -o simu_time.txt ./$(SIMU_DIR)/$@_tb --assert-level=error --wave=$(SIMU_DIR)/$@_tb.ghw || exit 0
	echo "End of test"

nvc_button_deb:  test/test_$(PROJECT_NAME).vhd src/$(PROJECT_NAME).vhd
	mkdir -p nvc$(SIMU_DIR)
	cd nvc$(SIMU_DIR); $(NVC) -a ../test/test_$(PROJECT_NAME).vhd ../src/$(PROJECT_NAME).vhd
	cd nvc$(SIMU_DIR); $(NVC) -e $(PROJECT_NAME)_tb
	cd nvc$(SIMU_DIR); $(NVC) -r $(PROJECT_NAME)_tb -w

nvc_view: $(SIMU_DIR)/$(PROJECT_NAME)_tb.fst
	$(WAVE) $^

button_deb_view : $(SIMU_DIR)/button_deb_tb
	$(WAVE) $<.ghw

clean:
	rm -rf $(SIMU_DIR)
