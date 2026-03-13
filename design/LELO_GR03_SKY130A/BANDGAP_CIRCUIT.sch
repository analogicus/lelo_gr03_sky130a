v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -140 -130 60 -130 {lab=VB_P}
N -280 -200 420 -200 {lab=#net1}
N -60 270 -60 280 {lab=V_CTAT}
N -180 280 -60 280 {lab=V_CTAT}
N -20 270 -20 280 {lab=DV}
N -20 280 100 280 {lab=DV}
N 60 350 80 350 {lab=VSS}
N 100 390 100 430 {lab=VD2}
N -180 280 -180 430 {lab=V_CTAT}
N -180 490 -180 530 {lab=VSS}
N -180 510 -120 510 {lab=VSS}
N -120 460 -120 510 {lab=VSS}
N -140 460 -120 460 {lab=VSS}
N 100 490 100 530 {lab=VSS}
N -280 530 100 530 {lab=VSS}
N 40 510 100 510 {lab=VSS}
N 40 460 40 510 {lab=VSS}
N 40 460 60 460 {lab=VSS}
N 320 -130 350 -130 {lab=VDD_1V8}
N 250 -130 280 -130 {lab=VB_P}
N 320 -100 320 -20 {lab=I_PTAT}
N -130 120 -120 120 {lab=VSS}
N 40 120 50 120 {lab=VDD_1V8}
N 100 -130 140 -130 {lab=VDD_1V8}
N -220 -130 -180 -130 {lab=VDD_1V8}
N -180 -200 -180 -160 {lab=#net1}
N 100 -200 100 -160 {lab=#net1}
N 320 -200 320 -160 {lab=#net1}
N 100 -100 100 310 {lab=DV}
N -180 -100 -180 280 {lab=V_CTAT}
N 320 -20 350 -20 {lab=I_PTAT}
N -220 280 -180 280 {lab=V_CTAT}
N 40 -130 40 -80 {lab=VB_P}
N 40 -80 250 -80 {lab=VB_P}
N 250 -130 250 -80 {lab=VB_P}
N -40 -130 -40 -30 {lab=VB_P}
N -460 -70 -400 -70 {lab=PWRUP_1V8}
N -40 -250 -40 -200 {lab=#net1}
N -140 -280 -80 -280 {lab=PWRUP_N_1V8}
N -40 -360 -40 -310 {lab=VDD_1V8}
N -90 -360 -40 -360 {lab=VDD_1V8}
N 40 60 50 60 {lab=PWRUP_N_1V8}
N -40 -280 -10 -280 {lab=VDD_1V8}
N -10 -330 -10 -280 {lab=VDD_1V8}
N -40 -330 -10 -330 {lab=VDD_1V8}
N -130 60 -120 60 {lab=PWRUP_1V8}
N -460 -30 -400 -30 {lab=PWRUP_N_1V8}
N -460 10 -400 10 {lab=V_IB}
N -130 190 -120 190 {lab=V_IB}
C {devices/lab_pin.sym} 60 350 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -130 120 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 100 410 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/lab_pin.sym} 100 280 0 1 {name=p18 sig_type=std_logic lab=DV}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} -40 -190 2 0 {name=x6 }
C {devices/opin.sym} 350 -20 0 0 {name=p4 lab=I_PTAT}
C {devices/opin.sym} -220 280 0 1 {name=p15 lab=V_CTAT}
C {devices/ipin.sym} -90 -360 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -280 530 0 0 {name=p2 lab=VSS}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -20 120 1 1 {name=x7}
C {devices/lab_wire.sym} 10 -130 0 0 {name=p3 sig_type=std_logic lab=VB_P}
C {sky130_fd_pr/pnp_05v5.sym} -160 460 0 1 {name=Q1
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {sky130_fd_pr/pnp_05v5.sym} 80 460 0 0 {name=Q2[7:0]
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {devices/ipin.sym} -460 -70 0 0 {name=p12 lab=PWRUP_1V8}
C {devices/lab_wire.sym} 50 60 0 1 {name=p17 sig_type=std_logic lab=PWRUP_N_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym} -80 -280 0 0 {name=x10[3:0]}
C {devices/lab_wire.sym} -140 -280 0 0 {name=p19 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} 50 120 0 1 {name=p6 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -220 -130 0 0 {name=p21 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 140 -130 0 1 {name=p22 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 350 -130 0 1 {name=p23 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 60 -130 0 0 {name=x20}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -140 -130 0 1 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 280 -130 0 0 {name=x3}
C {devices/lab_wire.sym} -130 60 0 0 {name=p20 sig_type=std_logic lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 100 310 1 0 {name=x4 }
C {devices/ipin.sym} -460 -30 0 0 {name=p7 lab=PWRUP_N_1V8}
C {devices/title.sym} -520 -430 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -460 10 0 0 {name=p8 lab=V_IB}
C {devices/lab_wire.sym} -130 190 0 0 {name=p10 sig_type=std_logic lab=V_IB}
