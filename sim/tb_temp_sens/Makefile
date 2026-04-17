CORNER ?= KttTtVt
CORNERS := $(shell python3 fit_osc.py --list)
IVFLAGS = -g2012

all: fit tb plot readme

fit:
	python3 fit_osc.py $(CORNER)

tb: fit
	iverilog $(IVFLAGS) -o design osc_model.v ../../rtl/temp_sens.sv tb.v
	vvp -n design

plot:
	python3 tb.py

all-corners:
	@mkdir -p output
	@for c in $(CORNERS); do \
		echo "=== $$c ==="; \
		python3 fit_osc.py $$c && \
		iverilog $(IVFLAGS) -o design osc_model.v ../../rtl/temp_sens.sv tb.v && \
		vvp -n design && \
		mv tb.csv output/tb_$$c.csv; \
	done
	python3 tb.py

readme:
	python3 ../update_readme.py

clean:
	-rm -f design tb.vcd tb.csv osc_params.vh
	-rm -rf output

# ------------------------------------------------------------
# Gate-level simulation with SDF back-annotation.
#   Consumes LibreLane outputs under ../../rtl/runs/<latest>/final/
# ------------------------------------------------------------
RUN_DIR  := $(shell ls -td ../../rtl/runs/*/ 2>/dev/null | head -1)
# Support both layouts: local nix-run ($(RUN_DIR)final/...) and CI artifact
# ($(RUN_DIR)full_run/final/...).
FINAL    := $(shell for p in $(RUN_DIR)final $(RUN_DIR)full_run/final; do [ -d $$p ] && echo $$p && break; done)
NL       := $(shell ls $(FINAL)/pnl/temp_sens.*.v 2>/dev/null | head -1)
SDF      := $(shell ls $(FINAL)/sdf/nom_tt_025C_1v80/*.sdf 2>/dev/null | head -1)
SKY130V := /opt/pdk/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/verilog
CELLS   := $(SKY130V)/primitives.v $(SKY130V)/sky130_fd_sc_hd.v

gls: fit
	@test -f $(NL)  || (echo "ERROR: netlist missing: $(NL)"; exit 1)
	@test -f $(SDF) || (echo "ERROR: SDF missing: $(SDF)"; exit 1)
	iverilog $(IVFLAGS) -gspecify -DUSE_POWER_PINS -DSDF_FILE=\"$(SDF)\" \
	    -o gls_design $(CELLS) $(NL) osc_model.v tb_gls.v
	vvp -n gls_design
	mv gls.csv gls_$(CORNER).csv
	python3 compare_calibration.py /tmp/rtl-baseline/tb_$(CORNER).csv gls_$(CORNER).csv

gls-all:
	@for c in $$(python3 fit_osc.py --list) ; do \
	    echo "=== GLS $$c ===" ; \
	    python3 fit_osc.py $$c && $(MAKE) gls CORNER=$$c || exit 1 ; \
	done
