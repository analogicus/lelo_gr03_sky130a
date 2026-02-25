-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_GR03_SKY130A/OSCILLATOR.sch
entity OSCILLATOR is
port(
  PWRUP_1V8 :  in std_logic ;
  VDD_1V8 :  in std_logic ;
  VSS :  in std_logic
);
end OSCILLATOR ;

architecture arch_OSCILLATOR of OSCILLATOR is

component BANDGAP_CIRCUIT 
port (
  VDD_1V8 : in std_logic ;
  I_PTAT : out std_logic ;
  PWRUP_1V8 : in std_logic ;
  V_CTAT : out std_logic ;
  VSS : in std_logic ;
  PWRUP_N_1V8 : in std_logic
);
end component ;

component JNWTR_IVX1_CV 
port (
  A : in std_logic ;
  Y : out std_logic ;
  AVDD : in std_logic ;
  AVSS : in std_logic
);
end component ;

component JNWTR_CAPX4 
port (
  A : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWATR_NCH_4C5F0 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component BANDGAP_OTA 
port (
  VDD : in std_logic ;
  IN+ : in std_logic ;
  OUT : out std_logic ;
  IN- : in std_logic ;
  VSS : in std_logic ;
  PWRUP_N_1V8 : in std_logic ;
  PWRUP_1V8 : in std_logic
);
end component ;


signal PWRUP_N_1V8_BUF : std_logic ;
signal V_CTAT : std_logic ;
signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
signal net4 : std_logic ;
signal net5 : std_logic ;
signal PWRUP_1V8_BUF : std_logic ;
begin
x1 : BANDGAP_CIRCUIT
port map (
   VDD_1V8 => VDD_1V8 ,
   I_PTAT => net1 ,
   PWRUP_1V8 => PWRUP_1V8_BUF ,
   V_CTAT => V_CTAT ,
   VSS => VSS ,
   PWRUP_N_1V8 => PWRUP_N_1V8_BUF
);

x6 : JNWTR_IVX1_CV
port map (
   A => PWRUP_1V8 ,
   Y => PWRUP_N_1V8_BUF ,
   AVDD => VDD_1V8 ,
   AVSS => VSS
);

x2 : JNWTR_IVX1_CV
port map (
   A => PWRUP_N_1V8_BUF ,
   Y => PWRUP_1V8_BUF ,
   AVDD => VDD_1V8 ,
   AVSS => VSS
);

x3 : JNWTR_CAPX4
port map (
   A => VSS ,
   B => net1
);

x4 : JNWATR_NCH_4C5F0
port map (
   D => net1 ,
   G => PWRUP_1V8_BUF ,
   S => VSS ,
   B => VSS
);

x5 : JNWATR_NCH_4C5F0
port map (
   D => net1 ,
   G => net2 ,
   S => net5 ,
   B => VSS
);

x7 : BANDGAP_OTA
port map (
   VDD => VDD_1V8 ,
   IN+ => net1 ,
   OUT => net4 ,
   IN- => V_CTAT ,
   VSS => VSS ,
   PWRUP_N_1V8 => PWRUP_N_1V8_BUF ,
   PWRUP_1V8 => PWRUP_1V8_BUF
);

x8 : JNWTR_IVX1_CV
port map (
   A => net4 ,
   Y => net3 ,
   AVDD => VDD_1V8 ,
   AVSS => VSS
);

x9 : JNWTR_IVX1_CV
port map (
   A => net3 ,
   Y => net2 ,
   AVDD => VDD_1V8 ,
   AVSS => VSS
);

end arch_OSCILLATOR ;


-- expanding   symbol:  LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym # of pins=6
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_GR03_SKY130A/BANDGAP_CIRCUIT.sch
entity BANDGAP_CIRCUIT is
port (
  VDD_1V8 : in std_logic ;
  I_PTAT : out std_logic ;
  PWRUP_1V8 : in std_logic ;
  V_CTAT : out std_logic ;
  VSS : in std_logic ;
  PWRUP_N_1V8 : in std_logic
);
end BANDGAP_CIRCUIT ;

architecture arch_BANDGAP_CIRCUIT of BANDGAP_CIRCUIT is

component JNWTR_CAPX4 
port (
  A : inout std_logic ;
  B : inout std_logic
);
end component ;

component BANDGAP_OTA 
port (
  VDD : in std_logic ;
  IN+ : in std_logic ;
  OUT : out std_logic ;
  IN- : in std_logic ;
  VSS : in std_logic ;
  PWRUP_N_1V8 : in std_logic ;
  PWRUP_1V8 : in std_logic
);
end component ;

component JNWATR_PCH_12C1F2 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWATR_PCH_4C5F0 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWTR_RPPO2 
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end component ;


signal VD2 : std_logic ;
signal DV : std_logic ;
signal VB_P : std_logic ;
signal net1 : std_logic ;
begin
x6 : JNWTR_CAPX4
port map (
   A => VB_P ,
   B => net1
);

x7 : BANDGAP_OTA
port map (
   VDD => VDD_1V8 ,
   IN+ => DV ,
   OUT => VB_P ,
   IN- => V_CTAT ,
   VSS => VSS ,
   PWRUP_N_1V8 => PWRUP_N_1V8 ,
   PWRUP_1V8 => PWRUP_1V8
);

Q1 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => V_CTAT
);

Q2_X_7 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_6 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_5 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_4 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_3 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_2 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_1 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);
Q2_X_0 : pnp_05v5
generic map (
   model => pnp_05v5_W3p40L3p40 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   collector => VSS ,
   base => VSS ,
   emitter => VD2
);

x10_X_3 : JNWATR_PCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_N_1V8 ,
   S => VDD_1V8 ,
   B => VDD_1V8
);
x10_X_2 : JNWATR_PCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_N_1V8 ,
   S => VDD_1V8 ,
   B => VDD_1V8
);
x10_X_1 : JNWATR_PCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_N_1V8 ,
   S => VDD_1V8 ,
   B => VDD_1V8
);
x10_X_0 : JNWATR_PCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_N_1V8 ,
   S => VDD_1V8 ,
   B => VDD_1V8
);

x20 : JNWATR_PCH_4C5F0
port map (
   D => DV ,
   G => VB_P ,
   S => net1 ,
   B => VDD_1V8
);

x2 : JNWATR_PCH_4C5F0
port map (
   D => V_CTAT ,
   G => VB_P ,
   S => net1 ,
   B => VDD_1V8
);

x3 : JNWATR_PCH_4C5F0
port map (
   D => I_PTAT ,
   G => VB_P ,
   S => net1 ,
   B => VDD_1V8
);

x4 : JNWTR_RPPO2
port map (
   N => VD2 ,
   P => DV ,
   B => VSS
);

end arch_BANDGAP_CIRCUIT ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_IVX1_CV.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_IVX1_CV.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_IVX1_CV.sch
entity JNWTR_IVX1_CV is
port (
  A : in std_logic ;
  Y : out std_logic ;
  AVDD : in std_logic ;
  AVSS : in std_logic
);
end JNWTR_IVX1_CV ;

architecture arch_JNWTR_IVX1_CV of JNWTR_IVX1_CV is

component JNWTR_NCHDL 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWTR_PCHDL 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

begin
XMN0 : JNWTR_NCHDL
port map (
   D => Y ,
   G => A ,
   S => AVSS ,
   B => AVSS
);

XMP0 : JNWTR_PCHDL
port map (
   D => Y ,
   G => A ,
   S => AVDD ,
   B => AVDD
);

end arch_JNWTR_IVX1_CV ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_CAPX4.sym # of pins=2
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_CAPX4.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_CAPX4.sch
entity JNWTR_CAPX4 is
port (
  A : inout std_logic ;
  B : inout std_logic
);
end JNWTR_CAPX4 ;

architecture arch_JNWTR_CAPX4 of JNWTR_CAPX4 is

component JNWTR_CAPX1 
port (
  A : inout std_logic ;
  B : inout std_logic
);
end component ;

begin
XXA1 : JNWTR_CAPX1
port map (
   A => A ,
   B => B
);

XXA2 : JNWTR_CAPX1
port map (
   A => A ,
   B => B
);

XXB1 : JNWTR_CAPX1
port map (
   A => A ,
   B => B
);

XXB2 : JNWTR_CAPX1
port map (
   A => A ,
   B => B
);

end arch_JNWTR_CAPX4 ;


-- expanding   symbol:  JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_NCH_4C5F0.sch
entity JNWATR_NCH_4C5F0 is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end JNWATR_NCH_4C5F0 ;

architecture arch_JNWATR_NCH_4C5F0 of JNWATR_NCH_4C5F0 is

begin
M1 : nfet_01v8
generic map (
   L => 0.94 ,
   W => 3.2 ,
   nf => 2 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8 ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_JNWATR_NCH_4C5F0 ;


-- expanding   symbol:  LELO_GR03_SKY130A/BANDGAP_OTA.sym # of pins=7
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_GR03_SKY130A/BANDGAP_OTA.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_GR03_SKY130A/BANDGAP_OTA.sch
entity BANDGAP_OTA is
port (
  VDD : in std_logic ;
  IN+ : in std_logic ;
  OUT : out std_logic ;
  IN- : in std_logic ;
  VSS : in std_logic ;
  PWRUP_N_1V8 : in std_logic ;
  PWRUP_1V8 : in std_logic
);
end BANDGAP_OTA ;

architecture arch_BANDGAP_OTA of BANDGAP_OTA is

component JNWTR_CAPX4 
port (
  A : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWATR_NCH_4C5F0 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWATR_PCH_12C1F2 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWATR_PCH_4C5F0 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWTR_RPPO2 
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end component ;

component LELOATR_LVT_NCH_4C5F0 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWTR_RPPO16 
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end component ;

component JNWATR_NCH_12C1F2 
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end component ;


signal VTAIL : std_logic ;
signal V_IB : std_logic ;
signal VB_P : std_logic ;
signal V2 : std_logic ;
signal VD : std_logic ;
signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
signal net4 : std_logic ;
begin
x18_X_4 : LELOATR_LVT_NCH_4C5F0
port map (
   D => VB_P ,
   G => IN- ,
   S => VTAIL ,
   B => VSS
);
x18_X_3 : LELOATR_LVT_NCH_4C5F0
port map (
   D => VB_P ,
   G => IN- ,
   S => VTAIL ,
   B => VSS
);
x18_X_2 : LELOATR_LVT_NCH_4C5F0
port map (
   D => VB_P ,
   G => IN- ,
   S => VTAIL ,
   B => VSS
);
x18_X_1 : LELOATR_LVT_NCH_4C5F0
port map (
   D => VB_P ,
   G => IN- ,
   S => VTAIL ,
   B => VSS
);
x18_X_0 : LELOATR_LVT_NCH_4C5F0
port map (
   D => VB_P ,
   G => IN- ,
   S => VTAIL ,
   B => VSS
);

x19_X_4 : LELOATR_LVT_NCH_4C5F0
port map (
   D => V2 ,
   G => IN+ ,
   S => VTAIL ,
   B => VSS
);
x19_X_3 : LELOATR_LVT_NCH_4C5F0
port map (
   D => V2 ,
   G => IN+ ,
   S => VTAIL ,
   B => VSS
);
x19_X_2 : LELOATR_LVT_NCH_4C5F0
port map (
   D => V2 ,
   G => IN+ ,
   S => VTAIL ,
   B => VSS
);
x19_X_1 : LELOATR_LVT_NCH_4C5F0
port map (
   D => V2 ,
   G => IN+ ,
   S => VTAIL ,
   B => VSS
);
x19_X_0 : LELOATR_LVT_NCH_4C5F0
port map (
   D => V2 ,
   G => IN+ ,
   S => VTAIL ,
   B => VSS
);

x2_X_2 : JNWATR_NCH_4C5F0
port map (
   D => VTAIL ,
   G => V_IB ,
   S => net1 ,
   B => VSS
);
x2_X_1 : JNWATR_NCH_4C5F0
port map (
   D => VTAIL ,
   G => V_IB ,
   S => net1 ,
   B => VSS
);
x2_X_0 : JNWATR_NCH_4C5F0
port map (
   D => VTAIL ,
   G => V_IB ,
   S => net1 ,
   B => VSS
);

x20 : JNWATR_PCH_4C5F0
port map (
   D => V2 ,
   G => VB_P ,
   S => VD ,
   B => VDD
);

x21 : JNWATR_PCH_4C5F0
port map (
   D => VB_P ,
   G => VB_P ,
   S => VD ,
   B => VDD
);

x10 : JNWATR_PCH_4C5F0
port map (
   D => OUT ,
   G => V2 ,
   S => VD ,
   B => VDD
);

x4 : JNWATR_NCH_4C5F0
port map (
   D => V_IB ,
   G => V_IB ,
   S => net1 ,
   B => VSS
);

x6 : JNWATR_NCH_4C5F0
port map (
   D => OUT ,
   G => V_IB ,
   S => net1 ,
   B => VSS
);

x1 : JNWTR_RPPO16
port map (
   N => V_IB ,
   P => VD ,
   B => VSS
);

x9_X_3 : JNWATR_PCH_12C1F2
port map (
   D => VD ,
   G => PWRUP_N_1V8 ,
   S => VDD ,
   B => VDD
);
x9_X_2 : JNWATR_PCH_12C1F2
port map (
   D => VD ,
   G => PWRUP_N_1V8 ,
   S => VDD ,
   B => VDD
);
x9_X_1 : JNWATR_PCH_12C1F2
port map (
   D => VD ,
   G => PWRUP_N_1V8 ,
   S => VDD ,
   B => VDD
);
x9_X_0 : JNWATR_PCH_12C1F2
port map (
   D => VD ,
   G => PWRUP_N_1V8 ,
   S => VDD ,
   B => VDD
);

x1_X_3 : JNWATR_NCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_1V8 ,
   S => VSS ,
   B => VSS
);
x1_X_2 : JNWATR_NCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_1V8 ,
   S => VSS ,
   B => VSS
);
x1_X_1 : JNWATR_NCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_1V8 ,
   S => VSS ,
   B => VSS
);
x1_X_0 : JNWATR_NCH_12C1F2
port map (
   D => net1 ,
   G => PWRUP_1V8 ,
   S => VSS ,
   B => VSS
);

x9 : JNWTR_RPPO2
port map (
   N => net2 ,
   P => V2 ,
   B => VSS
);

x11 : JNWTR_CAPX4
port map (
   A => OUT ,
   B => net2
);

x2 : JNWATR_NCH_4C5F0
port map (
   D => net4 ,
   G => OUT ,
   S => net3 ,
   B => VSS
);

x3 : JNWATR_NCH_4C5F0
port map (
   D => net3 ,
   G => net3 ,
   S => VSS ,
   B => VSS
);

x5 : JNWATR_PCH_4C5F0
port map (
   D => net4 ,
   G => net4 ,
   S => VD ,
   B => VDD
);

x7 : JNWATR_PCH_4C5F0
port map (
   D => OUT ,
   G => net4 ,
   S => VD ,
   B => VDD
);

x8 : JNWATR_NCH_4C5F0
port map (
   D => OUT ,
   G => OUT ,
   S => VSS ,
   B => VSS
);

end arch_BANDGAP_OTA ;


-- expanding   symbol:  JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_PCH_12C1F2.sch
entity JNWATR_PCH_12C1F2 is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end JNWATR_PCH_12C1F2 ;

architecture arch_JNWATR_PCH_12C1F2 of JNWATR_PCH_12C1F2 is

begin
M1 : pfet_01v8
generic map (
   L => 0.22 ,
   W => 8.32 ,
   nf => 2 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_JNWATR_PCH_12C1F2 ;


-- expanding   symbol:  JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_PCH_4C5F0.sch
entity JNWATR_PCH_4C5F0 is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end JNWATR_PCH_4C5F0 ;

architecture arch_JNWATR_PCH_4C5F0 of JNWATR_PCH_4C5F0 is

begin
M1 : pfet_01v8
generic map (
   L => 0.94 ,
   W => 3.2 ,
   nf => 2 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_JNWATR_PCH_4C5F0 ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_RPPO2.sym # of pins=3
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RPPO2.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RPPO2.sch
entity JNWTR_RPPO2 is
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end JNWTR_RPPO2 ;

architecture arch_JNWTR_RPPO2 of JNWTR_RPPO2 is

component JNWTR_RES2 
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end component ;

begin
XXA1 : JNWTR_RES2
port map (
   N => N ,
   P => P ,
   B => B
);

end arch_JNWTR_RPPO2 ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_NCHDL.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_NCHDL.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_NCHDL.sch
entity JNWTR_NCHDL is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end JNWTR_NCHDL ;

architecture arch_JNWTR_NCHDL of JNWTR_NCHDL is

begin
M1 : nfet_01v8
generic map (
   L => 0.16 ,
   W => 0.9 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8 ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_JNWTR_NCHDL ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_PCHDL.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_PCHDL.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_PCHDL.sch
entity JNWTR_PCHDL is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end JNWTR_PCHDL ;

architecture arch_JNWTR_PCHDL of JNWTR_PCHDL is

begin
M1 : pfet_01v8
generic map (
   L => 0.16 ,
   W => 0.9 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_JNWTR_PCHDL ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_CAPX1.sym # of pins=2
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_CAPX1.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_CAPX1.sch
entity JNWTR_CAPX1 is
port (
  A : inout std_logic ;
  B : inout std_logic
);
end JNWTR_CAPX1 ;

architecture arch_JNWTR_CAPX1 of JNWTR_CAPX1 is

begin
C1 : cap_mim_m3_1
generic map (
   L => 5 ,
   W => 5
)
port map (
   c0 => B ,
   c1 => A
);

end arch_JNWTR_CAPX1 ;


-- expanding   symbol:  LELO_ATR_SKY130Aa/LELOATR_LVT_NCH_4C5F0.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_ATR_SKY130Aa/LELOATR_LVT_NCH_4C5F0.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/LELO_ATR_SKY130Aa/LELOATR_LVT_NCH_4C5F0.sch
entity LELOATR_LVT_NCH_4C5F0 is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end LELOATR_LVT_NCH_4C5F0 ;

architecture arch_LELOATR_LVT_NCH_4C5F0 of LELOATR_LVT_NCH_4C5F0 is

begin
M1 : nfet_01v8_lvt
generic map (
   L => 0.94 ,
   W => 3.2 ,
   nf => 2 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_LELOATR_LVT_NCH_4C5F0 ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_RPPO16.sym # of pins=3
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RPPO16.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RPPO16.sch
entity JNWTR_RPPO16 is
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end JNWTR_RPPO16 ;

architecture arch_JNWTR_RPPO16 of JNWTR_RPPO16 is

component JNWTR_RES16 
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end component ;

begin
XXA1 : JNWTR_RES16
port map (
   N => N ,
   P => P ,
   B => B
);

end arch_JNWTR_RPPO16 ;


-- expanding   symbol:  JNW_ATR_SKY130A/JNWATR_NCH_12C1F2.sym # of pins=4
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_NCH_12C1F2.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_ATR_SKY130A/JNWATR_NCH_12C1F2.sch
entity JNWATR_NCH_12C1F2 is
port (
  D : inout std_logic ;
  G : inout std_logic ;
  S : inout std_logic ;
  B : inout std_logic
);
end JNWATR_NCH_12C1F2 ;

architecture arch_JNWATR_NCH_12C1F2 of JNWATR_NCH_12C1F2 is

begin
M1 : nfet_01v8
generic map (
   L => 0.22 ,
   W => 8.32 ,
   nf => 2 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8 ,
   spiceprefix => X
)
port map (
   D => D ,
   G => G ,
   S => S ,
   B => B
);

end arch_JNWATR_NCH_12C1F2 ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_RES2.sym # of pins=3
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RES2.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RES2.sch
entity JNWTR_RES2 is
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end JNWTR_RES2 ;

architecture arch_JNWTR_RES2 of JNWTR_RES2 is


signal INT_0 : std_logic ;
begin
R1_0 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_0 ,
   P => N ,
   B => B
);

R1_1 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => P ,
   P => INT_0 ,
   B => B
);

end arch_JNWTR_RES2 ;


-- expanding   symbol:  JNW_TR_SKY130A/JNWTR_RES16.sym # of pins=3
-- sym_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RES16.sym
-- sch_path: /home/halst/pro/aicex/ip/lelo_gr03_sky130a/design/JNW_TR_SKY130A/JNWTR_RES16.sch
entity JNWTR_RES16 is
port (
  N : inout std_logic ;
  P : inout std_logic ;
  B : inout std_logic
);
end JNWTR_RES16 ;

architecture arch_JNWTR_RES16 of JNWTR_RES16 is


signal INT_10 : std_logic ;
signal INT_11 : std_logic ;
signal INT_12 : std_logic ;
signal INT_13 : std_logic ;
signal INT_14 : std_logic ;
signal INT_0 : std_logic ;
signal INT_1 : std_logic ;
signal INT_2 : std_logic ;
signal INT_3 : std_logic ;
signal INT_4 : std_logic ;
signal INT_5 : std_logic ;
signal INT_6 : std_logic ;
signal INT_7 : std_logic ;
signal INT_8 : std_logic ;
signal INT_9 : std_logic ;
begin
R1_0 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_0 ,
   P => N ,
   B => B
);

R1_1 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_1 ,
   P => INT_0 ,
   B => B
);

R1_2 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_2 ,
   P => INT_1 ,
   B => B
);

R1_3 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_3 ,
   P => INT_2 ,
   B => B
);

R1_4 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_4 ,
   P => INT_3 ,
   B => B
);

R1_5 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_5 ,
   P => INT_4 ,
   B => B
);

R1_6 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_6 ,
   P => INT_5 ,
   B => B
);

R1_7 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_7 ,
   P => INT_6 ,
   B => B
);

R1_8 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_8 ,
   P => INT_7 ,
   B => B
);

R1_9 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_9 ,
   P => INT_8 ,
   B => B
);

R1_10 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_10 ,
   P => INT_9 ,
   B => B
);

R1_11 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_11 ,
   P => INT_10 ,
   B => B
);

R1_12 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_12 ,
   P => INT_11 ,
   B => B
);

R1_13 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_13 ,
   P => INT_12 ,
   B => B
);

R1_14 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => INT_14 ,
   P => INT_13 ,
   B => B
);

R1_15 : res_high_po
generic map (
   W => 0.36 ,
   L => 7.36 ,
   model => res_high_po ,
   mult => 1
)
port map (
   M => P ,
   P => INT_14 ,
   B => B
);

end arch_JNWTR_RES16 ;

