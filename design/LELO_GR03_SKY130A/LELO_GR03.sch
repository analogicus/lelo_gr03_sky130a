v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Generating bias voltages} 395 -535 0 0 0.4 0.4 {}
T {Current and voltage propotional to temperature} -660 -310 0 0 0.4 0.4 {}
N -430 -420 -430 -410 {lab=VSS}
N -430 -510 -430 -500 {lab=VDD_1V8}
N -330 -420 -330 -410 {lab=VSS}
N -330 -510 -330 -500 {lab=VDD_1V8}
N -390 -460 -370 -460 {lab=PWRUP_N_1V8_BUF}
N -480 -460 -470 -460 {lab=PWRUP_1V8}
N -290 -460 -270 -460 {lab=PWRUP_1V8_BUF}
N -380 -460 -380 -380 {lab=PWRUP_N_1V8_BUF}
N -380 -380 -270 -380 {lab=PWRUP_N_1V8_BUF}
N -510 -240 -480 -240 {lab=PWRUP_1V8_BUF}
N -510 -220 -480 -220 {lab=PWRUP_N_1V8_BUF}
N -510 -260 -480 -260 {lab=VDD_1V8}
N -510 -200 -480 -200 {lab=VSS}
N -180 -240 -30 -240 {lab=VX}
N -30 -240 -30 -200 {lab=VX}
N -30 -240 110 -240 {lab=VX}
N 110 -240 110 -200 {lab=VX}
N -30 -140 -30 -100 {lab=VSS}
N -30 -100 110 -100 {lab=VSS}
N -90 -170 -90 -140 {lab=PWRUP_N_1V8_BUF}
N -90 -170 -70 -170 {lab=PWRUP_N_1V8_BUF}
N -60 -100 -30 -100 {lab=VSS}
N -30 -170 0 -170 {lab=VSS}
N 0 -170 0 -100 {lab=VSS}
N 50 -170 70 -170 {lab=F_IN}
N 110 -240 290 -240 {lab=VX}
N 290 -240 290 -200 {lab=VX}
N 290 -130 290 -100 {lab=VSS}
N 110 -100 290 -100 {lab=VSS}
N 290 -240 360 -240 {lab=VX}
N -180 -200 -160 -200 {lab=V_CTAT}
N 330 -280 360 -280 {lab=V_CTAT}
N 510 -180 510 -160 {lab=VDD_1V8}
N 510 -360 510 -340 {lab=VSS}
N 570 -360 570 -340 {lab=PWRUP_1V8_BUF}
N 570 -180 570 -160 {lab=PWRUP_N_1V8_BUF}
N 660 -260 770 -260 {lab=F_IN}
N 770 -260 770 -40 {lab=F_IN}
N 50 -170 50 -40 {lab=F_IN}
N 110 -170 140 -170 {lab=VSS}
N 140 -170 140 -100 {lab=VSS}
N 110 -140 110 -100 {lab=VSS}
N 0 -390 20 -390 {lab=F_IN}
N 80 -360 80 -340 {lab=VSS}
N 50 -360 50 -340 {lab=VDD_1V8}
N 120 -450 130 -450 {
lab=OSC_TEMP_1V8}
N 80 -500 80 -480 {lab=VDD_1V8}
N 440 -360 440 -340 {lab=VB_N}
N 685 -475 715 -475 {lab=VB_P}
N 685 -440 715 -440 {lab=VB_N}
N 415 -485 445 -485 {lab=VDD_1V8}
N 415 -465 445 -465 {lab=PWRUP_1V8_BUF}
N 415 -445 445 -445 {lab=PWRUP_N_1V8_BUF}
N 415 -425 445 -425 {lab=VSS}
N -510 -180 -480 -180 {lab=VB_P}
N 120 -390 215 -390 {lab=#net1}
N -25 -450 20 -450 {lab=#net1}
N -25 -535 -25 -450 {lab=#net1}
N -25 -535 215 -535 {lab=#net1}
N 215 -535 215 -390 {lab=#net1}
N 50 -40 770 -40 {lab=F_IN}
C {cborder/border_xs.sym} 20 20 0 0 {
user="wulff"
company="wulff"}
C {devices/opin.sym} 130 -450 0 0 {name=p29 lab=OSC_TEMP_1V8}
C {LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym} -330 -220 0 0 {name=x1}
C {devices/ipin.sym} -480 -460 0 0 {name=p3 lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -470 -460 0 0 {name=x6 }
C {devices/lab_pin.sym} -430 -410 0 1 {name=l13 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -430 -510 0 1 {name=l14 sig_type=std_logic lab=VDD_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -370 -460 0 0 {name=x2 }
C {devices/lab_pin.sym} -330 -410 0 1 {name=l1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -330 -510 0 1 {name=l2 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} -270 -460 0 1 {name=l3 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -270 -380 0 1 {name=l4 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/ipin.sym} -510 -260 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -510 -200 0 0 {name=p2 lab=VSS}
C {devices/lab_pin.sym} -510 -240 0 0 {name=l5 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -510 -220 0 0 {name=l6 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 290 -140 0 0 {name=x12[1:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -70 -170 0 0 {name=x4 }
C {devices/lab_pin.sym} -90 -140 0 0 {name=l9 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_pin.sym} -60 -100 0 0 {name=l10 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -160 -200 0 1 {name=l11 sig_type=std_logic lab=V_CTAT}
C {devices/lab_pin.sym} 330 -280 0 0 {name=l12 sig_type=std_logic lab=V_CTAT}
C {devices/lab_pin.sym} 510 -160 0 0 {name=l15 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 510 -360 0 0 {name=l16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 570 -360 0 1 {name=l17 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} 570 -160 0 1 {name=l18 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_wire.sym} 200 -240 0 0 {name=p5 sig_type=std_logic lab=VX}
C {LELO_GR03_SKY130A/COMPARATOR.sym} 510 -240 2 1 {name=x7}
C {JNW_TR_SKY130A/JNWTR_DFRNQNX1_CV.sym} 20 -390 0 0 {name=x10 }
C {devices/lab_pin.sym} 770 -150 0 1 {name=l23 sig_type=std_logic lab=F_IN}
C {devices/lab_pin.sym} 0 -390 0 0 {name=l24 sig_type=std_logic lab=F_IN}
C {devices/lab_pin.sym} 80 -340 3 0 {name=l25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 50 -340 3 0 {name=l26 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 80 -500 0 0 {name=l27 sig_type=std_logic lab=VDD_1V8}
C {devices/title.sym} -440 -610 0 0 {name=l28 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/lab_pin.sym} 440 -360 0 0 {name=l7 sig_type=std_logic lab=VB_N}
C {devices/lab_pin.sym} 715 -475 0 1 {name=l29 sig_type=std_logic lab=VB_P}
C {devices/lab_pin.sym} 715 -440 0 1 {name=l30 sig_type=std_logic lab=VB_N}
C {devices/lab_pin.sym} 415 -485 0 0 {name=l31 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 415 -465 0 0 {name=l32 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} 415 -445 0 0 {name=l33 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_pin.sym} 415 -425 0 0 {name=l38 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -510 -180 0 0 {name=l39 sig_type=std_logic lab=VB_P}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 70 -170 0 0 {name=x5 }
C {LELO_GR03_SKY130A/BIAS_CIRCUIT2.sym} 595 -455 0 0 {name=x3}
