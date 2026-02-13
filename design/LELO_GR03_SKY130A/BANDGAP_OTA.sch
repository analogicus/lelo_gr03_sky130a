v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -0 -160 -0 -110 {lab=VDD}
N -350 -80 -40 -80 {lab=GATE}
N -0 0 140 0 {lab=TAIL}
N 140 -0 140 30 {lab=TAIL}
N -140 0 -0 -0 {lab=TAIL}
N -140 0 -140 30 {lab=TAIL}
N -140 60 -90 60 {lab=TAIL}
N 90 60 140 60 {lab=TAIL}
N -440 -160 0 -160 {lab=VDD}
N -440 -80 -390 -80 {lab=VDD}
N -440 -140 -440 -80 {lab=VDD}
N -440 -140 -390 -140 {lab=VDD}
N -220 60 -180 60 {lab=IN-}
N 180 60 220 60 {lab=IN+}
N -390 -30 -320 -30 {lab=GATE}
N -320 -80 -320 -30 {lab=GATE}
N -450 300 140 300 {lab=VSS}
N 170 250 170 300 {lab=VSS}
N 140 300 170 300 {lab=VSS}
N 140 280 140 300 {lab=VSS}
N -140 280 -140 300 {lab=VSS}
N -170 250 -170 300 {lab=VSS}
N -390 -160 -390 -110 {lab=VDD}
N 0 -80 50 -80 {lab=VDD}
N 50 -160 50 -80 {lab=VDD}
N 0 -160 50 -160 {lab=VDD}
N 0 -50 0 -0 {lab=TAIL}
N -100 250 -60 250 {lab=VG}
N -60 250 100 250 {lab=VG}
N -170 250 -140 250 {lab=VSS}
N -140 90 -140 220 {lab=VG}
N -140 170 -40 170 {lab=VG}
N -40 170 -40 250 {lab=VG}
N 140 90 140 220 {lab=V}
N 140 250 170 250 {lab=VSS}
N -390 -50 -390 -10 {lab=GATE}
N -410 30 -410 130 {lab=VSS}
N -410 130 -410 300 {lab=VSS}
N -390 70 -390 90 {lab=#net1}
N -390 170 -390 190 {lab=#net2}
N -390 270 -390 300 {lab=VSS}
N 330 -80 370 -80 {lab=GATE}
N 410 -160 410 -110 {lab=VDD}
N 50 -160 410 -160 {lab=VDD}
N 410 -80 460 -80 {lab=VDD}
N 460 -160 460 -80 {lab=VDD}
N 410 -160 460 -160 {lab=VDD}
N -90 0 -90 60 {lab=TAIL}
N 90 0 90 60 {lab=TAIL}
N 410 -50 410 220 {lab=OUT}
N 250 160 250 250 {lab=V}
N 410 280 410 300 {lab=VSS}
N 170 300 410 300 {lab=VSS}
N 410 300 450 300 {lab=VSS}
N 450 250 450 300 {lab=VSS}
N 410 250 450 250 {lab=VSS}
N 410 60 460 60 {lab=OUT}
N 140 160 250 160 {lab=V}
N 250 250 370 250 {lab=V}
C {devices/ipin.sym} -440 -160 0 0 {name=p1 lab=VDD}
C {devices/ipin.sym} -450 300 0 0 {name=p2 lab=VSS}
C {devices/opin.sym} 460 60 0 0 {name=p4 lab=OUT}
C {devices/ipin.sym} 220 60 0 1 {name=p5 lab=IN+}
C {devices/ipin.sym} -220 60 0 0 {name=p6 lab=IN-}
C {devices/lab_wire.sym} 0 -20 0 1 {name=p8 sig_type=std_logic lab=TAIL}
C {devices/lab_wire.sym} -220 -80 0 0 {name=p3 sig_type=std_logic lab=GATE}
C {devices/lab_wire.sym} -40 170 0 1 {name=p10 sig_type=std_logic lab=VG}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} -390 90 1 0 {name=x2 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} -390 -10 1 0 {name=x1 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} -180 60 0 0 {name=x1[3:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 180 60 0 1 {name=x2[3:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} -40 -80 0 0 {name=x5 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} -350 -80 0 1 {name=x3 }
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} -390 190 1 0 {name=x7 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C1F2.sym} 100 250 0 0 {name=x4 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C1F2.sym} -100 250 0 1 {name=x6 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 370 -80 0 0 {name=x8}
C {devices/lab_wire.sym} 330 -80 0 0 {name=p11 sig_type=std_logic lab=GATE}
C {JNW_ATR_SKY130A/JNWATR_NCH_4C1F2.sym} 370 250 0 0 {name=x9[4:0]}
C {devices/lab_wire.sym} 250 160 0 1 {name=p7 sig_type=std_logic lab=V}
