v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -1200 -540 -400 -140 {flags=graph
y1=0.00018
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00012136265
x2=0.0027097925
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
B 2 -370 -540 430 -140 {flags=graph
y1=-0.14503083
y2=0.77599317
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00012136265
x2=0.0027097925
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
N -60 210 -60 240 {lab=OUT_NMOS}
N -450 230 -450 240 {lab=IN-}
N -450 230 -380 230 {lab=IN-}
N -450 300 -450 320 {lab=0}
N -230 110 -230 130 {lab=VDD}
N -590 190 -590 220 {lab=IN+}
N -590 190 -380 190 {lab=IN+}
N -660 260 -660 320 {lab=0}
N -660 320 -130 320 {lab=0}
N -590 280 -590 320 {lab=0}
N -660 110 -230 110 {lab=VDD}
N -660 110 -660 200 {lab=VDD}
N -230 290 -230 320 {lab=0}
N -130 320 -60 320 {lab=0}
N -60 300 -60 320 {lab=0}
N -170 90 -170 130 {lab=0}
N -170 90 -160 90 {lab=0}
N -160 90 -160 100 {lab=0}
N -80 210 -60 210 {lab=OUT_NMOS}
N 220 270 260 270 {lab=V_IBN}
N 140 270 180 270 {lab=0}
N 180 390 180 430 {lab=0}
N 130 80 160 80 {lab=0}
N 180 -90 180 -40 {lab=VDD}
N 180 -10 210 -10 {lab=VDD}
N 210 -60 210 -10 {lab=VDD}
N 180 -60 210 -60 {lab=VDD}
N 180 380 180 390 {lab=0}
N 180 350 210 350 {lab=0}
N 210 350 210 390 {lab=0}
N 180 390 210 390 {lab=0}
N 180 20 180 40 {lab=#net1}
N 180 300 180 320 {lab=#net2}
N 180 230 240 230 {lab=V_IBN}
N 180 220 180 240 {lab=V_IBN}
N 180 120 180 140 {lab=#net3}
N 130 180 160 180 {lab=0}
N 240 230 240 270 {lab=V_IBN}
N 120 350 140 350 {lab=VDD}
N 120 -10 140 -10 {lab=0}
N 380 390 380 430 {lab=0}
N 380 380 380 390 {lab=0}
N 380 350 410 350 {lab=0}
N 410 350 410 390 {lab=0}
N 380 390 410 390 {lab=0}
N 380 300 380 320 {lab=#net4}
N 320 350 340 350 {lab=VDD}
N 260 270 340 270 {lab=V_IBN}
N 380 270 420 270 {lab=0}
N 380 -90 380 -40 {lab=VDD}
N 380 -10 410 -10 {lab=VDD}
N 410 -60 410 -10 {lab=VDD}
N 380 -60 410 -60 {lab=VDD}
N 320 -10 340 -10 {lab=0}
N 380 20 380 60 {lab=#net5}
N 310 90 340 90 {lab=V_IBP}
N 380 120 380 240 {lab=V_IBP}
N 380 90 420 90 {lab=VDD}
N 320 90 320 140 {lab=V_IBP}
N 320 140 380 140 {lab=V_IBP}
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
C {devices/capa-2.sym} -60 270 0 0 {name=CL
m=1
value=300f
footprint=1206
device=polarized_capacitor}
C {devices/vsource.sym} -590 250 0 0 {name=VIN
value="sin(0.55 3m 1k)"
savecurrent=false}
C {devices/vsource.sym} -450 270 0 0 {name=V_REF
value="sin(0.55 -3m 1k)"
savecurrent=false
}
C {devices/lab_pin.sym} -590 190 0 0 {name=p1 sig_type=std_logic lab=IN+}
C {devices/lab_pin.sym} -60 210 0 1 {name=p2 sig_type=std_logic lab=OUT_NMOS}
C {devices/vsource.sym} -660 230 0 0 {name=VDD
value=1.8
savecurrent=false}
C {devices/lab_pin.sym} -450 230 0 0 {name=p3 sig_type=std_logic lab=IN-}
C {devices/lab_pin.sym} -430 110 0 1 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -170 290 0 1 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -330 320 0 1 {name=p6 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -160 100 0 1 {name=p7 sig_type=std_logic lab=0}
C {devices/title.sym} -1130 -620 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -230 190 0 0 {name=x1}
C {LELO_GR03_SKY130A/BANDGAP_OTA_PMOS.sym} -370 -30 0 0 {name=x2}
C {devices/lab_pin.sym} -310 -90 0 1 {name=p8 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -370 -90 0 1 {name=p9 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -310 70 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -370 70 0 1 {name=p11 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -440 70 0 1 {name=p12 sig_type=std_logic lab=V_IBP}
C {devices/lab_pin.sym} -300 290 0 1 {name=p13 sig_type=std_logic lab=V_IBN}
C {devices/capa-2.sym} -220 20 0 0 {name=CL1
m=1
value=300f
footprint=1206
device=polarized_capacitor}
C {devices/lab_pin.sym} -220 50 0 1 {name=p14 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -220 -10 0 1 {name=p15 sig_type=std_logic lab=OUT_PMOS}
C {devices/lab_pin.sym} -520 -30 0 0 {name=p16 sig_type=std_logic lab=IN+}
C {devices/lab_pin.sym} -520 10 0 0 {name=p17 sig_type=std_logic lab=IN-}
C {devices/lab_wire.sym} 260 270 0 1 {name=p18 sig_type=std_logic lab=V_IBN}
C {devices/lab_wire.sym} 130 80 2 1 {name=p19 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 220 270 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} 180 40 1 0 {name=x11 }
C {devices/lab_wire.sym} 140 270 2 1 {name=p25 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 180 430 0 0 {name=l29 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 180 -90 0 1 {name=l31 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 140 -10 0 0 {name=x12 }
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 140 350 0 0 {name=x13 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 180 140 1 0 {name=x14 }
C {devices/lab_wire.sym} 130 180 2 1 {name=p22 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} 120 350 2 1 {name=p21 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 120 -10 2 1 {name=p20 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 380 430 0 0 {name=l2 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 340 350 0 0 {name=x4 }
C {devices/lab_wire.sym} 320 350 2 1 {name=p23 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 340 270 0 0 {name=x5}
C {devices/lab_wire.sym} 420 270 2 0 {name=p24 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 380 -90 0 1 {name=l3 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 340 -10 0 0 {name=x6 }
C {devices/lab_wire.sym} 320 -10 2 1 {name=p26 sig_type=std_logic lab=0}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 340 90 0 0 {name=x7 }
C {devices/lab_wire.sym} 310 90 0 0 {name=p27 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} 420 90 2 0 {name=p28 sig_type=std_logic lab=VDD}
