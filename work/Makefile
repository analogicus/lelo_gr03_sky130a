
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

mag:
	cicpy sch2mag ${LIB} ${CELL} ${OPT}

annotate:
	klayout -b -r annotate_terminals.py -rd cell=${PRCELL}

gds2mag:
	${ECHO} "gds read gds/${PRCELL}.gds\nload ${PRCELL}\nsave ../design/${LIB}/${PRCELL}.mag\nquit" > gds/${PRCELL}_gds2mag.tcl
	magic -noconsole -dnull gds/${PRCELL}_gds2mag.tcl

klvs:
	test -d lvs || mkdir lvs
	klayout -b -r ${PDKPATH}/libs.tech/klayout/lvs/sky130.lvs -rd input=gds/${PRCELL}.gds -rd report=${PWD}/lvs/${PRCELL}_klvs.lvsdb -rd schematic=${PWD}/cdl/${PRCELL}.spice -rd target_netlist=${PWD}/lvs/${PRCELL}_klvs_extracted.cir -rd thr=8 -rd run_mode=deep -rd spice_net_names=true -rd verbose=true >& lvs/${PRCELL}_klvs.log
	@tail -5 lvs/${PRCELL}_klvs.log
