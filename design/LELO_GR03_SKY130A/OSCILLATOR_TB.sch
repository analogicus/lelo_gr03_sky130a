v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 140 -20 170 -20 {lab=F_OUT}
N -190 -20 -160 -20 {lab=VDD_1V8}
N -180 -20 -180 -0 {lab=VDD_1V8}
N -180 0 -160 0 {lab=VDD_1V8}
N -190 20 -160 20 {lab=VSS}
C {LELO_GR03_SKY130A/OSCILLATOR.sym} -10 0 0 0 {name=x1}
C {devices/title.sym} -500 -100 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
C {devices/ipin.sym} -190 -20 0 0 {name=p1 lab=VDD_1V8}
C {devices/opin.sym} 170 -20 0 0 {name=p3 lab=F_OUT}
C {devices/ipin.sym} -190 20 0 0 {name=p2 lab=VSS}
C {devices/capa.sym} 160 10 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 160 40 2 1 {name=p6 sig_type=std_logic lab=VSS}
