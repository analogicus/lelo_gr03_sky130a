v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 180 -210 980 190 {flags=graph
y1=-5.1405261e-09
y2=-1.3127562e-09
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-2.4801522e-05
x2=0.00020363326
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(vdd)
color=4
dataset=-1
unitx=1
logx=0
logy=0
}
T {Generating bias voltage} -810 -310 0 0 0.4 0.4 {}
N -80 300 -40 300 {lab=0}
N -80 280 -40 280 {lab=VDD_1V8}
N -80 260 -40 260 {lab=0}
N -40 320 -40 350 {lab=V_IBP}
N -720 110 -680 110 {lab=V_IBN}
N -800 110 -760 110 {lab=0}
N -760 230 -760 270 {lab=0}
N -860 -170 -800 -170 {lab=VDD_1V8}
N -760 -250 -760 -200 {lab=VDD_1V8}
N -760 -170 -730 -170 {lab=VDD_1V8}
N -730 -220 -730 -170 {lab=VDD_1V8}
N -760 -220 -730 -220 {lab=VDD_1V8}
N -760 220 -760 230 {lab=0}
N -860 190 -800 190 {lab=0}
N -760 190 -730 190 {lab=0}
N -730 190 -730 230 {lab=0}
N -760 230 -730 230 {lab=0}
N -760 -140 -760 -120 {lab=#net1}
N -760 140 -760 160 {lab=#net2}
N -760 70 -700 70 {lab=V_IBN}
N -760 60 -760 80 {lab=V_IBN}
N -760 -40 -760 -20 {lab=#net3}
N -810 20 -780 20 {lab=0}
N -700 70 -700 110 {lab=V_IBN}
N -590 110 -550 110 {lab=0}
N -680 110 -630 110 {lab=V_IBN}
N -590 230 -590 270 {lab=0}
N -590 220 -590 230 {lab=0}
N -550 190 -490 190 {lab=0}
N -620 190 -590 190 {lab=0}
N -620 190 -620 230 {lab=0}
N -620 230 -590 230 {lab=0}
N -590 140 -590 160 {lab=#net4}
N -590 -20 -590 80 {lab=V_IBP}
N -590 -50 -560 -50 {lab=VDD_1V8}
N -650 -50 -630 -50 {lab=V_IBP}
N -650 -50 -650 -10 {lab=V_IBP}
N -650 -10 -590 -10 {lab=V_IBP}
N -660 -50 -650 -50 {lab=V_IBP}
N -550 -170 -490 -170 {lab=VDD_1V8}
N -590 -250 -590 -200 {lab=VDD_1V8}
N -620 -170 -590 -170 {lab=VDD_1V8}
N -620 -220 -620 -170 {lab=VDD_1V8}
N -620 -220 -590 -220 {lab=VDD_1V8}
N -590 -140 -590 -80 {lab=#net5}
N -790 -100 -760 -100 {lab=#net1}
N -760 -120 -760 -100 {lab=#net1}
N -790 -40 -760 -40 {lab=#net3}
N -870 -100 -870 -40 {lab=#net6}
C {LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym} 110 280 0 0 {name=x1}
C {devices/title.sym} -330 -270 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/lab_wire.sym} -40 350 2 0 {name=p9 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} -680 110 0 1 {name=p10 sig_type=std_logic lab=V_IBN}
C {devices/lab_wire.sym} -830 -120 0 0 {name=p11 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -720 110 0 1 {name=x2}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -790 -100 2 0 {name=x4 }
C {devices/lab_wire.sym} -800 110 2 1 {name=p12 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -760 270 0 0 {name=l2 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -760 -250 0 1 {name=l3 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -800 -170 0 0 {name=x5 }
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -800 190 0 0 {name=x6 }
C {devices/lab_wire.sym} -810 20 2 1 {name=p16 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -630 110 0 0 {name=x15}
C {devices/lab_wire.sym} -550 110 2 0 {name=p17 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -590 270 0 1 {name=l30 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -550 190 0 1 {name=x16 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -630 -50 0 0 {name=x17 }
C {devices/lab_pin.sym} -560 -50 0 1 {name=l32 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -660 -50 0 0 {name=p20 sig_type=std_logic lab=V_IBP}
C {devices/lab_pin.sym} -590 -250 0 0 {name=l33 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -550 -170 0 1 {name=x18 }
C {devices/lab_wire.sym} -830 -20 2 1 {name=p7 sig_type=std_logic lab=0}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -790 -40 0 1 {name=x3 }
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} -760 -20 1 0 {name=x7 }
C {devices/lab_wire.sym} -80 300 2 1 {name=p2 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -80 260 2 1 {name=p3 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -80 280 2 1 {name=p4 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -40 240 0 0 {name=p5 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 260 260 2 0 {name=p6 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -490 190 2 0 {name=p1 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -860 190 2 1 {name=p8 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -490 -170 0 1 {name=l4 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} -860 -170 0 0 {name=l5 sig_type=std_logic lab=VDD_1V8}
C {devices/vsource.sym} -230 330 0 0 {name=VDD value=1.8 savecurrent=false}
C {devices/lab_wire.sym} -230 300 0 1 {name=p13 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -230 360 2 1 {name=p14 sig_type=std_logic lab=0}
C {devices/code_shown.sym} -370 -190 0 0 {name=s1 only_toplevel=false value="
.param mc_mm_switch=0
.param mc_pr_switch=0

.lib "../../../tech/ngspice/temperature.spi" Tl
.lib "../../../tech/ngspice/corners.spi" Kfs
.lib "../../../tech/ngspice/supply.spi" Vh
.include ../../../../cpdk/ngspice/ideal_circuits.spi
*.option savecurrents
.option gmin=1e-12
*.option SEED=1
.temp 100
.save all
.control

optran 0 0 0 10n 1u 0
*dc VIN 0 1.8 1m
tran 0.5u 0.5m
*op
*ac dec 20 1 1G

write BANDGAP_CIRCUIT_LEAK_TB.raw

exit
.endc
"}
