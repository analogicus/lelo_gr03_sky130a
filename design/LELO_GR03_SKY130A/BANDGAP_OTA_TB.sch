v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -930 -550 -130 -150 {flags=graph
y1=2.8621872
y2=133.87573
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.6772488e+09
x2=4.0596489e+09
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
N -450 300 -450 320 {lab=0}
N -230 110 -230 130 {lab=VDD}
N -590 190 -590 220 {lab=IN+}
N -590 190 -380 190 {lab=IN+}
N -660 260 -660 320 {lab=0}
N -660 320 -130 320 {lab=0}
N -590 280 -590 320 {lab=0}
N -660 110 -230 110 {lab=VDD}
N -660 110 -660 200 {lab=VDD}
N -230 290 -230 320 {lab=0}
N -130 320 -60 320 {lab=0}
N -60 300 -60 320 {lab=0}
N -170 90 -170 130 {lab=0}
N -170 90 -160 90 {lab=0}
N -160 90 -160 100 {lab=0}
N -80 210 -60 210 {lab=OUT}
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
tran 0.5u 6m
*op
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
C {devices/vsource.sym} -590 250 0 0 {name=VIN
value="sin(0.55 3m 1k)"
savecurrent=false}
C {devices/vsource.sym} -450 270 0 0 {name=V_REF
value="sin(0.55 -3m 1k)"
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
C {devices/lab_pin.sym} -430 110 0 1 {name=p4 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -170 290 0 1 {name=p5 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -330 320 0 1 {name=p6 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} -160 100 0 1 {name=p7 sig_type=std_logic lab=0}
C {LELO_GR03_SKY130A/COMPARATOR.sym} -230 190 0 0 {name=x1}
C {devices/title.sym} -1130 -620 0 0 {name=l1 author="Martin Solvik, Kim Hamberg, Henrik Alstadhaug"}
