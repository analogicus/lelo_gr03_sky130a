v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -1210 -530 -410 -130 {flags=graph
y1=-0.473327
y2=2.636762
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0019461613
x2=-0.00040719721
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="4 7"
node="in+
out_nmos"
hilight_wave=0}
B 2 -360 -530 440 -130 {flags=graph
y1=-1.0579518
y2=2.3406354
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0019461613
x2=-0.00040719721
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="4 7"
node="in+
out_pmos"
hilight_wave=0}
N -20 300 -20 330 {lab=OUT_NMOS}
N -410 320 -410 330 {lab=IN-}
N -410 320 -340 320 {lab=IN-}
N -410 390 -410 410 {lab=0}
N -190 200 -190 220 {lab=VDD}
N -550 280 -550 310 {lab=IN+}
N -550 280 -340 280 {lab=IN+}
N -620 350 -620 410 {lab=0}
N -620 410 -90 410 {lab=0}
N -550 370 -550 410 {lab=0}
N -620 200 -190 200 {lab=VDD}
N -620 200 -620 290 {lab=VDD}
N -190 380 -190 410 {lab=0}
N -90 410 -20 410 {lab=0}
N -20 390 -20 410 {lab=0}
N -130 180 -130 220 {lab=0}
N -130 180 -120 180 {lab=0}
N -120 180 -120 190 {lab=0}
N -40 300 -20 300 {lab=OUT_NMOS}
N 300 280 340 280 {lab=V_IBN}
N 220 280 260 280 {lab=0}
N 260 400 260 440 {lab=0}
N 210 90 240 90 {lab=0}
N 160 0 220 0 {lab=0}
N 260 -80 260 -30 {lab=VDD}
N 260 0 290 0 {lab=VDD}
N 290 -50 290 0 {lab=VDD}
N 260 -50 290 -50 {lab=VDD}
N 260 390 260 400 {lab=0}
N 160 360 220 360 {lab=VDD}
N 260 360 290 360 {lab=0}
N 290 360 290 400 {lab=0}
N 260 400 290 400 {lab=0}
N 320 240 320 280 {lab=V_IBN}
N 260 30 260 50 {lab=#net1}
N 260 240 320 240 {lab=V_IBN}
N 260 310 260 330 {lab=#net2}
N 260 230 260 250 {lab=V_IBN}
N 260 130 260 150 {lab=#net3}
N 210 190 240 190 {lab=0}
N 510 0 570 0 {lab=0}
N 470 -80 470 -30 {lab=VDD}
N 440 0 470 0 {lab=VDD}
N 440 -50 440 0 {lab=VDD}
N 440 -50 470 -50 {lab=VDD}
N 340 280 430 280 {lab=V_IBN}
N 470 400 470 440 {lab=0}
N 470 390 470 400 {lab=0}
N 510 360 570 360 {lab=VDD}
N 440 360 470 360 {lab=0}
N 440 360 440 400 {lab=0}
N 440 400 470 400 {lab=0}
N 470 310 470 330 {lab=#net4}
N 470 280 510 280 {lab=0}
N 470 170 470 250 {lab=V_IBP}
N 470 30 470 110 {lab=#net5}
N 470 140 530 140 {lab=VDD}
N 410 140 430 140 {lab=V_IBP}
N 410 140 410 180 {lab=V_IBP}
N 410 180 470 180 {lab=V_IBP}
N 380 140 410 140 {lab=V_IBP}
C {devices/code_shown.sym} -1200 -70 0 0 {name=s1 only_toplevel=false value="
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
tran 0.5u 6m
*op
*ac dec 20 1 1G

write BANDGAP_OTA_TB.raw

exit
.endc
"}
C {devices/capa-2.sym} -20 360 0 0 {name=CL
m=1
value=300f
footprint=1206
device=polarized_capacitor}
C {devices/vsource.sym} -550 340 0 0 {name=VIN
value="sin(0.65 1m 1k)"
savecurrent=false}
C {devices/vsource.sym} -410 360 0 0 {name=V_REF
value="sin(0.65 -1m 1k)"
savecurrent=false
}
C {devices/lab_pin.sym} -550 280 0 0 {name=p1 sig_type=std_logic lab=IN+}
C {devices/lab_pin.sym} -20 300 0 1 {name=p2 sig_type=std_logic lab=OUT_NMOS}
C {devices/vsource.sym} -620 320 0 0 {name=VDD
value=1.8
savecurrent=false}
C {devices/lab_pin.sym} -410 320 0 0 {name=p3 sig_type=std_logic lab=IN-}
C {devices/lab_pin.sym} -390 200 0 1 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -130 380 0 1 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -290 410 0 1 {name=p6 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -120 190 0 1 {name=p7 sig_type=std_logic lab=0}
C {devices/title.sym} -1050 -620 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -190 280 0 0 {name=x1}
C {devices/lab_wire.sym} 340 280 0 1 {name=p8 sig_type=std_logic lab=V_IBN}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 300 280 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} 260 50 1 0 {name=x11 }
C {devices/lab_pin.sym} 260 -80 0 1 {name=l31 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 220 0 0 0 {name=x12 }
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 220 360 0 0 {name=x13 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 260 150 1 0 {name=x16 }
C {devices/lab_pin.sym} 470 -80 0 0 {name=l2 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 510 0 0 1 {name=x2 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 430 280 0 0 {name=x4}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 510 360 0 1 {name=x5 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 430 140 0 0 {name=x6 }
C {devices/lab_wire.sym} 380 140 0 0 {name=p16 sig_type=std_logic lab=V_IBP}
C {devices/lab_pin.sym} 160 0 0 0 {name=p17 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 570 0 0 1 {name=p11 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 210 90 0 0 {name=p10 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 210 190 0 0 {name=p13 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 220 280 0 0 {name=p14 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 510 280 0 1 {name=p18 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 260 440 0 0 {name=p15 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 470 440 0 1 {name=p19 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 530 140 0 1 {name=p20 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 570 360 0 1 {name=p9 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 160 360 0 0 {name=p12 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -260 380 0 1 {name=p21 sig_type=std_logic lab=V_IBN}
C {LELO_GR03_SKY130A/BANDGAP_OTA_PMOS.sym} -190 30 0 0 {name=x7}
C {devices/lab_pin.sym} -260 130 0 1 {name=p22 sig_type=std_logic lab=V_IBP}
C {devices/lab_pin.sym} -190 130 0 1 {name=p23 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -130 130 0 1 {name=p24 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -130 -30 0 1 {name=p25 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -190 -30 0 0 {name=p26 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -340 30 0 0 {name=p27 sig_type=std_logic lab=IN+}
C {devices/lab_pin.sym} -340 70 0 0 {name=p28 sig_type=std_logic lab=IN-}
C {devices/capa-2.sym} -40 80 0 0 {name=CL1
m=1
value=300f
footprint=1206
device=polarized_capacitor}
C {devices/lab_pin.sym} -40 110 0 1 {name=p29 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -40 50 0 1 {name=p30 sig_type=std_logic lab=OUT_PMOS}
