v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
P 4 1 210 50 {}
P 4 1 180 60 {}
P 4 1 205 70 {}
N -0 -130 -0 -90 {lab=VG}
N -20 90 -20 110 {lab=#net1}
N -130 110 -20 110 {lab=#net1}
N -130 -190 -130 -160 {lab=VDD}
N -160 -130 -130 -130 {lab=VDD}
N -160 -190 -160 -130 {lab=VDD}
N 20 90 20 110 {lab=#net2}
N -90 -130 90 -130 {lab=VG}
N 130 -190 130 -160 {lab=VDD}
N 130 -130 160 -130 {lab=VDD}
N 160 -190 160 -130 {lab=VDD}
N 130 -100 130 140 {lab=#net2}
N 20 110 130 110 {lab=#net2}
N 130 220 130 250 {lab=#net3}
N 130 310 130 370 {lab=VSS}
N -330 370 130 370 {lab=VSS}
N 60 280 90 280 {lab=VSS}
N 60 280 60 340 {lab=VSS}
N 60 340 130 340 {lab=VSS}
N 350 -130 380 -130 {lab=VDD}
N 380 -190 380 -130 {lab=VDD}
N 350 -190 350 -160 {lab=VDD}
N -330 -190 380 -190 {lab=VDD}
N -70 -10 -60 -10 {lab=VDD}
N 60 -10 70 -10 {lab=VSS}
N 90 180 110 180 {lab=VSS}
N 280 -130 310 -130 {lab=VG}
N 350 -100 350 50 {lab=OUT}
N 350 50 440 50 {lab=OUT}
N -130 -100 -130 250 {lab=#net1}
N -130 310 -130 370 {lab=VSS}
N -90 280 -60 280 {lab=VSS}
N -60 280 -60 340 {lab=VSS}
N -130 340 -60 340 {lab=VSS}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} 0 0 3 0 {name=OTA}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} -90 -130 0 1 {name=x1}
C {devices/ipin.sym} -330 -190 0 0 {name=p1 lab=VDD}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 90 -130 0 0 {name=x3}
C {JNW_TR_SKY130A/JNWTR_RPPO2.sym} 130 140 1 0 {name=x2 }
C {sky130_fd_pr/pnp_05v5.sym} 110 280 0 0 {name=Q1
model=pnp_05v5_W3p40L3p40
m=8
spiceprefix=X
}
C {devices/ipin.sym} -330 370 0 0 {name=p4 lab=VSS}
C {devices/lab_pin.sym} -70 -10 0 0 {name=p2 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 70 -10 0 1 {name=p3 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 90 180 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym} 310 -130 0 0 {name=x4}
C {devices/lab_wire.sym} 280 -130 0 0 {name=p8 sig_type=std_logic lab=VG}
C {devices/lab_wire.sym} 40 -130 0 0 {name=p6 sig_type=std_logic lab=VG}
C {sky130_fd_pr/pnp_05v5.sym} -110 280 0 1 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {devices/opin.sym} 440 50 0 0 {name=p7 lab=OUT}
