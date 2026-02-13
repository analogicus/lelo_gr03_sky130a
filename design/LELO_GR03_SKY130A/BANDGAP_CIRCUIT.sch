v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -940 -670 -140 -270 {flags=graph
y1=-0.38448743
y2=3.4375722
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-3.4288409e-06
x2=8.8601179e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vd2
vd1"
color="4 4"
dataset=-1
unitx=1
logx=0
logy=0
sim_type=ac}
P 4 1 210 50 {}
P 4 1 180 60 {}
P 4 1 205 70 {}
N -0 -130 -0 -90 {lab=VG}
N -20 90 -20 110 {lab=VD1}
N -130 110 -20 110 {lab=VD1}
N -130 -190 -130 -160 {lab=VDD}
N -160 -130 -130 -130 {lab=VDD}
N -160 -190 -160 -130 {lab=VDD}
N 20 90 20 110 {lab=DV}
N -90 -130 90 -130 {lab=VG}
N 130 -190 130 -160 {lab=VDD}
N 130 -130 160 -130 {lab=VDD}
N 160 -190 160 -130 {lab=VDD}
N 130 -100 130 140 {lab=DV}
N 20 110 130 110 {lab=DV}
N 130 220 130 250 {lab=VD2}
N 130 310 130 370 {lab=0}
N -330 370 130 370 {lab=0}
N 60 280 90 280 {lab=0}
N 60 280 60 340 {lab=0}
N 60 340 130 340 {lab=0}
N 350 -130 380 -130 {lab=VDD}
N 380 -190 380 -130 {lab=VDD}
N 350 -190 350 -160 {lab=VDD}
N -330 -190 380 -190 {lab=VDD}
N -70 -10 -60 -10 {lab=VDD}
N 60 -10 70 -10 {lab=0}
N 90 180 110 180 {lab=0}
N 280 -130 310 -130 {lab=VG}
N -130 -100 -130 250 {lab=VD1}
N -130 310 -130 370 {lab=0}
N -90 280 -60 280 {lab=0}
N -60 280 -60 340 {lab=0}
N -130 340 -60 340 {lab=0}
N -330 -30 -330 10 {lab=0}
N 350 -100 350 -20 {lab=VR}
N 350 40 350 80 {lab=0}
N -330 -190 -330 -90 {lab=VDD}
N 660 -190 660 -160 {lab=VDD}
N 380 -190 590 -190 {lab=VDD}
N 660 -130 700 -130 {lab=VDD}
N 700 -190 700 -130 {lab=VDD}
N 590 -190 630 -190 {lab=VDD}
N 600 -130 620 -130 {lab=#net1}
N 600 -130 600 -80 {lab=#net1}
N 600 -80 660 -80 {lab=#net1}
N 660 210 660 240 {lab=#net2}
N 600 230 660 230 {lab=#net2}
N 600 230 600 270 {lab=#net2}
N 600 270 620 270 {lab=#net2}
N 660 300 660 370 {lab=0}
N 570 180 620 180 {lab=VG}
N 630 -190 700 -190 {lab=VDD}
N 510 -190 510 -160 {lab=VDD}
N 470 -130 510 -130 {lab=VDD}
N 470 -190 470 -130 {lab=VDD}
N 550 -130 600 -130 {lab=#net1}
N 510 -100 510 20 {lab=VG}
N 510 80 510 150 {lab=0}
N 460 50 510 50 {lab=0}
N 460 50 460 110 {lab=0}
N 460 110 510 110 {lab=0}
N 660 270 710 270 {lab=0}
N 710 270 710 320 {lab=0}
N 660 320 710 320 {lab=0}
N 660 180 750 180 {lab=0}
N 750 180 750 320 {lab=0}
N 710 320 750 320 {lab=0}
N 550 50 580 50 {lab=VG}
N 580 -0 580 50 {lab=VG}
N 510 0 580 0 {lab=VG}
N 660 -100 660 150 {lab=#net1}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} 0 0 3 0 {name=xOTA}
C {sky130_fd_pr/pnp_05v5.sym} 110 280 0 0 {name=xQ1
model=pnp_05v5_W3p40L3p40
m=8
spiceprefix=X
}
C {devices/lab_pin.sym} 70 -10 0 1 {name=p3 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 90 180 0 0 {name=p5 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} 280 -130 0 0 {name=p8 sig_type=std_logic lab=VG}
C {devices/lab_wire.sym} 40 -130 0 0 {name=p6 sig_type=std_logic lab=VG}
C {sky130_fd_pr/pnp_05v5.sym} -110 280 0 1 {name=xQ2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {devices/code_shown.sym} -950 -190 0 0 {name=s1 only_toplevel=false value="
.param mc_mm_switch=0
.param mc_pr_switch=0

.lib "../../../tech/ngspice/temperature.spi" Tl
.lib "../../../tech/ngspice/corners.spi" Kss
.lib "../../../tech/ngspice/supply.spi" Vl
.include ../../../../cpdk/ngspice/ideal_circuits.spi
.option savecurrents
.option gmin=1e-12
.option SEED=1
.save all
.control
optran 0 0 0 10n 1u 0
tran 10n 10u
*op
*ac dec 20 1 1G

write BANDGAP_CIRCUIT_TB.raw

*exit
.endc

"}
C {devices/vsource.sym} -330 -60 0 0 {name=VDD value=1.8 savecurrent=false}
C {devices/lab_pin.sym} -330 10 0 0 {name=p9 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -330 -130 0 0 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 130 90 0 1 {name=p11 sig_type=std_logic lab=DV}
C {devices/lab_pin.sym} -130 230 0 0 {name=p12 sig_type=std_logic lab=VD1}
C {devices/lab_pin.sym} 130 230 0 1 {name=p13 sig_type=std_logic lab=VD2}
C {devices/lab_wire.sym} -330 370 0 0 {name=p14 sig_type=std_logic lab=0}
C {devices/launcher.sym} -40 -310 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/BANDGAP_CIRCUIT.raw tran"
}
C {devices/res.sym} 350 10 0 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 350 80 0 1 {name=p4 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 350 -40 0 1 {name=p7 sig_type=std_logic lab=VR}
C {devices/lab_pin.sym} -70 -10 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {JNW_TR_SKY130A/JNWTR_RPPO4.sym} 130 140 1 0 {name=x2 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 90 -130 0 0 {name=x5 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} -90 -130 0 1 {name=x1 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 310 -130 0 0 {name=x3 }
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 620 -130 0 0 {name=x4 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C1F2.sym} 620 180 0 0 {name=x6 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C1F2.sym} 620 270 0 0 {name=x7 }
C {devices/lab_wire.sym} 570 180 0 0 {name=p15 sig_type=std_logic lab=VG}
C {JNW_ATR_SKY130A/JNWATR_PCH_4C1F2.sym} 550 -130 0 1 {name=x8 }
C {JNW_ATR_SKY130A/JNWATR_NCH_4C1F2.sym} 550 50 0 1 {name=x9 }
C {devices/lab_wire.sym} 510 -30 0 0 {name=p16 sig_type=std_logic lab=VG}
C {devices/lab_wire.sym} 660 370 0 0 {name=p17 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} 510 150 0 0 {name=p19 sig_type=std_logic lab=0}
