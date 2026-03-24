v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -50 90 -10 90 {lab=VB_N}
N -130 90 -90 90 {lab=VSS}
N -90 210 -90 250 {lab=VSS}
N -90 -270 -90 -220 {lab=VDD_1V8}
N -90 -190 -60 -190 {lab=VDD_1V8}
N -60 -240 -60 -190 {lab=VDD_1V8}
N -90 -240 -60 -240 {lab=VDD_1V8}
N -90 200 -90 210 {lab=VSS}
N -90 170 -60 170 {lab=VSS}
N -60 170 -60 210 {lab=VSS}
N -90 210 -60 210 {lab=VSS}
N -90 -160 -90 -140 {lab=#net1}
N -90 120 -90 140 {lab=#net2}
N -90 50 -30 50 {lab=VB_N}
N -90 40 -90 60 {lab=VB_N}
N -140 0 -110 0 {lab=VSS}
N -30 50 -30 90 {lab=VB_N}
N 80 90 120 90 {lab=VSS}
N -10 90 40 90 {lab=VB_N}
N 80 210 80 250 {lab=VSS}
N 80 200 80 210 {lab=VSS}
N 50 170 80 170 {lab=VSS}
N 50 170 50 210 {lab=VSS}
N 50 210 80 210 {lab=VSS}
N 80 120 80 140 {lab=#net3}
N 80 -40 80 60 {lab=VB_P}
N 80 -70 110 -70 {lab=VDD_1V8}
N 20 -70 40 -70 {lab=VB_P}
N 20 -70 20 -30 {lab=VB_P}
N 20 -30 80 -30 {lab=VB_P}
N 10 -70 20 -70 {lab=VB_P}
N 80 -270 80 -220 {lab=VDD_1V8}
N 50 -190 80 -190 {lab=VDD_1V8}
N 50 -240 50 -190 {lab=VDD_1V8}
N 50 -240 80 -240 {lab=VDD_1V8}
N 80 -160 80 -100 {lab=#net4}
N -150 -160 -150 -150 {lab=VSS}
N -150 -40 -150 -30 {lab=VSS}
N -280 -40 -240 -40 {lab=VDD_1V8}
N 120 -190 150 -190 {lab=PWRUP_N_1V8}
N -160 -190 -130 -190 {lab=PWRUP_N_1V8}
N -10 -70 10 -70 {lab=VB_P}
N -110 -130 -90 -130 {lab=#net1}
N -190 -130 -190 -60 {lab=#net5}
N -110 -60 -90 -60 {lab=#net6}
N -90 -60 -90 -40 {lab=#net6}
N -90 -140 -90 -130 {lab=#net1}
N -280 20 -240 20 {lab=VSS}
N -280 -20 -240 -20 {lab=PWRUP_1V8}
N -280 0 -240 0 {lab=PWRUP_N_1V8}
N -160 170 -130 170 {lab=PWRUP_1V8}
N 120 170 150 170 {lab=PWRUP_1V8}
N 185 -20 225 -20 {lab=VB_P}
N 185 5 225 5 {lab=VB_P}
C {devices/lab_wire.sym} -10 90 0 1 {name=p8 sig_type=std_logic lab=VB_N}
C {devices/lab_wire.sym} -150 -160 0 0 {name=p13 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -50 90 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -110 -130 2 0 {name=x11 }
C {devices/lab_wire.sym} -130 90 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -90 250 0 0 {name=l29 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -90 -270 0 1 {name=l31 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -160 -190 0 0 {name=p19 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} -160 170 0 0 {name=p7 sig_type=std_logic lab=PWRUP_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -130 -190 0 0 {name=x12 }
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} -130 170 0 0 {name=x13 }
C {devices/lab_wire.sym} -140 0 2 1 {name=p9 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 40 90 0 0 {name=x15}
C {devices/lab_wire.sym} 120 90 2 0 {name=p10 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 80 250 0 1 {name=l30 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 150 170 0 1 {name=p11 sig_type=std_logic lab=PWRUP_1V8}
C {JNW_ATR_SKY130A/JNWATR_NCH_8C1F2.sym} 120 170 0 1 {name=x16 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 40 -70 0 0 {name=x17 }
C {devices/lab_pin.sym} 110 -70 0 1 {name=l32 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -10 -70 0 0 {name=p12 sig_type=std_logic lab=VB_P}
C {devices/lab_pin.sym} 80 -270 0 1 {name=l33 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 150 -190 0 1 {name=p14 sig_type=std_logic lab=PWRUP_N_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} 120 -190 0 1 {name=x18 }
C {devices/lab_wire.sym} -150 -30 2 1 {name=p15 sig_type=std_logic lab=VSS}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -110 -60 0 1 {name=x19 }
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} -90 -40 1 0 {name=x14 }
C {devices/ipin.sym} -280 -40 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -280 20 0 0 {name=p2 lab=VSS}
C {devices/ipin.sym} -280 -20 0 0 {name=p3 lab=PWRUP_1V8}
C {devices/ipin.sym} -280 0 0 0 {name=p4 lab=PWRUP_N_1V8}
C {devices/opin.sym} 225 -20 0 0 {name=p5 lab=VB_P}
C {devices/opin.sym} 225 5 0 0 {name=p6 lab=VB_N}
