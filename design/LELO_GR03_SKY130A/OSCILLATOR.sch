v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Generating bias current} -910 -330 0 0 0.4 0.4 {}
N -270 -180 -270 -170 {lab=VSS}
N -270 -270 -270 -260 {lab=VDD_1V8}
N -170 -180 -170 -170 {lab=VSS}
N -170 -270 -170 -260 {lab=VDD_1V8}
N -230 -220 -210 -220 {lab=PWRUP_N_1V8_BUF}
N -320 -220 -310 -220 {lab=PWRUP_1V8}
N -130 -220 -110 -220 {lab=PWRUP_1V8_BUF}
N -220 -220 -220 -140 {lab=PWRUP_N_1V8_BUF}
N -220 -140 -110 -140 {lab=PWRUP_N_1V8_BUF}
N -350 20 -320 20 {lab=PWRUP_1V8_BUF}
N -350 40 -320 40 {lab=PWRUP_N_1V8_BUF}
N -350 -0 -320 -0 {lab=VDD_1V8}
N -350 60 -320 60 {lab=VSS}
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
N 210 70 230 70 {lab=RST}
N 270 0 450 0 {lab=VX}
N 450 0 450 40 {lab=VX}
N 450 110 450 140 {lab=VSS}
N 270 140 450 140 {lab=VSS}
N 450 -0 520 -0 {lab=VX}
N -20 20 0 20 {lab=V_CTAT}
N 490 -40 520 -40 {lab=V_CTAT}
N 670 60 670 80 {lab=VDD_1V8}
N 670 -120 670 -100 {lab=VSS}
N 730 -120 730 -100 {lab=PWRUP_1V8_BUF}
N 730 60 730 80 {lab=PWRUP_N_1V8_BUF}
N 790 240 790 250 {lab=VSS}
N 790 150 790 160 {lab=VDD_1V8}
N 690 240 690 250 {lab=VSS}
N 690 150 690 160 {lab=VDD_1V8}
N 730 200 750 200 {lab=#net1}
N 820 -20 930 -20 {lab=F_IN}
N 930 -20 930 200 {lab=F_IN}
N 830 200 930 200 {lab=F_IN}
N 210 200 650 200 {lab=RST}
N 210 70 210 200 {lab=RST}
N 270 70 300 70 {lab=VSS}
N 300 70 300 140 {lab=VSS}
N 270 100 270 140 {lab=VSS}
N 190 -150 210 -150 {lab=F_IN}
N 270 -120 270 -100 {lab=VSS}
N 240 -120 240 -100 {lab=VDD_1V8}
N 310 -150 340 -150 {lab=#net2}
N 400 -260 400 -150 {lab=#net2}
N 180 -310 340 -310 {lab=#net2}
N 180 -260 180 -210 {lab=#net2}
N 180 -210 210 -210 {lab=#net2}
N 690 130 690 150 {
lab=VDD_1V8}
N 790 130 790 150 {
lab=VDD_1V8}
N 180 -310 180 -260 {
lab=#net2}
N 310 -210 320 -210 {
lab=F_OUT}
N 340 -150 400 -150 {
lab=#net2}
N 270 -260 270 -240 {lab=VDD_1V8}
N 400 -310 400 -260 {lab=#net2}
N 340 -310 400 -310 {lab=#net2}
N -710 80 -670 80 {lab=V_IB}
N -690 30 -690 80 {lab=V_IB}
N -750 30 -690 30 {lab=V_IB}
N -790 80 -750 80 {lab=VSS}
N -750 220 -750 260 {lab=VSS}
N -800 -60 -770 -60 {lab=VSS}
N 600 -120 600 -100 {lab=V_IB}
N -170 90 -170 110 {lab=V_IB}
N -850 -180 -790 -180 {lab=PWRUP_N_1V8_BUF}
N -750 -260 -750 -210 {lab=VDD_1V8}
N -750 -180 -720 -180 {lab=VDD_1V8}
N -720 -230 -720 -180 {lab=VDD_1V8}
N -750 -230 -720 -230 {lab=VDD_1V8}
N -750 210 -750 220 {lab=VSS}
N -850 180 -790 180 {lab=PWRUP_1V8_BUF}
N -750 180 -720 180 {lab=VSS}
N -720 180 -720 220 {lab=VSS}
N -750 220 -720 220 {lab=VSS}
N -750 110 -750 150 {lab=#net3}
N -750 -150 -750 -100 {lab=#net4}
N -750 -20 -750 50 {lab=V_IB}
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
C {devices/ipin.sym} -350 0 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -350 60 0 0 {name=p2 lab=VSS}
C {devices/lab_pin.sym} -350 20 0 0 {name=l5 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -350 40 0 0 {name=l6 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 450 50 2 0 {name=x3[2:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 90 70 0 0 {name=x4 }
C {devices/lab_pin.sym} 70 100 0 0 {name=l9 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_pin.sym} 100 140 0 0 {name=l10 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 230 70 0 0 {name=x5 }
C {devices/lab_pin.sym} 0 20 0 1 {name=l11 sig_type=std_logic lab=V_CTAT}
C {devices/lab_pin.sym} 490 -40 0 0 {name=l12 sig_type=std_logic lab=V_CTAT}
C {devices/lab_pin.sym} 670 80 0 0 {name=l15 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 670 -120 0 0 {name=l16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 730 -120 0 1 {name=l17 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} 730 80 0 1 {name=l18 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} 830 200 0 1 {name=x8 }
C {devices/lab_pin.sym} 790 250 0 0 {name=l19 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 790 130 0 0 {name=l20 sig_type=std_logic lab=VDD_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} 730 200 0 1 {name=x9 }
C {devices/lab_pin.sym} 690 250 0 0 {name=l21 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 690 130 0 0 {name=l22 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 360 0 0 0 {name=p5 sig_type=std_logic lab=VX}
C {LELO_GR03_SKY130A/COMPARATOR.sym} 670 0 2 1 {name=x7}
C {devices/lab_wire.sym} 420 200 0 0 {name=p6 sig_type=std_logic lab=RST}
C {JNW_TR_SKY130A/JNWTR_DFRNQNX1_CV.sym} 210 -150 0 0 {name=x10 }
C {devices/lab_pin.sym} 930 90 0 1 {name=l23 sig_type=std_logic lab=F_IN}
C {devices/lab_pin.sym} 190 -150 0 0 {name=l24 sig_type=std_logic lab=F_IN}
C {devices/lab_pin.sym} 270 -100 3 0 {name=l25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 240 -100 3 0 {name=l26 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} 270 -260 0 0 {name=l27 sig_type=std_logic lab=VDD_1V8}
C {devices/opin.sym} 320 -210 0 0 {name=p4 lab=F_OUT}
C {devices/title.sym} -520 -360 0 0 {name=l28 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/lab_wire.sym} -670 80 0 1 {name=p8 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} -800 -60 2 1 {name=p13 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -710 80 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -750 -100 1 0 {name=x11 }
C {devices/lab_wire.sym} -790 80 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 600 -120 0 0 {name=l7 sig_type=std_logic lab=V_IB}
C {devices/lab_pin.sym} -170 110 0 0 {name=l8 sig_type=std_logic lab=V_IB}
C {devices/lab_pin.sym} -750 260 0 0 {name=l29 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -750 -260 0 1 {name=l31 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym} -790 -180 0 0 {name=x12}
C {devices/lab_wire.sym} -850 -180 0 0 {name=p19 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {JNW_ATR_SKY130A/JNWATR_NCH_12C1F2.sym} -790 180 0 0 {name=x13}
C {devices/lab_wire.sym} -850 180 0 0 {name=p7 sig_type=std_logic lab=PWRUP_1V8_BUF}
