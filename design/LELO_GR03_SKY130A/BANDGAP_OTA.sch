v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 -20 -120 50 {lab=VB_P}
N -120 20 -40 20 {lab=VB_P}
N -40 -50 -40 20 {lab=VB_P}
N -80 -50 80 -50 {lab=VB_P}
N 120 -20 120 50 {lab=V2}
N 120 110 120 140 {lab=VTAIL}
N -120 140 120 140 {lab=VTAIL}
N -120 110 -120 140 {lab=VTAIL}
N -120 -110 -120 -80 {lab=SUPPLY}
N 120 -110 120 -80 {lab=SUPPLY}
N -0 140 -0 160 {lab=VTAIL}
N -200 80 -160 80 {lab=IN-}
N 160 80 200 80 {lab=IN+}
N -140 -50 -120 -50 {lab=SUPPLY}
N -140 -110 -140 -50 {lab=SUPPLY}
N 120 -50 140 -50 {lab=SUPPLY}
N 140 -110 140 -50 {lab=SUPPLY}
N -80 190 -40 190 {lab=V_IB}
N -320 190 -280 190 {lab=V_IB}
N -300 140 -300 190 {lab=V_IB}
N -360 140 -300 140 {lab=V_IB}
N -400 190 -360 190 {lab=VSS}
N -400 190 -400 240 {lab=VSS}
N -400 240 -360 240 {lab=VSS}
N -360 220 -360 260 {lab=VSS}
N 0 220 0 260 {lab=VSS}
N 0 190 40 190 {lab=VSS}
N 40 190 40 240 {lab=VSS}
N -0 240 40 240 {lab=VSS}
N -120 80 -80 80 {lab=VSS}
N 80 80 120 80 {lab=VSS}
N 190 -50 190 20 {lab=V2}
N 380 -110 380 -50 {lab=SUPPLY}
N 360 -50 380 -50 {lab=SUPPLY}
N 360 -110 360 -80 {lab=SUPPLY}
N 280 190 320 190 {lab=V_IB}
N 360 220 360 260 {lab=VSS}
N 360 240 400 240 {lab=VSS}
N 400 190 400 240 {lab=VSS}
N 360 190 400 190 {lab=VSS}
N 360 80 420 80 {lab=OUT}
N -360 60 -360 160 {lab=V_IB}
N 360 -20 360 160 {lab=OUT}
N -470 260 360 260 {lab=VSS}
N -360 -110 -360 -20 {lab=SUPPLY}
N -410 20 -380 20 {lab=VSS}
N 190 -50 320 -50 {lab=V2}
N 120 20 190 20 {lab=V2}
N 680 -110 680 -80 {lab=SUPPLY}
N 610 -50 640 -50 {lab=VSS}
N 680 -20 680 10 {lab=VTAIL}
N 980 200 1010 200 {lab=#net1}
N 980 150 980 200 {lab=#net1}
N 980 150 1050 150 {lab=#net1}
N 1050 130 1050 170 {lab=#net1}
N 980 100 1010 100 {lab=OUT}
N 950 100 980 100 {lab=OUT}
N 1050 -20 1050 70 {lab=#net2}
N 1050 -110 1050 -80 {lab=SUPPLY}
N 880 -110 1050 -110 {lab=SUPPLY}
N 880 -110 880 -80 {lab=SUPPLY}
N 880 -20 880 170 {lab=OUT}
N 920 200 950 200 {lab=OUT}
N 950 150 950 200 {lab=OUT}
N 880 150 950 150 {lab=OUT}
N 920 -50 1010 -50 {lab=#net2}
N 980 -50 980 0 {lab=#net2}
N 980 0 1050 0 {lab=#net2}
N 880 230 880 260 {lab=VSS}
N 880 260 1050 260 {lab=VSS}
N 1050 230 1050 260 {lab=VSS}
N 1050 200 1080 200 {lab=VSS}
N 1080 200 1080 260 {lab=VSS}
N 1050 260 1080 260 {lab=VSS}
N 850 200 880 200 {lab=VSS}
N 850 200 850 260 {lab=VSS}
N 850 260 880 260 {lab=VSS}
N 1050 100 1080 100 {lab=VSS}
N 1080 100 1080 200 {lab=VSS}
N 850 -50 880 -50 {lab=SUPPLY}
N 850 -110 850 -50 {lab=SUPPLY}
N 850 -110 880 -110 {lab=SUPPLY}
N 1050 -50 1080 -50 {lab=SUPPLY}
N 1080 -110 1080 -50 {lab=SUPPLY}
N 1050 -110 1080 -110 {lab=SUPPLY}
N -360 -110 380 -110 {lab=SUPPLY}
N 0 -160 0 -110 {lab=SUPPLY}
N -100 -190 -40 -190 {lab=PWRUP_N_1V8}
N 0 -270 -0 -220 {lab=VDD}
N -50 -270 -0 -270 {lab=VDD}
C {devices/lab_wire.sym} -80 190 0 0 {name=p3 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} -280 190 0 1 {name=p8 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} -80 80 2 0 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 10 -50 0 0 {name=p14 sig_type=std_logic lab=VB_P}
C {devices/lab_wire.sym} -20 140 0 0 {name=p17 sig_type=std_logic lab=VTAIL}
C {devices/lab_wire.sym} 280 190 0 0 {name=p20 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} 190 -50 0 1 {name=p22 sig_type=std_logic lab=V2}
C {devices/ipin.sym} -200 80 0 0 {name=p4 lab=IN-}
C {devices/opin.sym} 420 80 0 0 {name=p9 lab=OUT}
C {devices/ipin.sym} 200 80 0 1 {name=p2 lab=IN+}
C {devices/ipin.sym} -470 260 0 0 {name=p1 lab=VSS}
C {devices/lab_wire.sym} 80 80 2 1 {name=p6 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -410 20 2 1 {name=p13 sig_type=std_logic lab=VSS}
C {LELO_ATR_SKY130Aa/LELOATR_LVT_NCH_4C5F0.sym} -160 80 0 0 {name=x18[4:0]}
C {LELO_ATR_SKY130Aa/LELOATR_LVT_NCH_4C5F0.sym} 160 80 0 1 {name=x19[4:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -40 190 0 0 {name=x2[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 80 -50 0 0 {name=x20[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -80 -50 0 1 {name=x21[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 320 -50 0 0 {name=x3[2:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -320 190 0 1 {name=x4}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 320 190 0 0 {name=x6}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -360 -20 1 0 {name=x1 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 640 -50 0 0 {name=x9}
C {devices/lab_wire.sym} 680 -110 0 0 {name=p15 sig_type=std_logic lab=SUPPLY}
C {devices/lab_wire.sym} 610 -50 2 1 {name=p18 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 680 10 2 1 {name=p19 sig_type=std_logic lab=VTAIL}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 1010 100 0 0 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 1010 200 0 0 {name=x3}
C {devices/lab_wire.sym} 950 100 0 0 {name=p7 sig_type=std_logic lab=OUT}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 1010 -50 0 0 {name=x5}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 920 -50 0 1 {name=x7}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 920 200 0 1 {name=x8}
C {devices/lab_wire.sym} 960 -110 0 0 {name=p10 sig_type=std_logic lab=SUPPLY}
C {devices/lab_wire.sym} 880 60 0 0 {name=p11 sig_type=std_logic lab=OUT}
C {devices/lab_wire.sym} 970 260 2 1 {name=p12 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym} -40 -190 0 0 {name=x10 }
C {devices/ipin.sym} -100 -190 0 0 {name=p5 lab=PWRUP_N_1V8}
C {devices/ipin.sym} -50 -270 0 0 {name=p21 lab=VDD}
C {devices/lab_wire.sym} -260 -110 0 0 {name=p23 sig_type=std_logic lab=SUPPLY}
