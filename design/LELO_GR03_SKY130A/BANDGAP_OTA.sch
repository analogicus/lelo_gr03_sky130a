v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -0 -160 -0 -110 {lab=VDD_1V8}
N -350 -80 -40 -80 {lab=#net1}
N 0 -50 -0 -0 {lab=#net2}
N -0 0 140 0 {lab=#net2}
N 140 -0 140 30 {lab=#net2}
N -140 0 -0 -0 {lab=#net2}
N -140 0 -140 30 {lab=#net2}
N -140 90 -140 140 {lab=#net3}
N 140 90 140 140 {lab=OUT}
N -140 60 -90 60 {lab=#net2}
N -90 0 -90 60 {lab=#net2}
N 90 60 140 60 {lab=#net2}
N 90 0 90 60 {lab=#net2}
N -440 -160 0 -160 {lab=VDD_1V8}
N -440 -80 -390 -80 {lab=VDD_1V8}
N -440 -140 -440 -80 {lab=VDD_1V8}
N -440 -140 -390 -140 {lab=VDD_1V8}
N -140 120 -60 120 {lab=#net3}
N -60 120 -60 170 {lab=#net3}
N 140 120 250 120 {lab=OUT}
N -220 60 -180 60 {lab=IN+}
N 180 60 220 60 {lab=IN-}
N -390 -30 -320 -30 {lab=#net1}
N -320 -80 -320 -30 {lab=#net1}
N -390 -50 -390 -10 {lab=#net1}
N -390 70 -390 90 {lab=#net4}
N -410 30 -410 130 {lab=VSS}
N -410 130 -410 230 {lab=VSS}
N -450 300 140 300 {lab=VSS}
N 170 250 170 300 {lab=VSS}
N 140 300 170 300 {lab=VSS}
N -410 230 -410 300 {lab=VSS}
N -390 170 -390 300 {lab=VSS}
N 140 280 140 300 {lab=VSS}
N -140 280 -140 300 {lab=VSS}
N -100 250 -60 250 {lab=#net3}
N -60 170 -60 250 {lab=#net3}
N 140 250 170 250 {lab=VSS}
N -60 250 100 250 {lab=#net3}
N -170 250 -140 250 {lab=VSS}
N -170 250 -170 300 {lab=VSS}
N 140 170 170 170 {lab=VSS}
N 170 170 170 250 {lab=VSS}
N 140 200 140 220 {lab=#net5}
N -60 170 100 170 {lab=#net3}
N -100 170 -60 170 {lab=#net3}
N -140 200 -140 220 {lab=#net6}
N -170 170 -140 170 {lab=VSS}
N -170 170 -170 250 {lab=VSS}
N -390 -160 -390 -110 {lab=VDD_1V8}
N 0 -80 50 -80 {lab=VDD_1V8}
N 50 -160 50 -80 {lab=VDD_1V8}
N 0 -160 50 -160 {lab=VDD_1V8}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -40 -80 0 0 {name=x8[4:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -350 -80 0 1 {name=x2 }
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -390 70 1 1 {name=x3 }
C {devices/ipin.sym} -440 -160 0 0 {name=p1 lab=VDD}
C {devices/ipin.sym} -450 300 0 0 {name=p2 lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 180 60 0 1 {name=x2[4:0]}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -180 60 0 0 {name=x3[4:0]}
C {devices/opin.sym} 250 120 0 0 {name=p4 lab=OUT}
C {devices/ipin.sym} -220 60 0 0 {name=p5 lab=IN+}
C {devices/ipin.sym} 220 60 0 1 {name=p6 lab=IN-}
C {JNW_TR_SKY130A/JNWTR_RPPO16.sym} -390 170 1 1 {name=x6 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 100 250 0 0 {name=x1 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -100 250 0 1 {name=x4 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} -100 170 0 1 {name=x5 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym} 100 170 0 0 {name=x7 }
