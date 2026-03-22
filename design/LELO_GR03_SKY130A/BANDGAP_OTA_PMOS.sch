v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -190 30 -150 30 {lab=IN-}
N 410 220 410 260 {lab=#net1}
N 410 190 450 190 {lab=VSS}
N 410 60 470 60 {lab=OUT}
N -100 -190 -40 -190 {lab=PWRUP_N_1V8}
N 0 -270 -0 -220 {lab=VDD}
N -50 -270 -0 -270 {lab=VDD}
N 0 -190 40 -190 {lab=VDD}
N 40 -240 40 -190 {lab=VDD}
N 0 -240 40 -240 {lab=VDD}
N -0 260 -0 290 {lab=#net1}
N -0 350 -0 360 {lab=VSS}
N -110 360 -0 360 {lab=VSS}
N -100 320 -40 320 {lab=PWRUP_1V8}
N -0 320 30 320 {lab=VSS}
N 30 320 30 360 {lab=VSS}
N 0 360 30 360 {lab=VSS}
N 330 100 340 100 {lab=#net2}
N -180 -90 -160 -90 {lab=V_IBP}
N 0 -160 -0 -120 {lab=#net3}
N 0 -90 20 -90 {lab=VDD}
N -80 -90 -40 -90 {lab=V_IBP}
N 410 -90 430 -90 {lab=VDD}
N 330 -90 370 -90 {lab=V_IBP}
N -0 -60 -0 -30 {lab=#net4}
N -110 -30 0 -30 {lab=#net4}
N -0 -30 110 -30 {lab=#net4}
N 110 -30 110 0 {lab=#net4}
N 90 30 110 30 {lab=VDD}
N -110 -30 -110 0 {lab=#net4}
N -110 30 -90 30 {lab=VDD}
N 110 220 110 260 {lab=#net1}
N -110 220 -110 260 {lab=#net1}
N -110 60 -110 160 {lab=#net5}
N -70 190 70 190 {lab=#net5}
N -30 110 -30 190 {lab=#net5}
N -110 110 -30 110 {lab=#net5}
N 150 30 190 30 {lab=IN+}
N -110 260 0 260 {lab=#net1}
N 110 60 110 160 {lab=#net6}
N -0 -140 360 -140 {lab=#net3}
N 410 -60 410 160 {lab=OUT}
N 0 260 410 260 {lab=#net1}
N 240 100 240 190 {lab=#net6}
N 240 190 370 190 {lab=#net6}
N 110 100 250 100 {lab=#net6}
N 360 -140 410 -140 {lab=#net3}
N 410 -140 410 -120 {lab=#net3}
N 110 190 130 190 {lab=VSS}
N -130 190 -110 190 {lab=VSS}
C {devices/ipin.sym} -190 30 0 0 {name=p4 lab=IN-}
C {devices/opin.sym} 470 60 0 0 {name=p9 lab=OUT}
C {devices/ipin.sym} -110 360 0 0 {name=p1 lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 370 190 0 0 {name=x6}
C {devices/ipin.sym} -100 -190 0 0 {name=p5 lab=PWRUP_N_1V8}
C {devices/ipin.sym} -50 -270 0 0 {name=p21 lab=VDD}
C {devices/lab_wire.sym} 450 190 2 0 {name=p24 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} -100 320 0 0 {name=p15 lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 350 100 1 1 {name=x11[2:0]}
C {devices/lab_wire.sym} 290 120 2 1 {name=p32 sig_type=std_logic lab=VSS}
C {devices/title.sym} -320 -320 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -180 -90 0 0 {name=p7 lab=V_IBP}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -40 320 0 0 {name=x1[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -40 -190 0 0 {name=x4[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -40 -90 0 0 {name=x3[1:0]}
C {devices/lab_wire.sym} 20 -90 2 0 {name=p8 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -80 -90 0 0 {name=p10 sig_type=std_logic lab=V_IBP}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 370 -90 0 0 {name=x2}
C {devices/lab_wire.sym} 430 -90 2 0 {name=p11 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 330 -90 0 0 {name=p12 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} 90 30 2 1 {name=p13 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -90 30 2 0 {name=p23 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 70 190 0 0 {name=x3}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -70 190 0 1 {name=x4}
C {devices/ipin.sym} 190 30 0 1 {name=p25 lab=IN+}
C {devices/lab_wire.sym} 130 190 2 0 {name=p2 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -130 190 2 1 {name=p3 sig_type=std_logic lab=VSS}
C {LELO_ATR_SKY130A/LELOATR_LVT_PCH_4C5F0.sym} -150 30 0 0 {name=x2[2:0]}
C {LELO_ATR_SKY130A/LELOATR_LVT_PCH_4C5F0.sym} 150 30 0 1 {name=x5[2:0]}
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} 250 100 0 0 {name=x1 }
