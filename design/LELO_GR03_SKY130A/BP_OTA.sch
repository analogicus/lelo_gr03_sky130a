v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 380 -370 1180 30 {flags=graph

y2=72
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

y1=-42
autoload=1
x1=1.9578719
x2=8.1510238}
B 2 380 50 1180 450 {flags=graph


ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1

x2=8.1510238
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=1
logy=0
sim_type=ac
x1=1.9578719
y1=-52.376111
y2=252.89686
color=4
node=re(lg_phase)
autoload=0
rawfile=$netlist_dir/TB_LELOTEMP_BIAS_IBP_LSTB.raw}
N -220 240 -220 260 {
lab=VDD_1V8}
N -140 240 -140 260 {lab=IN}
N -30 -40 10 -40 {lab=V_IBN}
N -110 -40 -70 -40 {lab=0}
N -70 80 -70 120 {lab=0}
N -120 -230 -90 -230 {lab=0}
N -170 -320 -110 -320 {lab=0}
N -70 -400 -70 -350 {lab=VDD_1V8}
N -70 -320 -40 -320 {lab=VDD_1V8}
N -40 -370 -40 -320 {lab=VDD_1V8}
N -70 -370 -40 -370 {lab=VDD_1V8}
N -70 70 -70 80 {lab=0}
N -170 40 -110 40 {lab=VDD_1V8}
N -70 40 -40 40 {lab=0}
N -40 40 -40 80 {lab=0}
N -70 80 -40 80 {lab=0}
N -10 -80 -10 -40 {lab=V_IBN}
N -70 -290 -70 -270 {lab=#net1}
N -70 -80 -10 -80 {lab=V_IBN}
N -70 -10 -70 10 {lab=#net2}
N -70 -90 -70 -70 {lab=V_IBN}
N -70 -190 -70 -170 {lab=#net3}
N -120 -130 -90 -130 {lab=0}
N 180 -320 240 -320 {lab=0}
N 140 -400 140 -350 {lab=VDD_1V8}
N 110 -320 140 -320 {lab=VDD_1V8}
N 110 -370 110 -320 {lab=VDD_1V8}
N 110 -370 140 -370 {lab=VDD_1V8}
N 10 -40 100 -40 {lab=V_IBN}
N 140 80 140 120 {lab=0}
N 140 70 140 80 {lab=0}
N 180 40 240 40 {lab=VDD_1V8}
N 110 40 140 40 {lab=0}
N 110 40 110 80 {lab=0}
N 110 80 140 80 {lab=0}
N 140 -10 140 10 {lab=#net4}
N 140 -40 180 -40 {lab=0}
N 140 -150 140 -70 {lab=V_IBP}
N 140 -290 140 -210 {lab=#net5}
N 140 -180 200 -180 {lab=VDD_1V8}
N 80 -180 100 -180 {lab=V_IBP}
N 80 -180 80 -140 {lab=V_IBP}
N 80 -140 140 -140 {lab=V_IBP}
N 50 -180 80 -180 {lab=V_IBP}
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
let lg_phase = 180*cph(-tian_loop())/pi
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
C {devices/vsource.sym} -220 290 0 0 {name=V1 value=1.8 savecurrent=false}
C {devices/lab_wire.sym} -220 240 0 0 {name=p6 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/capa.sym} -60 270 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} -60 240 0 0 {name=p11 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -60 300 0 1 {name=p12 sig_type=std_logic lab=LPI}
C {devices/lab_wire.sym} 20 310 0 0 {name=p1 sig_type=std_logic lab=LPI}
C {devices/lab_wire.sym} 320 290 0 1 {name=p2 sig_type=std_logic lab=LPO}
C {devices/lab_wire.sym} 170 210 0 0 {name=p3 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/lab_wire.sym} 230 370 2 0 {name=p4 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/vsource.sym} -140 290 0 0 {name=V2 value=0.7 savecurrent=false}
C {devices/lab_wire.sym} -140 240 0 0 {name=p5 sig_type=std_logic lab=IN
value=1.8}
C {devices/lab_wire.sym} 20 270 0 0 {name=p7 sig_type=std_logic lab=IN
value=1.8}
C {devices/capa.sym} 320 320 0 0 {name=C2
m=1
value=200f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 170 370 2 0 {name=p8 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} 230 210 0 1 {name=p9 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -140 320 2 0 {name=p10 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -220 320 2 0 {name=p13 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} 320 350 2 0 {name=p14 sig_type=std_logic lab=0
value=1.8}
C {LELO_GR03_SKY130A/BANDGAP_OTA_PMOS.sym} 170 270 0 0 {name=x1}
C {devices/lab_wire.sym} 10 -40 0 1 {name=p15 sig_type=std_logic lab=V_IBN}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -30 -40 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -70 -270 1 0 {name=x11 }
C {devices/lab_pin.sym} -70 -400 0 1 {name=l31 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -110 -320 0 0 {name=x12 }
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -110 40 0 0 {name=x13 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} -70 -170 1 0 {name=x16 }
C {devices/lab_pin.sym} 140 -400 0 0 {name=l2 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 180 -320 0 1 {name=x2 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 100 -40 0 0 {name=x4}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 180 40 0 1 {name=x5 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 100 -180 0 0 {name=x6 }
C {devices/lab_wire.sym} 50 -180 0 0 {name=p16 sig_type=std_logic lab=V_IBP}
C {devices/lab_pin.sym} -170 -320 0 0 {name=p17 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 240 -320 0 1 {name=p18 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -120 -230 0 0 {name=p19 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -120 -130 0 0 {name=p20 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -110 -40 0 0 {name=p21 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 180 -40 0 1 {name=p22 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -70 120 0 0 {name=p23 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 140 120 0 1 {name=p24 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 200 -180 0 1 {name=l1 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} -170 40 0 0 {name=l3 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 240 40 0 1 {name=l4 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 100 370 2 1 {name=p25 sig_type=std_logic lab=V_IBP}
