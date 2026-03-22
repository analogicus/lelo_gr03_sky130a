v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -230 20 -190 20 {lab=IN-}
N 190 20 230 20 {lab=IN+}
N 130 20 150 20 {lab=VDD}
N -150 20 -130 20 {lab=VDD}
N 420 40 480 40 {lab=OUT}
N -100 -220 -40 -220 {lab=PWRUP_N_1V8}
N 0 -300 0 -250 {lab=VDD}
N -50 -300 0 -300 {lab=VDD}
N 0 -220 40 -220 {lab=VDD}
N 40 -270 40 -220 {lab=VDD}
N 0 -270 40 -270 {lab=VDD}
N -0 260 -0 290 {lab=#net1}
N -0 350 -0 360 {lab=VSS}
N -110 360 -0 360 {lab=VSS}
N -100 320 -40 320 {lab=PWRUP_1V8}
N -0 320 30 320 {lab=VSS}
N 30 320 30 360 {lab=VSS}
N 0 360 30 360 {lab=VSS}
N -180 260 180 260 {lab=#net1}
N -150 -50 -0 -50 {lab=VTAIL}
N -0 -50 150 -50 {lab=VTAIL}
N -60 -100 -40 -100 {lab=V_IBP}
N -190 -100 -160 -100 {lab=V_IBP}
N 150 -50 150 -10 {lab=VTAIL}
N -150 -50 -150 -10 {lab=VTAIL}
N -110 180 110 180 {lab=#net2}
N -150 50 -150 150 {lab=#net2}
N 150 50 150 150 {lab=#net3}
N -150 210 -150 260 {lab=#net1}
N 150 210 150 260 {lab=#net1}
N 150 180 190 180 {lab=VSS}
N -190 180 -150 180 {lab=VSS}
N 420 180 460 180 {lab=VSS}
N 420 210 420 260 {lab=#net1}
N 260 100 260 180 {lab=#net3}
N 150 100 260 100 {lab=#net3}
N 340 100 350 100 {lab=#net4}
N 260 180 380 180 {lab=#net3}
N 180 260 450 260 {lab=#net1}
N -0 -160 -0 -130 {lab=#net5}
N -0 -70 -0 -50 {lab=VTAIL}
N 0 -100 20 -100 {lab=VDD}
N 350 -90 380 -90 {lab=V_IBP}
N 420 -60 420 150 {lab=OUT}
N -120 -160 450 -160 {lab=#net5}
N 420 -160 420 -120 {lab=#net5}
N -0 -190 -0 -160 {lab=#net5}
N 420 -90 440 -90 {lab=VDD}
N -190 -160 -120 -160 {lab=#net5}
N -70 100 -70 180 {lab=#net2}
N -150 100 -70 100 {lab=#net2}
C {devices/lab_wire.sym} -60 -100 0 0 {name=p14 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} -20 -50 2 1 {name=p17 sig_type=std_logic lab=VTAIL}
C {devices/ipin.sym} -230 20 0 0 {name=p4 lab=IN-}
C {devices/opin.sym} 480 40 0 0 {name=p9 lab=OUT}
C {devices/ipin.sym} 230 20 0 1 {name=p2 lab=IN+}
C {devices/ipin.sym} -110 360 0 0 {name=p1 lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 110 180 0 0 {name=x2}
C {devices/ipin.sym} -100 -220 0 0 {name=p5 lab=PWRUP_N_1V8}
C {devices/ipin.sym} -50 -300 0 0 {name=p21 lab=VDD}
C {devices/lab_wire.sym} 130 20 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -130 20 2 0 {name=p29 sig_type=std_logic lab=VDD}
C {devices/ipin.sym} -100 320 0 0 {name=p15 lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 260 100 0 0 {name=x9 }
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 360 100 1 1 {name=x11}
C {devices/lab_wire.sym} 300 120 2 1 {name=p32 sig_type=std_logic lab=VSS}
C {devices/title.sym} -320 -350 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -190 -100 0 0 {name=p7 lab=V_IBP}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -40 320 0 0 {name=x1[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -40 -220 0 0 {name=x4[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -40 -100 0 0 {name=x3[1:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -110 180 0 1 {name=x1}
C {devices/lab_wire.sym} 190 180 2 0 {name=p8 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -190 180 2 1 {name=p10 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 380 180 0 0 {name=x3}
C {devices/lab_wire.sym} 460 180 2 0 {name=p11 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 20 -100 2 0 {name=p12 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 380 -90 0 0 {name=x4}
C {devices/lab_wire.sym} 350 -90 0 0 {name=p3 sig_type=std_logic lab=V_IBP}
C {devices/lab_wire.sym} 440 -90 2 0 {name=p6 sig_type=std_logic lab=VDD}
C {LELO_ATR_SKY130A/LELOATR_LVT_PCH_4C5F0.sym} -190 20 0 0 {name=x5[2:0]}
C {LELO_ATR_SKY130A/LELOATR_LVT_PCH_4C5F0.sym} 190 20 0 1 {name=x6[2:0]}
