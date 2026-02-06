v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 100 -0 220 0 {lab=OUT}
N 170 0 170 20 {lab=OUT}
N -220 -90 20 -90 {lab=VDD}
N 20 -90 20 -60 {lab=VDD}
N -220 110 170 110 {lab=VSS}
N 170 90 170 110 {lab=VSS}
N -220 -20 -80 -20 {lab=VINP}
N -220 20 -80 20 {lab=VINN}
N 20 60 20 110 {lab=VSS}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} 10 0 0 0 {name=x1}
C {JNW_TR_SKY130A/JNWTR_CAPX1.sym} 170 80 0 0 {name=x2 }
C {devices/ipin.sym} -220 -90 0 0 {name=p1 lab=VDD}
C {devices/ipin.sym} -220 110 0 0 {name=p2 lab=VSS}
C {devices/opin.sym} 220 0 0 0 {name=p3 lab=OUT}
C {devices/ipin.sym} -220 -20 0 0 {name=p4 lab=VINP}
C {devices/ipin.sym} -220 20 0 0 {name=p5 lab=VINN}
