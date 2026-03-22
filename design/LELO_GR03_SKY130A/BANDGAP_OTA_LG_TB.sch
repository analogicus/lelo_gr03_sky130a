v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 380 -370 1180 30 {flags=graph

y2=101.4
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

y1=-35.6
autoload=1
x1=2
x2=9}
B 2 380 50 1180 450 {flags=graph


ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1

x2=9
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=1
logy=0
sim_type=ac
x1=2
y1=-330.16177
y2=9.80623
color=4
node=re(lg_phase)
autoload=0
rawfile=$netlist_dir/TB_LELOTEMP_BIAS_IBP_LSTB.raw}
N -190 280 -190 300 {
lab=VDD_1V8}
N -110 280 -110 300 {lab=IN}
N -80 30 -40 30 {lab=V_IBN}
N -160 30 -120 30 {lab=0}
N -120 150 -120 190 {lab=0}
N -200 -210 -200 -180 {lab=0}
N -120 -330 -120 -280 {lab=VDD}
N -120 -250 -90 -250 {lab=VDD}
N -90 -300 -90 -250 {lab=VDD}
N -120 -300 -90 -300 {lab=VDD}
N -120 140 -120 150 {lab=0}
N -120 110 -90 110 {lab=0}
N -90 110 -90 150 {lab=0}
N -120 150 -90 150 {lab=0}
N -120 -220 -120 -200 {lab=#net1}
N -120 60 -120 80 {lab=#net2}
N -120 -10 -60 -10 {lab=V_IBN}
N -120 -20 -120 0 {lab=V_IBN}
N -120 -120 -120 -100 {lab=#net3}
N -170 -60 -140 -60 {lab=0}
N -60 -10 -60 30 {lab=V_IBN}
N -180 110 -160 110 {lab=VDD}
N -180 -250 -160 -250 {lab=0}
N 80 150 80 190 {lab=0}
N 80 140 80 150 {lab=0}
N 80 110 110 110 {lab=0}
N 110 110 110 150 {lab=0}
N 80 150 110 150 {lab=0}
N 80 60 80 80 {lab=#net4}
N 20 110 40 110 {lab=VDD}
N -40 30 40 30 {lab=V_IBN}
N 80 30 120 30 {lab=0}
N 80 -330 80 -280 {lab=VDD}
N 80 -250 110 -250 {lab=VDD}
N 110 -300 110 -250 {lab=VDD}
N 80 -300 110 -300 {lab=VDD}
N 20 -250 40 -250 {lab=0}
N 80 -220 80 -180 {lab=#net5}
N 10 -150 40 -150 {lab=V_IBP}
N 80 -120 80 0 {lab=V_IBP}
N 80 -150 120 -150 {lab=VDD}
N 20 -150 20 -100 {lab=V_IBP}
N 20 -100 80 -100 {lab=V_IBP}
N -200 -100 -200 -70 {lab=0}
N -240 -160 -240 -120 {lab=#net6}
N -160 -160 -120 -160 {lab=#net1}
N -120 -200 -120 -160 {lab=#net1}
N -160 -120 -120 -120 {lab=#net3}
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
C {devices/vsource.sym} -190 330 0 0 {name=V1 value=1.8 savecurrent=false}
C {devices/lab_wire.sym} -190 280 0 0 {name=p6 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/capa.sym} 310 210 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 310 180 0 0 {name=p11 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 310 240 0 1 {name=p12 sig_type=std_logic lab=LPI}
C {devices/lab_wire.sym} 0 350 0 0 {name=p1 sig_type=std_logic lab=LPI}
C {devices/lab_wire.sym} 300 330 0 1 {name=p2 sig_type=std_logic lab=LPO}
C {devices/lab_wire.sym} 150 250 0 0 {name=p3 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/lab_wire.sym} 210 410 2 0 {name=p4 sig_type=std_logic lab=VDD_1V8
value=1.8}
C {devices/vsource.sym} -110 330 0 0 {name=V2 value=0.8 savecurrent=false}
C {devices/lab_wire.sym} -110 280 0 0 {name=p5 sig_type=std_logic lab=IN
value=1.8}
C {devices/lab_wire.sym} 0 310 0 0 {name=p7 sig_type=std_logic lab=IN
value=1.8}
C {devices/capa.sym} 300 360 0 0 {name=C2
m=1
value=200f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 150 410 2 0 {name=p8 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} 210 250 0 1 {name=p9 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -110 360 2 0 {name=p10 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -190 360 2 0 {name=p13 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} 300 390 2 0 {name=p14 sig_type=std_logic lab=0
value=1.8}
C {devices/lab_wire.sym} -40 30 0 1 {name=p18 sig_type=std_logic lab=V_IBN}
C {devices/lab_wire.sym} -200 -210 3 1 {name=p19 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -80 30 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -160 -160 2 0 {name=x11 }
C {devices/lab_wire.sym} -160 30 2 1 {name=p25 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -120 190 0 0 {name=l29 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -120 -330 0 1 {name=l31 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -160 -250 0 0 {name=x12 }
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -160 110 0 0 {name=x13 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} -120 -100 1 0 {name=x14 }
C {devices/lab_wire.sym} -170 -60 2 1 {name=p22 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -180 110 2 1 {name=p21 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -180 -250 2 1 {name=p20 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 80 190 0 0 {name=l2 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 40 110 0 0 {name=x4 }
C {devices/lab_wire.sym} 20 110 2 1 {name=p23 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 40 30 0 0 {name=x5}
C {devices/lab_wire.sym} 120 30 2 0 {name=p24 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 80 -330 0 1 {name=l3 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 40 -250 0 0 {name=x6 }
C {devices/lab_wire.sym} 20 -250 2 1 {name=p26 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 40 -150 0 0 {name=x7 }
C {devices/lab_wire.sym} 10 -150 0 0 {name=p27 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} 120 -150 2 0 {name=p28 sig_type=std_logic lab=VDD}
C {LELO_GR03_SKY130A/BANDGAP_OTA_PMOS.sym} 150 310 0 0 {name=x1}
C {devices/lab_wire.sym} 80 410 2 1 {name=p15 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} -200 -70 1 1 {name=p16 sig_type=std_logic lab=0}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -240 -120 0 0 {name=x2 }
