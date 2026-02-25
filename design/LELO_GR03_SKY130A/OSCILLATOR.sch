v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -510 -100 -510 -90 {lab=VSS}
N -510 -190 -510 -180 {lab=VDD_1V8}
N -410 -100 -410 -90 {lab=VSS}
N -410 -190 -410 -180 {lab=VDD_1V8}
N -470 -140 -450 -140 {lab=PWRUP_N_1V8_BUF}
N -560 -140 -550 -140 {lab=PWRUP_1V8}
N -370 -140 -350 -140 {lab=PWRUP_1V8_BUF}
N -460 -140 -460 -60 {lab=PWRUP_N_1V8_BUF}
N -460 -60 -350 -60 {lab=PWRUP_N_1V8_BUF}
N -560 0 -540 0 {lab=VDD_1V8}
N -560 30 -540 30 {lab=VSS}
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
N 820 -20 930 -20 {lab=OUT}
N 930 -20 930 200 {lab=OUT}
N 830 200 930 200 {lab=OUT}
N 210 200 650 200 {lab=RST}
N 210 70 210 200 {lab=RST}
N 270 70 300 70 {lab=VSS}
N 300 70 300 140 {lab=VSS}
N 930 -20 970 -20 {lab=OUT}
N 270 100 270 140 {lab=VSS}
C {LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym} -170 20 0 0 {name=x1}
C {devices/ipin.sym} -560 -140 0 0 {name=p3 lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -550 -140 0 0 {name=x6 }
C {devices/lab_pin.sym} -510 -90 0 1 {name=l13 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -510 -190 0 1 {name=l14 sig_type=std_logic lab=VDD_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -450 -140 0 0 {name=x2 }
C {devices/lab_pin.sym} -410 -90 0 1 {name=l1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -410 -190 0 1 {name=l2 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} -350 -140 0 1 {name=l3 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -350 -60 0 1 {name=l4 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/ipin.sym} -560 0 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -560 30 0 0 {name=p2 lab=VSS}
C {devices/lab_pin.sym} -350 20 0 0 {name=l5 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_pin.sym} -350 40 0 0 {name=l6 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_pin.sym} -350 0 0 0 {name=l7 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_pin.sym} -350 60 0 0 {name=l8 sig_type=std_logic lab=VSS}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} 450 50 2 0 {name=x3 }
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
C {devices/lab_pin.sym} 790 150 0 0 {name=l20 sig_type=std_logic lab=VDD_1V8}
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} 730 200 0 1 {name=x9 }
C {devices/lab_pin.sym} 690 250 0 0 {name=l21 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 690 150 0 0 {name=l22 sig_type=std_logic lab=VDD_1V8}
C {devices/opin.sym} 970 -20 0 0 {name=p4 lab=OUT}
C {devices/lab_wire.sym} 360 0 0 0 {name=p5 sig_type=std_logic lab=VX}
C {LELO_GR03_SKY130A/COMPARATOR.sym} 670 0 2 1 {name=x7}
C {devices/lab_wire.sym} 420 200 0 0 {name=p6 sig_type=std_logic lab=RST}
