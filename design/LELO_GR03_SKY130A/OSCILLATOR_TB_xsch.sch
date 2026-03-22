v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -60 -20 740 380 {flags=graph
y1=-0.56694752
y2=2.8890525
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-4.5874351e-08
x2=1.359214e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="4 4"
node="out
x1.vx"}
N -160 -40 -160 -20 {lab=VDD}
N -160 40 -160 60 {lab=0}
N 140 -140 170 -140 {lab=OUT}
C {LELO_GR03_SKY130A/OSCILLATOR.sym} -10 -120 0 0 {name=x1}
C {devices/vsource.sym} -160 10 0 0 {name=VDD value=1.8 savecurrent=false}
C {devices/lab_wire.sym} -160 60 2 1 {name=p1 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -160 -40 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -160 -100 2 1 {name=p2 sig_type=std_logic lab=0}
C {devices/lab_wire.sym} -160 -120 0 0 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -160 -140 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {devices/capa.sym} 170 -110 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 170 -80 2 1 {name=p6 sig_type=std_logic lab=0}
C {devices/code_shown.sym} -720 -230 0 0 {name=s1 only_toplevel=false value="
.param mc_mm_switch=0
.param mc_pr_switch=0

.lib "../../../tech/ngspice/temperature.spi" Tl
.lib "../../../tech/ngspice/corners.spi" Kff
.lib "../../../tech/ngspice/supply.spi" Vh
.include ../../../../cpdk/ngspice/ideal_circuits.spi
*.option savecurrents
.option gmin=1e-12
*.option SEED=1
.save all
.temp 120
.control

optran 0 0 0 10n 1u 0
*dc VIN 0 1.8 1m
tran 0.1n 2u
*op
*ac dec 20 1 1G

write OSCILLATOR_TB.raw

exit
.endc
"}
C {devices/lab_wire.sym} 170 -140 0 1 {name=p7 sig_type=std_logic lab=OUT}
C {devices/title.sym} -550 -320 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
