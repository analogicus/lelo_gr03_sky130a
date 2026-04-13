v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Startup circuit} 600 -230 0 0 0.4 0.4 {}
N -140 -130 60 -130 {lab=VP}
N -60 270 -60 280 {lab=#net1}
N -180 280 -60 280 {lab=#net1}
N -20 270 -20 280 {lab=DV}
N 100 390 100 430 {lab=VD2}
N -180 280 -180 430 {lab=#net1}
N 40 510 100 510 {lab=VSS}
N 40 460 40 510 {lab=VSS}
N 40 460 60 460 {lab=VSS}
N 350 -130 380 -130 {lab=VDD_1V8}
N 280 -130 310 -130 {lab=VP}
N 350 0 350 80 {lab=I_PTAT}
N -130 120 -120 120 {lab=VSS}
N 40 120 50 120 {lab=VDD_1V8}
N 100 -130 140 -130 {lab=VDD_1V8}
N -220 -130 -180 -130 {lab=VDD_1V8}
N -180 -200 -180 -160 {lab=SUPPLY}
N 100 -200 100 -160 {lab=SUPPLY}
N 350 -200 350 -160 {lab=SUPPLY}
N 350 80 380 80 {lab=I_PTAT}
N 100 90 140 90 {lab=V_CTAT}
N 40 -130 40 -80 {lab=VP}
N 280 -130 280 -80 {lab=VP}
N -40 -130 -40 -30 {lab=VP}
N -330 60 -270 60 {lab=PWRUP_1V8}
N -40 -250 -40 -200 {lab=SUPPLY}
N -140 -280 -80 -280 {lab=PWRUP_N_1V8}
N -40 -360 -40 -310 {lab=VDD_1V8}
N -90 -360 -40 -360 {lab=VDD_1V8}
N 40 60 50 60 {lab=PWRUP_N_1V8}
N -40 -280 -10 -280 {lab=VDD_1V8}
N -10 -330 -10 -280 {lab=VDD_1V8}
N -40 -330 -10 -330 {lab=VDD_1V8}
N -130 60 -120 60 {lab=PWRUP_1V8}
N -330 100 -270 100 {lab=PWRUP_N_1V8}
N -330 140 -270 140 {lab=VB_P}
N -130 190 -120 190 {lab=VB_P}
N -220 -30 -180 -30 {lab=VDD_1V8}
N -140 -30 -120 -30 {lab=VP}
N -180 -100 -180 -60 {lab=#net2}
N 100 -100 100 -60 {lab=#net3}
N 100 -30 140 -30 {lab=VDD_1V8}
N 40 -30 60 -30 {lab=VP}
N 350 -30 390 -30 {lab=VDD_1V8}
N 350 -100 350 -60 {lab=#net4}
N 290 -30 310 -30 {lab=VP}
N -180 510 -120 510 {lab=VSS}
N -120 460 -120 510 {lab=VSS}
N -140 460 -120 460 {lab=VSS}
N -180 490 -180 530 {lab=VSS}
N 100 490 100 530 {lab=VSS}
N 40 -80 280 -80 {lab=VP}
N -400 530 290 530 {lab=VSS}
N 760 -200 760 -160 {lab=SUPPLY}
N 600 -200 600 -160 {lab=SUPPLY}
N 580 -130 600 -130 {lab=VDD_1V8}
N 760 -130 780 -130 {lab=VDD_1V8}
N 760 80 780 80 {lab=VSS}
N 640 -130 720 -130 {lab=VSTART}
N 690 -130 690 -80 {lab=VSTART}
N 690 -80 760 -80 {lab=VSTART}
N 700 180 720 180 {lab=#net5}
N 760 180 780 180 {lab=VSS}
N 700 130 700 180 {lab=#net5}
N 760 110 760 150 {lab=#net5}
N 700 130 760 130 {lab=#net5}
N 760 210 760 240 {lab=VSS}
N 640 180 660 180 {lab=VP}
N 580 180 600 180 {lab=VSS}
N 660 130 660 180 {lab=VP}
N 600 130 660 130 {lab=VP}
N 600 210 600 240 {lab=VSS}
N 600 -100 600 150 {lab=VP}
N 600 80 720 80 {lab=VP}
N 760 -100 760 50 {lab=VSTART}
N 570 80 600 80 {lab=VP}
N -20 280 100 280 {lab=DV}
N -140 -280 -80 -280 {lab=PWRUP_N_1V8}
N 60 350 80 350 {lab=VSS}
N -180 0 -180 110 {lab=#net6}
N 100 -0 100 80 {lab=V_CTAT}
N 100 80 100 100 {lab=V_CTAT}
N 100 100 100 150 {lab=V_CTAT}
N 100 230 100 310 {lab=DV}
N -180 110 -180 150 {lab=#net6}
N -180 230 -180 280 {lab=#net1}
N -400 -200 820 -200 {lab=SUPPLY}
N -220 190 -200 190 {lab=VSS}
N 120 190 140 190 {lab=VSS}
C {devices/lab_wire.sym} -130 120 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 100 410 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/lab_pin.sym} 100 280 0 1 {name=p18 sig_type=std_logic lab=DV}
C {devices/opin.sym} 380 80 0 0 {name=p4 lab=I_PTAT}
C {devices/opin.sym} 140 90 0 0 {name=p15 lab=V_CTAT}
C {devices/ipin.sym} -90 -360 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -400 530 0 0 {name=p2 lab=VSS}
C {devices/lab_wire.sym} 20 -130 0 0 {name=p3 sig_type=std_logic lab=VP}
C {sky130_fd_pr/pnp_05v5.sym} 80 460 0 0 {name=Q2[47:0]
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {devices/ipin.sym} -330 60 0 0 {name=p12 lab=PWRUP_1V8}
C {devices/lab_wire.sym} 50 60 0 1 {name=p17 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} 50 120 0 1 {name=p6 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -220 -130 0 0 {name=p21 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 140 -130 0 1 {name=p22 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 380 -130 0 1 {name=p23 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -130 60 0 0 {name=p20 sig_type=std_logic lab=PWRUP_1V8}
C {devices/ipin.sym} -330 100 0 0 {name=p7 lab=PWRUP_N_1V8}
C {devices/title.sym} -280 -420 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -330 140 0 0 {name=p8 lab=VB_P}
C {devices/lab_wire.sym} -220 -30 0 0 {name=p27 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -120 -30 0 1 {name=p28 sig_type=std_logic lab=VP}
C {devices/lab_wire.sym} 140 -30 0 1 {name=p31 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 40 -30 0 0 {name=p32 sig_type=std_logic lab=VP}
C {devices/lab_wire.sym} 390 -30 0 1 {name=p34 sig_type=std_logic lab=VDD_1V8}
C {sky130_fd_pr/pnp_05v5.sym} -160 460 0 1 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 720 80 0 0 {name=x16}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 640 -130 0 1 {name=x18}
C {devices/lab_wire.sym} 580 -130 0 0 {name=p40 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 780 -130 0 1 {name=p42 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 780 80 2 0 {name=p43 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 720 -130 0 0 {name=x4}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 720 180 0 0 {name=x13}
C {devices/lab_wire.sym} 780 180 2 0 {name=p11 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 760 240 2 1 {name=p26 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 640 180 0 1 {name=x15}
C {devices/lab_wire.sym} 580 180 2 1 {name=p37 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 600 240 2 1 {name=p38 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 570 80 0 0 {name=p39 sig_type=std_logic lab=VP}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} -40 -140 0 0 {name=x6 }
C {devices/lab_wire.sym} 290 -30 0 0 {name=p46 sig_type=std_logic lab=VP}
C {devices/lab_wire.sym} -140 -280 0 0 {name=p45 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} 700 -130 0 0 {name=p51 sig_type=std_logic lab=VSTART}
C {LELO_GR03_SKY130A/BANDGAP_OTA_PMOS.sym} -20 120 1 1 {name=x21}
C {JNW_ATR_SKY130A/JNWATR_PCH_2C5F0.sym} 60 -130 0 0 {name=x11}
C {devices/lab_pin.sym} 60 350 2 1 {name=p36 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_2C5F0.sym} -140 -130 0 1 {name=x9}
C {JNW_ATR_SKY130A/JNWATR_PCH_2C5F0.sym} 310 -130 0 0 {name=x14 }
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -80 -280 0 0 {name=x3[2:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_2C5F0.sym} 60 -30 0 0 {name=x3}
C {JNW_ATR_SKY130A/JNWATR_PCH_2C5F0.sym} -140 -30 0 1 {name=x10}
C {JNW_ATR_SKY130A/JNWATR_PCH_2C5F0.sym} 310 -30 0 0 {name=x17}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 100 310 1 0 {name=x1 }
C {devices/lab_wire.sym} 170 -200 0 0 {name=p19 sig_type=std_logic lab=SUPPLY}
C {devices/lab_wire.sym} -130 190 0 0 {name=p5 sig_type=std_logic lab=VB_P}
C {devices/lab_pin.sym} -220 190 2 1 {name=p10 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 140 190 2 0 {name=p14 sig_type=std_logic lab=VSS}
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} 100 230 3 0 {name=x2 }
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} -180 150 1 0 {name=x5 }
