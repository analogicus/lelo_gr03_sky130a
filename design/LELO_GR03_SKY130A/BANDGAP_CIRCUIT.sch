v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -140 -130 60 -130 {lab=VB_P}
N -280 -200 420 -200 {lab=VDD}
N -60 270 -60 280 {lab=V_CTAT}
N -180 280 -60 280 {lab=V_CTAT}
N -20 270 -20 280 {lab=DV}
N -20 280 100 280 {lab=DV}
N 60 350 80 350 {lab=0}
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
N 320 -130 350 -130 {lab=VDD}
N 250 -130 280 -130 {lab=VB_P}
N 320 -100 320 -20 {lab=I_PTAT}
N -130 120 -120 120 {lab=VDD_1V8}
N 40 120 50 120 {lab=0}
N 100 -130 140 -130 {lab=VDD}
N 140 -200 140 -130 {lab=VDD}
N -220 -130 -180 -130 {lab=VDD}
N -220 -200 -220 -130 {lab=VDD}
N 350 -200 350 -130 {lab=VDD}
N -180 -200 -180 -160 {lab=VDD}
N 100 -200 100 -160 {lab=VDD}
N 320 -200 320 -160 {lab=VDD}
N 100 -100 100 310 {lab=DV}
N -180 -100 -180 280 {lab=V_CTAT}
N 320 -20 350 -20 {lab=I_PTAT}
N -220 280 -180 280 {lab=V_CTAT}
N 40 -130 40 -80 {lab=VB_P}
N 40 -80 250 -80 {lab=VB_P}
N 250 -130 250 -80 {lab=VB_P}
N -40 -130 -40 -30 {lab=VB_P}
N -680 -10 -630 -10 {lab=PWRUP_N_1V8_BUF}
N -720 30 -720 60 {lab=VSS}
N -590 30 -590 60 {lab=VSS}
N -720 -80 -720 -50 {lab=VDD_1V8}
N -590 -80 -590 -50 {lab=VDD_1V8}
N -820 -10 -760 -10 {lab=PWRUP_1V8}
N -660 -10 -660 120 {lab=PWRUP_N_1V8_BUF}
N -660 120 -610 120 {lab=PWRUP_N_1V8_BUF}
N -550 -10 -500 -10 {lab=PWRUP_1V8_BUF}
N -130 60 -120 60 {lab=PWRUP_N_1V8_BUF}
N -40 -250 -40 -200 {lab=VDD}
N -140 -280 -80 -280 {lab=PWRUP_N_1V8_BUF}
N -40 -360 -40 -310 {lab=VDD_1V8}
N -90 -360 -40 -360 {lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 60 -130 0 0 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} -140 -130 0 1 {name=x3}
C {devices/lab_pin.sym} 60 350 0 0 {name=p5 sig_type=std_logic lab=0}
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} 100 310 1 0 {name=x4 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 280 -130 0 0 {name=x5}
C {devices/lab_wire.sym} 50 120 0 1 {name=p9 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 100 410 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/lab_pin.sym} 100 280 0 1 {name=p18 sig_type=std_logic lab=DV}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} -40 -190 2 0 {name=x6 }
C {devices/opin.sym} 350 -20 0 0 {name=p4 lab=I_PTAT}
C {devices/opin.sym} -220 280 0 1 {name=p15 lab=V_CTAT}
C {devices/ipin.sym} -280 -200 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -280 530 0 0 {name=p2 lab=VSS}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -60 120 3 0 {name=x7}
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
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -760 -10 0 0 {name=x1 }
C {JNW_TR_SKY130A/JNWTR_IVX1_CV.sym} -630 -10 0 0 {name=x8 }
C {devices/lab_wire.sym} -590 60 2 1 {name=p7 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -720 60 2 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -720 -80 0 0 {name=p10 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -590 -80 0 0 {name=p11 sig_type=std_logic lab=VDD_1V8}
C {devices/ipin.sym} -820 -10 0 0 {name=p12 lab=PWRUP_1V8}
C {devices/lab_wire.sym} -610 120 0 1 {name=p14 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_wire.sym} -500 -10 0 1 {name=p16 sig_type=std_logic lab=PWRUP_1V8_BUF}
C {devices/lab_wire.sym} -130 60 0 0 {name=p17 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym} -80 -280 0 0 {name=x10 }
C {devices/lab_wire.sym} -140 -280 0 0 {name=p19 sig_type=std_logic lab=PWRUP_N_1V8_BUF}
C {devices/lab_wire.sym} -130 120 0 0 {name=p6 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -90 -360 0 0 {name=p20 sig_type=std_logic lab=VDD_1V8}
