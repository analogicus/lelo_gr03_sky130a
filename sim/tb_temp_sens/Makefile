CORNER ?= KttTtVt
CORNERS := $(shell python3 fit_osc.py --list)
IVFLAGS = -g2012

all: fit tb plot

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

clean:
	-rm -f design tb.vcd tb.csv osc_params.vh
	-rm -rf output
