v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -160 -20 -140 -20 {lab=VDD_1V8}
N -180 40 -140 40 {lab=VSS}
N 160 -20 210 -20 {lab=I_PTAT}
N 160 -0 210 0 {lab=V_CTAT}
N -180 -20 -160 -20 {lab=VDD_1V8}
N -180 20 -140 20 {lab=PWRUP_N_1V8}
N -180 -0 -140 0 {lab=PWRUP_1V8}
N -550 120 -510 120 {lab=V_IB}
N -530 70 -530 120 {lab=V_IB}
N -590 70 -530 70 {lab=V_IB}
N -630 120 -590 120 {lab=VSS}
N -590 260 -590 300 {lab=VSS}
N -640 -20 -610 -20 {lab=VSS}
N -690 -140 -630 -140 {lab=PWRUP_N_1V8}
N -590 -220 -590 -170 {lab=VDD_1V8}
N -590 -140 -560 -140 {lab=VDD_1V8}
N -560 -190 -560 -140 {lab=VDD_1V8}
N -590 -190 -560 -190 {lab=VDD_1V8}
N -590 250 -590 260 {lab=VSS}
N -690 220 -630 220 {lab=PWRUP_1V8}
N -590 220 -560 220 {lab=VSS}
N -560 220 -560 260 {lab=VSS}
N -590 260 -560 260 {lab=VSS}
N -590 150 -590 190 {lab=#net1}
N -590 -110 -590 -60 {lab=#net2}
N -590 20 -590 90 {lab=V_IB}
N 10 70 10 100 {lab=V_IB}
C {LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym} 10 0 0 0 {name=x1}
C {devices/ipin.sym} -180 40 0 0 {name=p1 lab=VSS}
C {devices/opin.sym} 210 -20 0 0 {name=p2 lab=I_PTAT}
C {devices/opin.sym} 210 0 0 0 {name=p3 lab=V_CTAT}
C {devices/ipin.sym} -180 -20 0 0 {name=p4 lab=VDD_1V8}
C {devices/title.sym} -210 -110 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -180 0 0 0 {name=p5 lab=PWRUP_1V8
}
C {devices/ipin.sym} -180 20 0 0 {name=p6 lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} -510 120 0 1 {name=p8 sig_type=std_logic lab=V_IB}
C {devices/lab_wire.sym} -640 -20 2 1 {name=p13 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -550 120 0 1 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -590 -60 1 0 {name=x11 }
C {devices/lab_wire.sym} -630 120 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -590 300 0 0 {name=l29 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -590 -220 0 1 {name=l31 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym} -630 -140 0 0 {name=x12}
C {devices/lab_wire.sym} -690 -140 0 0 {name=p19 sig_type=std_logic lab=PWRUP_N_1V8}
C {JNW_ATR_SKY130A/JNWATR_NCH_12C1F2.sym} -630 220 0 0 {name=x13}
C {devices/lab_wire.sym} -690 220 0 0 {name=p7 sig_type=std_logic lab=PWRUP_1V8}
C {devices/lab_wire.sym} 10 100 2 0 {name=p9 sig_type=std_logic lab=V_IB}
