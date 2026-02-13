v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -160 -20 -140 -20 {lab=VDD_1V8}
N -160 -20 -160 -0 {lab=VDD_1V8}
N -160 -0 -140 -0 {lab=VDD_1V8}
N -180 20 -140 20 {lab=VSS}
N 160 -20 210 -20 {lab=I_PTAT}
N 160 -0 210 0 {lab=V_CTAT}
N -180 -20 -160 -20 {lab=VDD_1V8}
C {LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym} 10 0 0 0 {name=x1}
C {devices/ipin.sym} -180 20 0 0 {name=p1 lab=VSS}
C {devices/opin.sym} 210 -20 0 0 {name=p2 lab=I_PTAT}
C {devices/opin.sym} 210 0 0 0 {name=p3 lab=V_CTAT}
C {devices/ipin.sym} -180 -20 0 0 {name=p4 lab=VDD_1V8}
