include ../tech/make/sim.make

LIB=LELO_GR03_SKY130A
CELL=LELO_GR03

SCHEMATICS = BANDGAP_OTA BANDGAP_CIRCUIT COMPARATOR OSCILLATOR
SCH_DIR = ../design/$(LIB)
SVG_DIR = ../svgs

schematics:
	@cd ../work && for s in $(SCHEMATICS); do \
		echo "Exporting $$s.sch -> svgs/$$s.svg"; \
		xschem -x -q --svg --plotfile $(abspath $(SVG_DIR))/$$s.svg $(abspath $(SCH_DIR))/$$s.sch 2>/dev/null; \
	done
	@python3 svg_fit.py $(foreach s,$(SCHEMATICS),$(SVG_DIR)/$(s).svg)
