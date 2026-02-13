v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -930 -550 -130 -150 {flags=graph
y1=-0.3250676
y2=2.0743273
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.2162449e-08
x2=4.081787e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="4 7"
node="in+
out"
hilight_wave=0}
N -60 300 -60 320 {lab=GND}
N -210 270 -210 320 {lab=GND}
N -60 210 -60 240 {lab=OUT}
N -380 230 -380 240 {lab=IN-}
N -380 230 -310 230 {lab=IN-}
N -380 300 -380 320 {lab=GND}
N -210 130 -210 150 {lab=#net1}
N -520 190 -520 220 {lab=IN+}
N -520 190 -310 190 {lab=IN+}
N -590 130 -590 200 {lab=#net1}
N -590 260 -590 320 {lab=GND}
N -590 320 -60 320 {lab=GND}
N -520 280 -520 320 {lab=GND}
N -590 130 -210 130 {lab=#net1}
N -130 210 -60 210 {lab=OUT}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -220 210 0 0 {name=xota}
C {devices/code_shown.sym} -1200 -70 0 0 {name=s1 only_toplevel=false value="
*.param mc_mm_switch=0
*.param mc_pr_switch=0

.lib "../../../tech/ngspice/temperature.spi" Tl
.lib "../../../tech/ngspice/corners.spi" Kss
.lib "../../../tech/ngspice/supply.spi" Vl
.include ../../../../cpdk/ngspice/ideal_circuits.spi

*.option SEED=1
.option gmin=1e-12
.option savecurrents

.save all
.control

optran 0 0 0 10n 1u 0
*dc VIN 0 1.8 1m
tran 0.5n 6u
op
*ac dec 20 1 1G

write BANDGAP_OTA_TB.raw

*exit
.endc

"}
C {devices/capa-2.sym} -60 270 0 0 {name=CL
m=1
value=100f
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} -330 320 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -520 250 0 0 {name=VIN
value="sin(0.8 1m 1MEG)"
savecurrent=false}
C {devices/vsource.sym} -380 270 0 0 {name=V_REF
value="sin(0.8 -1m 1Meg)"
savecurrent=false
}
C {devices/launcher.sym} -270 -50 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/BANDGAP_OTA_TB.raw tran"
}
C {devices/lab_pin.sym} -520 190 0 0 {name=p1 sig_type=std_logic lab=IN+}
C {devices/lab_pin.sym} -60 210 0 1 {name=p2 sig_type=std_logic lab=OUT}
C {devices/vsource.sym} -590 230 0 0 {name=VDD
value=1.8
savecurrent=false}
C {devices/lab_pin.sym} -380 230 0 0 {name=p3 sig_type=std_logic lab=IN-}
