v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -930 -550 -130 -150 {flags=graph
y1=-0.21657133
y2=1.9826252
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=7.8374623e-08
x2=3.5410446e-06
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
N -60 210 -60 240 {lab=OUT}
N -450 230 -450 240 {lab=IN-}
N -450 230 -380 230 {lab=IN-}
N -450 300 -450 320 {lab=GND}
N -230 110 -230 130 {lab=#net1}
N -590 190 -590 220 {lab=IN+}
N -590 190 -380 190 {lab=IN+}
N -660 260 -660 320 {lab=GND}
N -660 320 -130 320 {lab=GND}
N -590 280 -590 320 {lab=GND}
N -130 210 -60 210 {lab=OUT}
N -660 110 -230 110 {lab=#net1}
N -660 110 -660 200 {lab=#net1}
N -230 290 -230 320 {lab=GND}
N -130 320 -60 320 {lab=GND}
N -60 300 -60 320 {lab=GND}
C {LELO_GR03_SKY130A/BANDGAP_OTA.sym} -230 190 0 0 {name=xota}
C {devices/code_shown.sym} -1200 -70 0 0 {name=s1 only_toplevel=false value="
.param mc_mm_switch=0
.param mc_pr_switch=0

.lib "../../../tech/ngspice/temperature.spi" Tl
.lib "../../../tech/ngspice/corners.spi" Kss
.lib "../../../tech/ngspice/supply.spi" Vl
.include ../../../../cpdk/ngspice/ideal_circuits.spi
*.option savecurrents
.option gmin=1e-12
*.option SEED=1
.save all
.control

optran 0 0 0 10n 1u 0
*dc VIN 0 1.8 1m
*tran 0.5n 6u
op
*ac dec 20 1 1G

write BANDGAP_OTA_TB.raw

exit
.endc
"}
C {devices/capa-2.sym} -60 270 0 0 {name=CL
m=1
value=300f
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} -400 320 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -590 250 0 0 {name=VIN
value="DC 0.8 AC 1"
savecurrent=false}
C {devices/vsource.sym} -450 270 0 0 {name=V_REF
value="DC 0.8"
savecurrent=false
}
C {devices/launcher.sym} -270 -50 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/BANDGAP_OTA_TB.raw tran"
}
C {devices/lab_pin.sym} -590 190 0 0 {name=p1 sig_type=std_logic lab=IN+}
C {devices/lab_pin.sym} -60 210 0 1 {name=p2 sig_type=std_logic lab=OUT}
C {devices/vsource.sym} -660 230 0 0 {name=VDD
value=1.8
savecurrent=false}
C {devices/lab_pin.sym} -450 230 0 0 {name=p3 sig_type=std_logic lab=IN-}
