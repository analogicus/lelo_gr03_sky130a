v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -170 -580 630 -180 {flags=graph
y1=-0.4
y2=1.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-3.8199488e-07
x2=8.2596459e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="out
in+
in-
v1"
color="7 4 6 18"
dataset=-1
unitx=1
logx=0
logy=0
}
N 140 10 140 20 {lab=IN-}
N 140 10 210 10 {lab=IN-}
N 140 80 140 100 {lab=0}
N 0 -30 0 0 {lab=IN+}
N 0 -30 210 -30 {lab=IN+}
N -70 40 -70 100 {lab=0}
N -70 100 460 100 {lab=0}
N 0 60 0 100 {lab=0}
N -70 -110 360 -110 {lab=VDD}
N -70 -110 -70 -20 {lab=VDD}
N 530 -10 530 20 {lab=OUT}
N 530 80 530 100 {lab=0}
N 510 -10 530 -10 {lab=OUT}
N 460 100 530 100 {lab=0}
N 820 30 860 30 {lab=V_IB}
N 840 -20 840 30 {lab=V_IB}
N 780 -20 840 -20 {lab=V_IB}
N 740 30 780 30 {lab=0}
N 730 -110 760 -110 {lab=0}
N 780 60 780 100 {lab=0}
N 780 -70 780 0 {lab=V_IB}
N 360 -110 360 -90 {lab=VDD}
N 360 70 360 100 {lab=0}
C {LELO_GR03_SKY130A/COMPARATOR.sym} 360 -30 0 0 {name=x1}
C {devices/code_shown.sym} -680 -210 0 0 {name=s1 only_toplevel=false value="
.param mc_mm_switch=0
.param mc_pr_switch=0

.lib "../../../tech/ngspice/temperature.spi" Tl
.lib "../../../tech/ngspice/corners.spi" Kss
.lib "../../../tech/ngspice/supply.spi" Vl
.include ../../../../cpdk/ngspice/ideal_circuits.spi
*.option savecurrents
.option gmin=1e-12
*.option SEED=1
.save all
.control

optran 0 0 0 10n 1u 0
*dc VIN 0 1.8 1m
tran 0.5n 3u
*op
*ac dec 20 1 1G

write COMPARATOR_TB.raw

exit
.endc
"}
C {devices/vsource.sym} 0 30 0 0 {name=VIN
value="sin(0.7 0.9 5MEG)"
savecurrent=false}
C {devices/vsource.sym} 140 50 0 0 {name=V_REF
value=0.9
savecurrent=false
}
C {devices/lab_pin.sym} 0 -30 0 0 {name=p1 sig_type=std_logic lab=IN+}
C {devices/vsource.sym} -70 10 0 0 {name=VDD
value=1.8
savecurrent=false}
C {devices/lab_pin.sym} 140 10 0 0 {name=p3 sig_type=std_logic lab=IN-}
C {devices/lab_pin.sym} 160 -110 0 1 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 230 100 0 1 {name=p6 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 420 -90 0 1 {name=p2 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 420 70 0 1 {name=p5 sig_type=std_logic lab=VDD}
C {devices/capa-2.sym} 530 50 0 0 {name=CL
m=1
value=300f
footprint=1206
device=polarized_capacitor}
C {devices/lab_pin.sym} 530 -10 0 1 {name=p7 sig_type=std_logic lab=OUT}
C {devices/lab_wire.sym} 860 30 0 1 {name=p8 sig_type=std_logic lab=V_IB}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 820 30 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} 780 -150 1 0 {name=x11 }
C {devices/lab_wire.sym} 290 70 2 0 {name=p10 sig_type=std_logic lab=V_IB}
C {devices/lab_pin.sym} 780 100 0 1 {name=p9 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 740 30 0 0 {name=p11 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 730 -110 0 0 {name=p12 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 780 -150 0 1 {name=p13 sig_type=std_logic lab=VDD}
