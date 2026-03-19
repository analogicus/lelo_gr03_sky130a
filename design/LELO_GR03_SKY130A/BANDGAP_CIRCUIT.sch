v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -140 -130 60 -130 {lab=VP}
N -280 -200 420 -200 {lab=#net1}
N -60 270 -60 280 {lab=V_CTAT}
N -180 280 -60 280 {lab=V_CTAT}
N -20 270 -20 280 {lab=DV}
N -20 280 100 280 {lab=DV}
N 60 350 80 350 {lab=VSS}
N 100 390 100 430 {lab=VD2}
N -180 280 -180 430 {lab=V_CTAT}
N -180 510 -120 510 {lab=VSS}
N -120 460 -120 510 {lab=VSS}
N -140 460 -120 460 {lab=VSS}
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
N -180 -200 -180 -160 {lab=#net1}
N 100 -200 100 -160 {lab=#net1}
N 350 -200 350 -160 {lab=#net1}
N 350 80 380 80 {lab=I_PTAT}
N -220 230 -180 230 {lab=V_CTAT}
N 40 -130 40 -80 {lab=VP}
N 280 -130 280 -80 {lab=VP}
N -40 -130 -40 -30 {lab=VP}
N -750 -70 -690 -70 {lab=PWRUP_1V8}
N -40 -250 -40 -200 {lab=#net1}
N -140 -280 -80 -280 {lab=PWRUP_N_1V8}
N -40 -360 -40 -310 {lab=VDD_1V8}
N -90 -360 -40 -360 {lab=VDD_1V8}
N 40 60 50 60 {lab=PWRUP_N_1V8}
N -40 -280 -10 -280 {lab=VDD_1V8}
N -10 -330 -10 -280 {lab=VDD_1V8}
N -40 -330 -10 -330 {lab=VDD_1V8}
N -130 60 -120 60 {lab=PWRUP_1V8}
N -750 -30 -690 -30 {lab=PWRUP_N_1V8}
N -750 10 -690 10 {lab=V_IB}
N -130 190 -120 190 {lab=V_IB}
N -620 -130 -580 -130 {lab=VDD_1V8}
N -580 -80 -580 -60 {lab=#net2}
N -580 -100 -580 -80 {lab=#net2}
N -580 -200 -580 -160 {lab=#net1}
N -220 -30 -180 -30 {lab=VDD_1V8}
N -140 -30 -120 -30 {lab=V_CAS}
N -180 0 -180 280 {lab=V_CTAT}
N -180 -100 -180 -60 {lab=#net3}
N 100 -100 100 -60 {lab=#net4}
N 100 0 100 310 {lab=DV}
N 100 -30 140 -30 {lab=VDD_1V8}
N 40 -30 60 -30 {lab=V_CAS}
N 350 -30 390 -30 {lab=VDD_1V8}
N 350 -100 350 -60 {lab=#net5}
N 290 -30 310 -30 {lab=V_CAS}
N -580 -60 -580 -10 {lab=#net2}
N -580 -10 -580 150 {lab=#net2}
N -180 510 -120 510 {lab=VSS}
N -120 460 -120 510 {lab=VSS}
N -140 460 -120 460 {lab=VSS}
N -580 210 -580 240 {lab=VSS}
N -620 180 -580 180 {lab=VSS}
N -540 180 -520 180 {lab=#net2}
N -520 180 -450 180 {lab=#net2}
N -410 180 -380 180 {lab=VSS}
N -410 210 -410 240 {lab=VSS}
N -540 -130 -520 -130 {lab=VP}
N -470 -130 -450 -130 {lab=V_CAS}
N -470 -130 -470 -90 {lab=V_CAS}
N -470 -90 -410 -90 {lab=V_CAS}
N -410 -100 -410 150 {lab=V_CAS}
N -410 -200 -410 -160 {lab=#net1}
N -580 110 -500 110 {lab=#net2}
N -500 110 -500 180 {lab=#net2}
N -600 -200 -280 -200 {lab=#net1}
N -410 -130 -380 -130 {lab=VDD_1V8}
N -180 490 -180 530 {lab=VSS}
N 100 490 100 530 {lab=VSS}
N 40 -80 280 -80 {lab=VP}
N -400 530 290 530 {lab=VSS}
N 270 440 270 530 {lab=VSS}
N 270 280 270 360 {lab=DV}
N 100 280 270 280 {lab=DV}
N 290 400 310 400 {lab=VSS}
N -340 440 -340 530 {lab=VSS}
N -340 280 -340 360 {lab=V_CTAT}
N -380 400 -360 400 {lab=VSS}
N -340 280 -180 280 {lab=V_CTAT}
C {devices/lab_pin.sym} 60 350 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -130 120 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 100 410 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/lab_pin.sym} 100 240 0 1 {name=p18 sig_type=std_logic lab=DV}
C {JNW_TR_SKY130A/JNWTR_CAPX4.sym} -40 -190 2 0 {name=x6 }
C {devices/opin.sym} 380 80 0 0 {name=p4 lab=I_PTAT}
C {devices/opin.sym} -220 230 0 1 {name=p15 lab=V_CTAT}
C {devices/ipin.sym} -90 -360 0 0 {name=p1 lab=VDD_1V8}
C {devices/ipin.sym} -400 530 0 0 {name=p2 lab=VSS}
C {devices/lab_wire.sym} 20 -130 0 0 {name=p3 sig_type=std_logic lab=VP}
C {sky130_fd_pr/pnp_05v5.sym} 80 460 0 0 {name=Q2[7:0]
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {devices/ipin.sym} -750 -70 0 0 {name=p12 lab=PWRUP_1V8}
C {devices/lab_wire.sym} 50 60 0 1 {name=p17 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} -140 -280 0 0 {name=p19 sig_type=std_logic lab=PWRUP_N_1V8}
C {devices/lab_wire.sym} 50 120 0 1 {name=p6 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -220 -130 0 0 {name=p21 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 140 -130 0 1 {name=p22 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 380 -130 0 1 {name=p23 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 60 -130 0 0 {name=x20}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -140 -130 0 1 {name=x2}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 310 -130 0 0 {name=x4[1:0]}
C {devices/lab_wire.sym} -130 60 0 0 {name=p20 sig_type=std_logic lab=PWRUP_1V8}
C {devices/ipin.sym} -750 -30 0 0 {name=p7 lab=PWRUP_N_1V8}
C {devices/title.sym} -670 -410 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -750 10 0 0 {name=p8 lab=V_IB}
C {devices/lab_wire.sym} -130 190 0 0 {name=p10 sig_type=std_logic lab=V_IB}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 100 310 1 0 {name=x1 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -540 -130 0 1 {name=x5}
C {devices/lab_wire.sym} -620 -130 0 0 {name=p14 sig_type=std_logic lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -140 -30 0 1 {name=x9}
C {devices/lab_wire.sym} -220 -30 0 0 {name=p27 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -120 -30 0 1 {name=p28 sig_type=std_logic lab=V_CAS}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -20 120 1 1 {name=x11}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 60 -30 0 0 {name=x12}
C {devices/lab_wire.sym} 140 -30 0 1 {name=p31 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 40 -30 0 0 {name=p32 sig_type=std_logic lab=V_CAS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 310 -30 0 0 {name=x14}
C {devices/lab_wire.sym} 390 -30 0 1 {name=p34 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} 290 -30 0 0 {name=p36 sig_type=std_logic lab=V_CAS}
C {sky130_fd_pr/pnp_05v5.sym} -160 460 0 1 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -540 180 0 1 {name=x7}
C {devices/lab_wire.sym} -580 240 2 1 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -620 180 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -450 180 0 0 {name=x8}
C {devices/lab_wire.sym} -380 180 2 0 {name=p29 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -410 240 2 1 {name=p30 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -450 -130 0 0 {name=x10}
C {devices/lab_wire.sym} -470 -90 3 0 {name=p33 sig_type=std_logic lab=V_CAS}
C {devices/lab_wire.sym} -380 -130 0 1 {name=p35 sig_type=std_logic lab=VDD_1V8}
C {devices/lab_wire.sym} -520 -130 1 1 {name=p24 sig_type=std_logic lab=VP}
C {JNW_ATR_SKY130A/JNWATR_PCH_8C1F2.sym} -80 -280 0 0 {name=x3 }
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} 270 440 3 0 {name=x4 }
C {devices/lab_pin.sym} 310 400 0 1 {name=p11 sig_type=std_logic lab=VSS}
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} -340 440 1 1 {name=x13 }
C {devices/lab_pin.sym} -380 400 0 0 {name=p26 sig_type=std_logic lab=VSS}
