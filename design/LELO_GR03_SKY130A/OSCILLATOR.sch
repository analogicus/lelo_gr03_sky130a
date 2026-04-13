v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Generating bias voltages} 555 -295 0 0 0.4 0.4 {}
T {Current and voltage propotional to temperature} -500 -70 0 0 0.4 0.4 {}
N -270 -180 -270 -170 {lab=VSS}
N -270 -270 -270 -260 {lab=VDD_1V8}
N -170 -180 -170 -170 {lab=VSS}
N -170 -270 -170 -260 {lab=VDD_1V8}
N -230 -220 -210 -220 {lab=PWRUP_N_1V8_BUF}
N -320 -220 -310 -220 {lab=PWRUP_1V8}
N -130 -220 -110 -220 {lab=PWRUP_1V8_BUF}
N -220 -220 -220 -140 {lab=PWRUP_N_1V8_BUF}
N -220 -140 -110 -140 {lab=PWRUP_N_1V8_BUF}
N -350 0 -320 0 {lab=PWRUP_1V8_BUF}
N -350 20 -320 20 {lab=PWRUP_N_1V8_BUF}
N -350 -20 -320 -20 {lab=VDD_1V8}
N -350 40 -320 40 {lab=VSS}
N -20 -0 130 0 {lab=VX}
N 130 0 130 40 {lab=VX}
N 130 -0 270 0 {lab=VX}
N 270 0 270 40 {lab=VX}
N 130 100 130 140 {lab=VSS}
N 130 140 270 140 {lab=VSS}
N 70 70 70 100 {lab=PWRUP_N_1V8_BUF}
N 70 70 90 70 {lab=PWRUP_N_1V8_BUF}
N 100 140 130 140 {lab=VSS}
N 130 70 160 70 {lab=VSS}
N 160 70 160 140 {lab=VSS}
N 210 70 230 70 {lab=F_IN}
N 270 0 450 0 {lab=VX}
N 450 0 450 40 {lab=VX}
N 450 110 450 140 {lab=VSS}
N 270 140 450 140 {lab=VSS}
N 450 -0 520 -0 {lab=VX}
N -20 40 0 40 {lab=V_CTAT}
N 490 -40 520 -40 {lab=V_CTAT}
N 670 60 670 80 {lab=VDD_1V8}
N 670 -120 670 -100 {lab=VSS}
N 730 -120 730 -100 {lab=PWRUP_1V8_BUF}
N 730 60 730 80 {lab=PWRUP_N_1V8_BUF}
N 820 -20 930 -20 {lab=F_IN}
N 930 -20 930 200 {lab=F_IN}
N 210 70 210 200 {lab=F_IN}
N 270 70 300 70 {lab=VSS}
N 300 70 300 140 {lab=VSS}
N 270 100 270 140 {lab=VSS}
N 160 -150 180 -150 {lab=F_IN}
N 240 -120 240 -100 {lab=VSS}
N 210 -120 210 -100 {lab=VDD_1V8}
N 280 -210 290 -210 {
lab=F_OUT}
N 240 -260 240 -240 {lab=VDD_1V8}
N 600 -120 600 -100 {lab=VB_N}
N 845 -235 875 -235 {lab=VB_P}
N 845 -200 875 -200 {lab=VB_N}
N 575 -245 605 -245 {lab=VDD_1V8}
N 575 -225 605 -225 {lab=PWRUP_1V8_BUF}
N 575 -205 605 -205 {lab=PWRUP_N_1V8_BUF}
N 575 -185 605 -185 {lab=VSS}
N -350 60 -320 60 {lab=VB_P}
N 280 -150 375 -150 {lab=#net1}
N 135 -210 180 -210 {lab=#net1}
N 135 -295 135 -210 {lab=#net1}
N 135 -295 375 -295 {lab=#net1}
N 375 -295 375 -150 {lab=#net1}
N 210 200 930 200 {lab=F_IN}
C {LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym} -170 20 0 0 {name=x1}
C {devices/ipin.sym} -320 -220 0 0 {name=p3 lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -310 -220 0 0 {name=x6 }
C {devices/lab_pin.sym} -270 -170 0 1 {name=l13 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -270 -270 0 1 {name=l14 sig_type=std_logic lab=VDD_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -210 -220 0 0 {name=x2 }
C {devices/lab_pin.sym} -170 -170 0 1 {name=l1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -170 -270 0 1 {name=l2 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} -110 -220 0 1 {name=l3 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -110 -140 0 1 {name=l4 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/ipin.sym} -350 -20 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -350 40 0 0 {name=p2 lab=VSS}
C {devices/lab_pin.sym} -350 0 0 0 {name=l5 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -350 20 0 0 {name=l6 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 450 50 2 0 {name=x12[1:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 90 70 0 0 {name=x4 }
C {devices/lab_pin.sym} 70 100 0 0 {name=l9 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_pin.sym} 100 140 0 0 {name=l10 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 0 40 0 1 {name=l11 sig_type=std_logic lab=V_CTAT}
C {devices/lab_pin.sym} 490 -40 0 0 {name=l12 sig_type=std_logic lab=V_CTAT}
C {devices/lab_pin.sym} 670 80 0 0 {name=l15 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 670 -120 0 0 {name=l16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 730 -120 0 1 {name=l17 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} 730 80 0 1 {name=l18 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_wire.sym} 360 0 0 0 {name=p5 sig_type=std_logic lab=VX}
C {LELO_GR03_SKY130A/COMPARATOR.sym} 670 0 2 1 {name=x7}
C {JNW_TR_SKY130A/JNWTR_DFRNQNX1_CV.sym} 180 -150 0 0 {name=x10 }
C {devices/lab_pin.sym} 930 90 0 1 {name=l23 sig_type=std_logic lab=F_IN}
C {devices/lab_pin.sym} 160 -150 0 0 {name=l24 sig_type=std_logic lab=F_IN}
C {devices/lab_pin.sym} 240 -100 3 0 {name=l25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 210 -100 3 0 {name=l26 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 240 -260 0 0 {name=l27 sig_type=std_logic lab=VDD_1V8}
C {devices/opin.sym} 290 -210 0 0 {name=p4 lab=F_OUT}
C {devices/title.sym} -280 -370 0 0 {name=l28 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/lab_pin.sym} 600 -120 0 0 {name=l7 sig_type=std_logic lab=VB_N}
C {LELO_GR03_SKY130A/BIAS_CIRCUIT.sym} 755 -215 0 0 {name=x3}
C {devices/lab_pin.sym} 875 -235 0 1 {name=l29 sig_type=std_logic lab=VB_P}
C {devices/lab_pin.sym} 875 -200 0 1 {name=l30 sig_type=std_logic lab=VB_N}
C {devices/lab_pin.sym} 575 -245 0 0 {name=l31 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 575 -225 0 0 {name=l32 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} 575 -205 0 0 {name=l33 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_pin.sym} 575 -185 0 0 {name=l38 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -350 60 0 0 {name=l39 sig_type=std_logic lab=VB_P}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 230 70 0 0 {name=x5 }
