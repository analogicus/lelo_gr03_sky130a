
#- Core makefile provides the following commands:
# -----------------------------------------------------------
# gds: generate gds/<CELL>.gds
# cdl: generate cdl/<CELL>.cdl
# xsch: generate xsch/<CELL>.spice
# lvs: Check cdl/<CELL>.cdl versus ../design/<LIB>/<CELL>.mag
# lpe: Extract parasitics lpe/<CELL>.spi
# drc: Run design rule checks on ../design/<LIB>/<CELL>.mag
# -----------------------------------------------------------

PREFIX=
LIB=LELO_GR03_SKY130A
CELL=LELO_GR03

#- Provide cells you want to check for the lvsall drcall commands
CELLS = LELO_GR03

include ../tech/make/core.make

# Override xlvs to strip Magic's rf_pnp BJT wrapper subcircuit before netgen;
# the upstream core.make lacks this step and netgen segfaults on the **devattr line.
xlvs:
	test -d lvs || mkdir lvs
	cat ../tech/magic/lvs.tcl|perl -pe 's#{PATH}#${LMAG}#ig;s#{CELL}#${PRCELL}#ig;' > lvs/${PRCELL}_spi.tcl
	magic -noconsole -dnull lvs/${PRCELL}_spi.tcl > lvs/${PRCELL}_spi.log ${RDIR}
	perl -i -0pe 's/\.subckt sky130_fd_pr__pnp_05v5_W\S+.*?\.ends\n//sg' lvs/${PRCELL}.spi
	netgen -batch lvs "lvs/${PRCELL}.spi ${PRCELL}"  "cdl/${PRCELL}.spice ${PRCELL}" ${PDKPATH}/libs.tech/netgen/sky130A_setup.tcl lvs/${PRCELL}_lvs.log > lvs/${PRCELL}_netgen_lvs.log
	cat lvs/${PRCELL}_lvs.log | ../tech/script/checklvs ${PRCELL} ${OPT}

# Override lpe to fix flat-extraction n-well connectivity bug in digital cells:
# Magic's flatten doesn't maintain the JNWTR_TAPCELLB_CV ntap-to-AVDD connection,
# leaving all DFF PMOS bodies on a floating net. Post-process to correct this.
# Node names below match Magic rev 589 (local); CI uses rev 541 — debug output added.
lpe: xsch
	test -d lpe || mkdir lpe
	-rm lpe/${PRCELL}_lpe.spi
	cat ../tech/magic/lpe.tcl |perl -pe 's#{PATH}#${LMAG}#ig;s#{CELL}#${PRCELL}#ig;'  > lpe/${PRCELL}_lpe.tcl
	magic -noconsole -dnull lpe/${PRCELL}_lpe.tcl ${RDIR} | tee lpe/${PRCELL}_magic_lpe.log
	perl -pi -e "s/_flat//ig;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA0\.MP1\.G\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA3\.C\b/x10.XA1.Y/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA4\.CN\b/x10.XA1.Y/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA6\.CN\b/x10.XA1.Y/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA5\.A\b/x10.XA3.Y/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA5\.Y\b/x10.XA6.A/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA4\.A\b/x10.XA6.A/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA6\.Y\b/x10.D/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA1\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA2\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA3\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA4\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA5\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA6\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA8\.MP0\.S\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA1\.MP1\.D\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA7\.MP2\.D\b/VDD_1V8/g;" lpe/${PRCELL}_lpe.spi
	perl -pi -e "s/\bx10\.XA7\.A\b/OSC_TEMP_1V8/g;" lpe/${PRCELL}_lpe.spi
	../tech/script/fixlpe lpe/${PRCELL}_lpe.spi xsch/${PRCELL}.spice ${PRCELL}
	echo "Running LVS on the extracted netlist to confirm it's the same"
	cat lpe/${PRCELL}_lpe.spi |egrep -v "^C" > lpe/${PRCELL}_lpe_noc.spi
	netgen -batch lvs "lpe/${PRCELL}_lpe_noc.spi ${PRCELL}"  "cdl/${PRCELL}.spice ${PRCELL}" ${PDKPATH}/libs.tech/netgen/sky130A_setup.tcl lpe/${PRCELL}_lvs.log > lpe/${PRCELL}_netgen_lvs.log
	@echo "=== LPE LVS log (for CI debugging) ==="
	@cat lpe/${PRCELL}_lvs.log
	@echo "=== x10 DFF nets in extracted netlist ==="
	@grep "x10\." lpe/${PRCELL}_lpe_noc.spi | head -30 || true
	@echo "=== PFET body connections in extracted netlist ==="
	@grep -i "pfet_01v8" lpe/${PRCELL}_lpe_noc.spi | head -20 || true
	cat lpe/${PRCELL}_lvs.log | ../tech/script/checklvs ${PRCELL} --short

mag:
	cicpy sch2mag ${LIB} ${CELL} ${OPT}

annotate:
	klayout -b -r annotate_terminals.py -rd cell=${PRCELL}

gds2mag:
	${ECHO} "gds read gds/${PRCELL}.gds\nload ${PRCELL}\nsave ../design/${LIB}/${PRCELL}.mag\nquit" > gds/${PRCELL}_gds2mag.tcl
	magic -noconsole -dnull gds/${PRCELL}_gds2mag.tcl
	@if [ -f ${PRCELL}.ports ]; then python3 patch_ports.py ../design/${LIB}/${PRCELL}.mag ${PRCELL}.ports; fi

klvs:
	test -d lvs || mkdir lvs
	klayout -b -r ${PDKPATH}/libs.tech/klayout/lvs/sky130.lvs -rd input=gds/${PRCELL}.gds -rd report=${PWD}/lvs/${PRCELL}_klvs.lvsdb -rd schematic=${PWD}/cdl/${PRCELL}.spice -rd target_netlist=${PWD}/lvs/${PRCELL}_klvs_extracted.cir -rd thr=8 -rd run_mode=deep -rd spice_net_names=true -rd verbose=true >& lvs/${PRCELL}_klvs.log
	@tail -5 lvs/${PRCELL}_klvs.log

klview:
	klayout -n sky130 -e gds/${PRCELL}.gds &

# Render layout to vector SVG / PDF using Magic's Cairo backend.
# Needs xvfb-run (xorg-server-xvfb) and chromium (for SVG -> PDF;
# rsvg-convert can't handle Magic's <pattern>+<filter> layer fills).
#
#   make svg CELL=LELO_GR03         -> renders/LELO_GR03.svg
#   make pdf CELL=LELO_GR03         -> renders/LELO_GR03.pdf
#
# README figures (committed to ../svgs/, referenced by README.md):
#   make readme-figures             -> ../svgs/LELO_GR03.{svg,pdf}
#                                      ../svgs/physical_design.{svg,pdf}
SVG_TECH ?= ${PDKPATH}/libs.tech/magic/sky130A.tech
SVG_PUBDIR := ../svgs
XVFB_GEOM ?= -screen 0 2000x1500x24

# Local (gitignored) renders -------------------------------------------------
renders:
	mkdir -p $@

renders/%.svg: | renders
	printf 'load %s\nexpand\nselect top cell\nfindbox zoom\nplot svg %s\nquit -noprompt\n' '$*' '$@' | xvfb-run -a -s "$(XVFB_GEOM)" magic -d XR -noconsole -T $(SVG_TECH)

renders/%.pdf: renders/%.svg
	./svg2pdf.sh $< $@

svg: renders/${PRCELL}.svg
pdf: renders/${PRCELL}.pdf

# Published figures (committed to ../svgs/, picked up by README) -------------
$(SVG_PUBDIR)/%.svg:
	@mkdir -p $(SVG_PUBDIR)
	printf 'load %s\nexpand\nselect top cell\nfindbox zoom\nplot svg %s\nquit -noprompt\n' '$*' '$@' | xvfb-run -a -s "$(XVFB_GEOM)" magic -d XR -noconsole -T $(SVG_TECH)

# Special case: physical_design.svg renders the Tiny Tapeout wrapper. The
# wrapper's sub-cells (LELO_GR03, temp_sens) are not expand-marked in the
# .mag, so we expand LELO_GR03 explicitly and unexpand the digital sea-of-
# cells inside it ("hide tiny details").
$(SVG_PUBDIR)/physical_design.svg:
	@mkdir -p $(SVG_PUBDIR)
	printf 'load tt_um_lelo_gr03_analogicus\nselect cell LELO_GR03_1\nexpand\nselect cell LELO_GR03_1/temp_sens_0\nunexpand\nselect top cell\nfindbox zoom\nplot svg %s\nquit -noprompt\n' '$@' | xvfb-run -a -s "$(XVFB_GEOM)" magic -d XR -noconsole -T $(SVG_TECH)

$(SVG_PUBDIR)/%.pdf: $(SVG_PUBDIR)/%.svg
	./svg2pdf.sh $< $@

.PHONY: readme-figures
readme-figures: $(SVG_PUBDIR)/LELO_GR03.svg $(SVG_PUBDIR)/LELO_GR03.pdf $(SVG_PUBDIR)/physical_design.svg $(SVG_PUBDIR)/physical_design.pdf
	@echo "README figures regenerated under $(SVG_PUBDIR)/"
