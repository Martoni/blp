WAVE=gtkwave
GHDL=ghdl
NVC=nvc
PROJECT_NAME=button_deb
SIMU_DIR=simu
SIMU_OPTS=--assert-level=error
GHDL_FLAGS=--workdir=$(SIMU_DIR) --work=work --ieee=synopsys

button_deb: $(SIMU_DIR)/button_deb_tb.ghw

$(SIMU_DIR)/button_deb_tb.ghw: test/test_$(PROJECT_NAME).vhd src/$(PROJECT_NAME).vhd
	mkdir -p $(SIMU_DIR)
	$(GHDL) -i $(GHDL_FLAGS) $^
	$(GHDL) -m $(GHDL_FLAGS) $(PROJECT_NAME)_tb
	time -o simu_time.txt $(GHDL) -r $(GHDL_FLAGS) $(PROJECT_NAME)_tb --wave=$(SIMU_DIR)/$(PROJECT_NAME)_tb.ghw $(SIMU_OPTS) || exit 0
	echo "End of test"

nvc_button_deb:  test/test_$(PROJECT_NAME).vhd src/$(PROJECT_NAME).vhd
	mkdir -p nvc$(SIMU_DIR)
	cd nvc$(SIMU_DIR); $(NVC) -a ../test/test_$(PROJECT_NAME).vhd ../src/$(PROJECT_NAME).vhd
	cd nvc$(SIMU_DIR); $(NVC) -e $(PROJECT_NAME)_tb
	cd nvc$(SIMU_DIR); $(NVC) -r $(PROJECT_NAME)_tb -w

nvc_view: $(SIMU_DIR)/$(PROJECT_NAME)_tb.fst
	$(WAVE) $^

button_deb_view : $(SIMU_DIR)/button_deb_tb.ghw
	$(WAVE) $<

clean:
	-rm -rf $(SIMU_DIR)
	-rm -rf nvc$(SIMU_DIR)
	-rm simu_time.txt
