v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
<<<<<<< Updated upstream
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
=======
T {Startup circuit} 1100 -230 0 0 0.4 0.4 {}
T {Bias circuit} 730 -230 0 0 0.4 0.4 {}
N -140 -130 60 -130 {lab=VP}
N -60 270 -60 280 {lab=VD1}
N -180 280 -60 280 {lab=VD1}
N -20 270 -20 280 {lab=#net1}
N 100 390 100 430 {lab=VD2}
N -180 280 -180 430 {lab=VD1}
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
N -180 -200 -180 -160 {lab=#net2}
N 100 -200 100 -160 {lab=#net2}
N 350 -200 350 -160 {lab=#net2}
N 350 80 380 80 {lab=I_PTAT}
N 40 -130 40 -80 {lab=VP}
N 280 -130 280 -80 {lab=VP}
N -40 -130 -40 -30 {lab=VP}
N -330 60 -270 60 {lab=PWRUP_1V8}
N -40 -250 -40 -200 {lab=#net2}
>>>>>>> Stashed changes
N -140 -280 -80 -280 {lab=PWRUP_N_1V8}
N -40 -360 -40 -310 {lab=VDD_1V8}
N -90 -360 -40 -360 {lab=VDD_1V8}
N 40 60 50 60 {lab=PWRUP_N_1V8}
N -40 -280 -10 -280 {lab=VDD_1V8}
N -10 -330 -10 -280 {lab=VDD_1V8}
N -40 -330 -10 -330 {lab=VDD_1V8}
N -130 60 -120 60 {lab=PWRUP_1V8}
<<<<<<< Updated upstream
N -460 -30 -400 -30 {lab=PWRUP_N_1V8}
C {devices/lab_pin.sym} 60 350 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -130 120 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 100 410 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/lab_pin.sym} 100 280 0 1 {name=p18 sig_type=std_logic lab=DV}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} -40 -190 2 0 {name=x6 }
C {devices/opin.sym} 350 -20 0 0 {name=p4 lab=I_PTAT}
C {devices/opin.sym} -220 280 0 1 {name=p15 lab=V_CTAT}
=======
N -330 100 -270 100 {lab=PWRUP_N_1V8}
N -330 140 -270 140 {lab=V_IB}
N -130 190 -120 190 {lab=V_IB}
N 730 -80 730 -60 {lab=#net3}
N 730 -100 730 -80 {lab=#net3}
N 730 -200 730 -160 {lab=#net2}
N -220 -30 -180 -30 {lab=VDD_1V8}
N -140 -30 -120 -30 {lab=V_CAS}
N -180 -100 -180 -60 {lab=#net4}
N 100 -100 100 -60 {lab=#net5}
N 100 -30 140 -30 {lab=VDD_1V8}
N 40 -30 60 -30 {lab=V_CAS}
N 350 -30 390 -30 {lab=VDD_1V8}
N 350 -100 350 -60 {lab=#net6}
N 290 -30 310 -30 {lab=V_CAS}
N 730 -60 730 -10 {lab=#net3}
N 730 -10 730 150 {lab=#net3}
N -180 510 -120 510 {lab=VSS}
N -120 460 -120 510 {lab=VSS}
N -140 460 -120 460 {lab=VSS}
N 730 210 730 240 {lab=VSS}
N 770 180 790 180 {lab=#net3}
N 790 180 860 180 {lab=#net3}
N 900 210 900 240 {lab=VSS}
N 770 -130 790 -130 {lab=VP}
N 840 -130 860 -130 {lab=V_CAS}
N 840 -130 840 -90 {lab=V_CAS}
N 840 -90 900 -90 {lab=V_CAS}
N 900 -100 900 150 {lab=V_CAS}
N 900 -200 900 -160 {lab=#net2}
N 730 110 810 110 {lab=#net3}
N 810 110 810 180 {lab=#net3}
N -180 490 -180 530 {lab=VSS}
N 100 490 100 530 {lab=VSS}
N 40 -80 280 -80 {lab=VP}
N -400 530 290 530 {lab=VSS}
N 1260 -200 1260 -160 {lab=#net2}
N -400 -200 1150 -200 {lab=#net2}
N 1100 -200 1100 -160 {lab=#net2}
N 1150 -200 1260 -200 {lab=#net2}
N 900 -130 920 -130 {lab=VDD_1V8}
N 1080 -130 1100 -130 {lab=VDD_1V8}
N 1260 -130 1280 -130 {lab=VDD_1V8}
N 710 -130 730 -130 {lab=VDD_1V8}
N 900 180 920 180 {lab=VSS}
N 710 180 730 180 {lab=VSS}
N 1260 80 1280 80 {lab=VSS}
N 1140 -130 1220 -130 {lab=VSTART}
N 1190 -130 1190 -80 {lab=VSTART}
N 1190 -80 1260 -80 {lab=VSTART}
N 1200 180 1220 180 {lab=#net7}
N 1260 180 1280 180 {lab=VSS}
N 1200 130 1200 180 {lab=#net7}
N 1260 110 1260 150 {lab=#net7}
N 1200 130 1260 130 {lab=#net7}
N 1260 210 1260 240 {lab=VSS}
N 1140 180 1160 180 {lab=VP}
N 1080 180 1100 180 {lab=VSS}
N 1160 130 1160 180 {lab=VP}
N 1100 130 1160 130 {lab=VP}
N 1100 210 1100 240 {lab=VSS}
N 1100 -100 1100 150 {lab=VP}
N 1100 80 1220 80 {lab=VP}
N 1260 -100 1260 50 {lab=VSTART}
N 1070 80 1100 80 {lab=VP}
N -20 280 100 280 {lab=#net1}
N 60 350 80 350 {lab=VSS}
N -140 -280 -80 -280 {lab=PWRUP_N_1V8}
N 540 40 570 40 {lab=V_CTAT}
N 290 530 560 530 {lab=VSS}
N 100 250 100 310 {lab=#net1}
N -180 0 -180 170 {lab=VD1}
N -180 250 -180 280 {lab=VD1}
N 100 280 180 280 {lab=#net1}
N 180 280 180 310 {lab=#net1}
N 100 390 180 390 {lab=VD2}
N 200 350 220 350 {lab=VSS}
N 540 -130 570 -130 {lab=VDD_1V8}
N 470 -130 500 -130 {lab=VP}
N 540 0 540 80 {lab=V_CTAT}
N 540 -200 540 -160 {lab=#net2}
N 470 -130 470 -80 {lab=VP}
N 540 -30 580 -30 {lab=VDD_1V8}
N 540 -100 540 -60 {lab=#net8}
N 480 -30 500 -30 {lab=V_CAS}
N 280 -80 470 -80 {lab=VP}
N 560 120 580 120 {lab=VSS}
N 480 510 540 510 {lab=VSS}
N 480 460 480 510 {lab=VSS}
N 480 460 500 460 {lab=VSS}
N 540 490 540 530 {lab=VSS}
N 100 -0 100 250 {lab=#net1}
N -180 170 -180 250 {lab=VD1}
N 540 160 540 200 {lab=#net9}
N 540 280 540 430 {lab=#net10}
N 560 240 580 240 {lab=VSS}
C {devices/lab_wire.sym} -130 120 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 100 410 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/opin.sym} 380 80 0 0 {name=p4 lab=I_PTAT}
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -140 -130 0 1 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 280 -130 0 0 {name=x3}
C {devices/lab_wire.sym} -130 60 0 0 {name=p20 sig_type=std_logic lab=PWRUP_1V8}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 100 310 1 0 {name=x4 }
C {devices/ipin.sym} -460 -30 0 0 {name=p7 lab=PWRUP_N_1V8}
C {devices/title.sym} -520 -430 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
=======
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -140 -130 0 1 {name=x9}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 310 -130 0 0 {name=x17[1:0]}
C {devices/lab_wire.sym} -130 60 0 0 {name=p20 sig_type=std_logic lab=PWRUP_1V8}
C {devices/ipin.sym} -330 100 0 0 {name=p7 lab=PWRUP_N_1V8}
C {devices/title.sym} -310 -420 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -330 140 0 0 {name=p8 lab=V_IB}
C {devices/lab_wire.sym} -130 190 0 0 {name=p10 sig_type=std_logic lab=V_IB}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 770 -130 0 1 {name=x5}
C {devices/lab_wire.sym} 710 -130 0 0 {name=p14 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -220 -30 0 0 {name=p27 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -120 -30 0 1 {name=p28 sig_type=std_logic lab=V_CAS}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -20 120 1 1 {name=x11}
C {devices/lab_wire.sym} 140 -30 0 1 {name=p31 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 40 -30 0 0 {name=p32 sig_type=std_logic lab=V_CAS}
C {devices/lab_wire.sym} 390 -30 0 1 {name=p34 sig_type=std_logic lab=VDD_1V8}
C {sky130_fd_pr/pnp_05v5.sym} -160 460 0 1 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 770 180 0 1 {name=x7}
C {devices/lab_wire.sym} 730 240 2 1 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 710 180 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 860 180 0 0 {name=x8}
C {devices/lab_wire.sym} 920 180 2 0 {name=p29 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 900 240 2 1 {name=p30 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 860 -130 0 0 {name=x10}
C {devices/lab_wire.sym} 840 -90 3 0 {name=p33 sig_type=std_logic lab=V_CAS}
C {devices/lab_wire.sym} 920 -130 0 1 {name=p35 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 790 -130 1 1 {name=p24 sig_type=std_logic lab=VP}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -80 -280 0 0 {name=x3[2:0]}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 1220 80 0 0 {name=x16}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 1140 -130 0 1 {name=x18}
C {devices/lab_wire.sym} 1080 -130 0 0 {name=p40 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 1280 -130 0 1 {name=p42 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 1280 80 2 0 {name=p43 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 1220 -130 0 0 {name=x4}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 1220 180 0 0 {name=x13}
C {devices/lab_wire.sym} 1280 180 2 0 {name=p11 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1260 240 2 1 {name=p26 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 1140 180 0 1 {name=x15}
C {devices/lab_wire.sym} 1080 180 2 1 {name=p37 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1100 240 2 1 {name=p38 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1070 80 0 0 {name=p39 sig_type=std_logic lab=VP}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} -40 -140 0 0 {name=x6[2:0]}
C {devices/lab_wire.sym} 290 -30 0 0 {name=p46 sig_type=std_logic lab=V_CAS}
C {devices/lab_pin.sym} 60 350 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 100 310 1 0 {name=x1 }
C {devices/lab_wire.sym} -140 -280 0 0 {name=p45 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} 1200 -130 0 0 {name=p51 sig_type=std_logic lab=VSTART}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -140 -30 0 1 {name=x12}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 60 -30 0 0 {name=x14}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 310 -30 0 0 {name=x19}
C {devices/opin.sym} 570 40 0 0 {name=p52 lab=V_CTAT}
C {devices/lab_pin.sym} 220 350 2 0 {name=p15 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 570 -130 0 1 {name=p36 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 500 -130 0 0 {name=x6}
C {devices/lab_wire.sym} 580 -30 0 1 {name=p44 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 480 -30 0 0 {name=p47 sig_type=std_logic lab=V_CAS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 500 -30 0 0 {name=x23}
C {devices/lab_pin.sym} 580 120 2 0 {name=p18 sig_type=std_logic lab=VSS}
C {sky130_fd_pr/pnp_05v5.sym} 520 460 0 0 {name=Q1
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {devices/lab_pin.sym} -180 280 0 0 {name=p41 sig_type=std_logic lab=VD1}
C {JNW_TR_SKY130A/JNWTR_RPPO8.sym} 180 390 3 0 {name=x2 }
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} 540 160 3 0 {name=x3 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 540 280 3 0 {name=x21 }
C {devices/lab_pin.sym} 580 240 2 0 {name=p19 sig_type=std_logic lab=VSS}
>>>>>>> Stashed changes
