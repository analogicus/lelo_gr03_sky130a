v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -170 -20 -170 50 {lab=#net1}
N 170 -20 170 50 {lab=#net2}
N 170 110 170 140 {lab=VTAIL}
N -170 110 -170 140 {lab=VTAIL}
N -170 -110 -170 -80 {lab=#net3}
N 170 -110 170 -80 {lab=#net3}
N -0 140 -0 160 {lab=VTAIL}
N -250 80 -210 80 {lab=IN+}
N 210 80 250 80 {lab=IN-}
N -190 -50 -170 -50 {lab=VDD}
N 170 -50 190 -50 {lab=VDD}
N -80 190 -40 190 {lab=V_IB}
N 0 220 0 260 {lab=#net4}
N 0 190 40 190 {lab=VSS}
N -170 80 -130 80 {lab=VSS}
N 130 80 170 80 {lab=VSS}
N 360 -50 380 -50 {lab=VDD}
N 360 -110 360 -80 {lab=#net3}
N 360 220 360 260 {lab=#net4}
N 360 190 400 190 {lab=VSS}
N 360 -20 360 160 {lab=#net5}
N 0 -160 0 -110 {lab=#net3}
N -100 -190 -40 -190 {lab=PWRUP_N_1V8}
N 0 -270 -0 -220 {lab=VDD}
N -50 -270 -0 -270 {lab=VDD}
N 0 -190 40 -190 {lab=VDD}
N 40 -240 40 -190 {lab=VDD}
N 0 -240 40 -240 {lab=VDD}
N -0 260 -0 290 {lab=#net4}
N -0 350 -0 360 {lab=VSS}
N -110 360 -0 360 {lab=VSS}
N -100 320 -40 320 {lab=PWRUP_1V8}
N -0 320 30 320 {lab=VSS}
N 30 320 30 360 {lab=VSS}
N 0 360 30 360 {lab=VSS}
N -0 260 360 260 {lab=#net4}
N -120 -110 360 -110 {lab=#net3}
N -160 190 -140 190 {lab=VB_N}
N -130 -50 -110 -50 {lab=#net1}
N -170 140 170 140 {lab=VTAIL}
N -40 -20 170 20 {lab=#net2}
N -170 20 40 -20 {lab=#net1}
N -170 -10 -110 -10 {lab=#net1}
N -110 -50 -110 -10 {lab=#net1}
N -110 -50 -80 -50 {lab=#net1}
N 80 -50 130 -50 {lab=#net2}
N 110 -50 110 -10 {lab=#net2}
N 110 -10 170 -10 {lab=#net2}
N -40 -110 -40 -80 {lab=#net3}
N 40 -110 40 -80 {lab=#net3}
N -410 -50 -390 -50 {lab=VDD}
N -390 -110 -390 -80 {lab=#net3}
N -390 220 -390 260 {lab=#net4}
N -430 190 -390 190 {lab=VSS}
N -390 -20 -390 160 {lab=#net6}
N -390 -110 -120 -110 {lab=#net3}
N -390 260 -0 260 {lab=#net4}
N -350 190 -320 190 {lab=#net6}
N -320 190 -320 230 {lab=#net6}
N -320 230 290 230 {lab=#net6}
N 290 190 290 230 {lab=#net6}
N 290 190 320 190 {lab=#net6}
N -350 -50 -320 -50 {lab=#net1}
N -320 -50 -320 10 {lab=#net1}
N -320 10 -170 10 {lab=#net1}
N 290 -50 320 -50 {lab=#net2}
N 290 -50 290 10 {lab=#net2}
N 170 10 290 10 {lab=#net2}
N -320 140 -320 190 {lab=#net6}
N -390 140 -320 140 {lab=#net6}
N 420 30 480 30 {lab=#net5}
N 520 130 560 130 {lab=VSS}
N 520 30 540 30 {lab=VDD}
N 420 130 480 130 {lab=#net5}
N 520 60 520 100 {lab=OUT}
N 360 260 520 260 {lab=#net4}
N 520 160 520 260 {lab=#net4}
N 360 -110 520 -110 {lab=#net3}
N 520 -110 520 0 {lab=#net3}
N 520 80 600 80 {lab=OUT}
N 420 30 420 130 {lab=#net5}
N 360 80 420 80 {lab=#net5}
C {devices/lab_wire.sym} -80 190 0 0 {name=p3 sig_type=std_logic lab=VB_N}
C {devices/lab_wire.sym} -130 80 2 0 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -20 140 0 0 {name=p17 sig_type=std_logic lab=VTAIL}
C {devices/ipin.sym} 250 80 0 1 {name=p4 lab=IN-}
C {devices/ipin.sym} -250 80 0 0 {name=p2 lab=IN+}
C {devices/ipin.sym} -110 360 0 0 {name=p1 lab=VSS}
C {devices/lab_wire.sym} 130 80 2 1 {name=p6 sig_type=std_logic lab=VSS}
C {LELO_ATR_SKY130A/LELOATR_LVT_NCH_4C5F0.sym} -210 80 0 0 {name=x18[4:0]}
C {LELO_ATR_SKY130A/LELOATR_LVT_NCH_4C5F0.sym} 210 80 0 1 {name=x19[4:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -40 190 0 0 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 130 -50 0 0 {name=x20}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -130 -50 0 1 {name=x21}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 320 -50 0 0 {name=x10}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 320 190 0 0 {name=x6}
C {devices/ipin.sym} -100 -190 0 0 {name=p5 lab=PWRUP_N_1V8}
C {devices/ipin.sym} -50 -270 0 0 {name=p21 lab=VDD}
C {devices/lab_wire.sym} 40 190 2 0 {name=p19 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 400 190 2 0 {name=p24 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -190 -50 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 190 -50 2 0 {name=p29 sig_type=std_logic lab=VDD}
C {devices/ipin.sym} -100 320 0 0 {name=p15 lab=PWRUP_1V8}
C {devices/lab_wire.sym} 380 -50 0 1 {name=p18 sig_type=std_logic lab=VDD}
C {devices/title.sym} -370 -320 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -160 190 0 0 {name=p7 lab=VB_N}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -80 -50 0 0 {name=x2[1:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 80 -50 0 1 {name=x3[1:0]}
C {devices/lab_wire.sym} -40 -50 2 0 {name=p8 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 40 -50 2 1 {name=p10 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -350 -50 0 1 {name=x1}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -350 190 0 1 {name=x3}
C {devices/lab_wire.sym} -430 190 2 1 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -410 -50 0 0 {name=p13 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -40 -190 0 0 {name=x4[2:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -40 320 0 0 {name=x5[2:0]}
C {devices/opin.sym} 600 80 0 0 {name=p11 lab=OUT}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 480 30 0 0 {name=x7}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 480 130 0 0 {name=x8}
C {devices/lab_wire.sym} 560 130 2 0 {name=p14 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 540 30 0 1 {name=p20 sig_type=std_logic lab=VDD}
