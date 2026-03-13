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
N -120 -110 -120 -80 {lab=VD}
N 120 -110 120 -80 {lab=VD}
N -0 140 -0 160 {lab=VTAIL}
N -200 80 -160 80 {lab=IN-}
N 160 80 200 80 {lab=IN+}
N -140 -50 -120 -50 {lab=VDD}
N 120 -50 140 -50 {lab=VDD}
N -80 190 -40 190 {lab=V_IB}
N 0 220 0 260 {lab=#net1}
N 0 190 40 190 {lab=VSS}
N -120 80 -80 80 {lab=VSS}
N 80 80 120 80 {lab=VSS}
N 190 -50 190 20 {lab=V2}
N 360 -50 380 -50 {lab=VDD}
N 360 -110 360 -80 {lab=VD}
N 280 190 320 190 {lab=V_IB}
N 360 220 360 260 {lab=#net1}
N 360 190 400 190 {lab=VSS}
N 360 80 420 80 {lab=OUT}
N 360 -20 360 160 {lab=OUT}
N 190 -50 320 -50 {lab=V2}
N 120 20 190 20 {lab=V2}
N 0 -160 0 -110 {lab=VD}
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
N 190 20 200 20 {lab=V2}
N 280 20 290 20 {lab=#net2}
N 690 200 720 200 {lab=#net3}
N 690 150 690 200 {lab=#net3}
N 690 150 760 150 {lab=#net3}
N 760 130 760 170 {lab=#net3}
N 690 100 720 100 {lab=OUT}
N 660 100 690 100 {lab=OUT}
N 760 -20 760 70 {lab=#net4}
N 760 -110 760 -80 {lab=VD}
N 590 -110 760 -110 {lab=VD}
N 590 -110 590 -80 {lab=VD}
N 590 -20 590 170 {lab=OUT}
N 630 200 660 200 {lab=OUT}
N 660 150 660 200 {lab=OUT}
N 590 150 660 150 {lab=OUT}
N 630 -50 720 -50 {lab=#net4}
N 690 -50 690 0 {lab=#net4}
N 690 0 760 0 {lab=#net4}
N 590 230 590 260 {lab=VSS}
N 590 260 760 260 {lab=VSS}
N 760 230 760 260 {lab=VSS}
N 760 200 790 200 {lab=VSS}
N 560 200 590 200 {lab=VSS}
N 760 100 790 100 {lab=VSS}
N 790 100 790 200 {lab=VSS}
N 560 -50 590 -50 {lab=VDD}
N 560 -110 590 -110 {lab=VD}
N 760 -50 790 -50 {lab=VDD}
N 760 -110 790 -110 {lab=VD}
N 590 100 660 100 {
lab=OUT}
N 560 100 590 100 {
lab=OUT}
N -120 -110 360 -110 {lab=VD}
N 0 260 360 260 {lab=#net1}
N -200 190 -180 190 {lab=V_IB}
C {devices/lab_wire.sym} -80 190 0 0 {name=p3 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} -80 80 2 0 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 10 -50 0 0 {name=p14 sig_type=std_logic lab=VB_P}
C {devices/lab_wire.sym} -20 140 0 0 {name=p17 sig_type=std_logic lab=VTAIL}
C {devices/lab_wire.sym} 280 190 0 0 {name=p20 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} 190 -50 0 1 {name=p22 sig_type=std_logic lab=V2}
C {devices/ipin.sym} -200 80 0 0 {name=p4 lab=IN-}
C {devices/opin.sym} 420 80 0 0 {name=p9 lab=OUT}
C {devices/ipin.sym} 200 80 0 1 {name=p2 lab=IN+}
C {devices/ipin.sym} -110 360 0 0 {name=p1 lab=VSS}
C {devices/lab_wire.sym} 80 80 2 1 {name=p6 sig_type=std_logic lab=VSS}
C {LELO_ATR_SKY130A/LELOATR_LVT_NCH_4C5F0.sym} -160 80 0 0 {name=x18[4:0]}
C {LELO_ATR_SKY130A/LELOATR_LVT_NCH_4C5F0.sym} 160 80 0 1 {name=x19[4:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -40 190 0 0 {name=x2[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 80 -50 0 0 {name=x20}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -80 -50 0 1 {name=x21}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 320 -50 0 0 {name=x10}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 320 190 0 0 {name=x6}
C {devices/ipin.sym} -100 -190 0 0 {name=p5 lab=PWRUP_N_1V8}
C {devices/ipin.sym} -50 -270 0 0 {name=p21 lab=VDD}
C {devices/lab_wire.sym} -60 -110 0 0 {name=p23 sig_type=std_logic lab=VD}
C {devices/lab_wire.sym} 40 190 2 0 {name=p19 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 400 190 2 0 {name=p24 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -140 -50 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 140 -50 2 0 {name=p29 sig_type=std_logic lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym} -40 -190 0 0 {name=x9[3:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_12C1F2.sym} -40 320 0 0 {name=x1[3:0]}
C {devices/ipin.sym} -100 320 0 0 {name=p15 lab=PWRUP_1V8}
C {devices/lab_wire.sym} 380 -50 0 1 {name=p18 sig_type=std_logic lab=VDD}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 200 20 0 0 {name=x9 }
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 300 20 1 0 {name=x11 }
C {devices/lab_wire.sym} 240 40 2 1 {name=p32 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 720 100 0 0 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 720 200 0 0 {name=x3}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 720 -50 0 0 {name=x5}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 630 -50 0 1 {name=x7}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 630 200 0 1 {name=x8}
C {devices/lab_wire.sym} 670 -110 0 0 {name=p10 sig_type=std_logic lab=VD}
C {devices/lab_wire.sym} 560 100 0 0 {name=p11 sig_type=std_logic lab=OUT}
C {devices/lab_wire.sym} 680 260 2 1 {name=p12 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 560 200 2 1 {name=p26 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 790 200 2 0 {name=p27 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 560 -50 0 0 {name=p30 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 790 -50 0 1 {name=p31 sig_type=std_logic lab=VDD}
C {devices/title.sym} -320 -320 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -200 190 0 0 {name=p7 lab=V_IB}
