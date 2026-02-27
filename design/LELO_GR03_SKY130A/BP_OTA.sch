v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 380 -370 1180 30 {flags=graph

y2=14.633941
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1


divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node=re(lg_mag)
color=5
dataset=-1
unitx=1
logx=1
logy=0
sim_type=ac

y1=-38.969266
autoload=1
x1=2.2288163
x2=11.293323}
B 2 380 50 1180 450 {flags=graph


ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1

x2=11.293323
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=1
logy=0
sim_type=ac
x1=2.2288163
y1=-330.16177
y2=9.80623
color=4
node=re(lg_phase)
autoload=0
rawfile=$netlist_dir/TB_LELOTEMP_BIAS_IBP_LSTB.raw}
N -230 40 -230 60 {
lab=VDD_1V8}
N -150 40 -150 60 {lab=IN}
C {devices/code_shown.sym} -719.3514969502943 -300 0 0 {name=s1 only_toplevel=false value="

.lib "../../../tech/ngspice/corners.spi" Ktt
.lib "../../../tech/ngspice/temperature.spi" Tt
.lib "../../../tech/ngspice/supply.spi" Vt
.include ../../../../cpdk/ngspice/tian_subckt.lib
X999 LPI LPO loopgainprobe

.control
optran 0 0 0 10n 20u 0
save alli
save allv
save @m.*[gm]
op
remzerovec
write TB_LELOTEMP_BIAS_IBP_LSTB_OP.raw
unsave all

save allv
save i(v1) i(v2)
* Set voltage AC to 1
ac dec 50 100 1G
* Set Current to 1
alter i.X999.Ii acmag=1
alter v.X999.Vi acmag=0
ac dec 50 100 1G
let lg_mag = db(tian_loop())
let lg_phase = 180*cph(tian_loop())/pi
remzerovec
write TB_LELOTEMP_BIAS_IBP_LSTB.raw

meas ac gm_db find lg_mag when lg_phase=0
meas ac pm_deg find lg_phase when lg_mag=0
meas ac f3db when lg_phase=135
meas ac ug when lg_mag=0
meas ac lf_gain find lg_mag at=1k
remzerovec
write TB_LELOTEMP_BIAS_IBP_LSTB_meas.raw
exit
.endc
.end

"}
C {devices/vsource.sym} -230 90 0 0 {name=V1 value=1.8 savecurrent=false}
C {devices/lab_wire.sym} -230 40 0 0 {name=p6 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/capa.sym} -40 -40 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} -40 -70 0 0 {name=p11 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -40 -10 0 1 {name=p12 sig_type=std_logic lab=LPI}
C {devices/lab_wire.sym} 0 140 0 0 {name=p1 sig_type=std_logic lab=LPI}
C {devices/lab_wire.sym} 300 120 0 1 {name=p2 sig_type=std_logic lab=LPO}
C {devices/lab_wire.sym} 150 40 0 0 {name=p3 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/lab_wire.sym} 210 200 2 0 {name=p4 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/vsource.sym} -150 90 0 0 {name=V2 value=0.8 savecurrent=false}
C {devices/lab_wire.sym} -150 40 0 0 {name=p5 sig_type=std_logic lab=IN
value=1.8}
C {devices/lab_wire.sym} 0 100 0 0 {name=p7 sig_type=std_logic lab=IN
value=1.8}
C {devices/capa.sym} 300 150 0 0 {name=C2
m=1
value=200f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 150 200 2 0 {name=p8 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} 210 40 0 1 {name=p9 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -150 120 2 0 {name=p10 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -230 120 2 0 {name=p13 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} 300 180 2 0 {name=p14 sig_type=std_logic lab=0
value=1.8}
C {LELO_GR03_SKY130A/COMPARATOR.sym} 150 100 0 0 {name=x1}
