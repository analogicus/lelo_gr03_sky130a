[![GDS](../../actions/workflows/gds.yaml/badge.svg)](../../actions/workflows/gds.yaml)
[![DRC](../../actions/workflows/drc.yaml/badge.svg)](../../actions/workflows/drc.yaml)
[![LVS](../../actions/workflows/lvs.yaml/badge.svg)](../../actions/workflows/lvs.yaml)
[![DOCS](../../actions/workflows/docs.yaml/badge.svg)](../../actions/workflows/docs.yaml)

# Who

We are group 3 in the 2026 Advanced Integrated Circuits course.

# Why

To get an understanding of the design of advanced integrated circuits in CMOS technology, and to get an overview of the circuits needed to make a System-On-Chip.

# How

The course consists, among other things, of a project divided into 5 (6 if tapeout) milestones. The idea is to design a temperature sensor. In the README below, each milestone will have a short description.



# What

| What            |        Cell/Name |
| :----           |  :----:       |
| Schematic       | design/LELO_GR03_SKY130A/LELO_GR03.sch |
| Layout          | design/LELO_GR03_SKY130A/LELO_GR03.mag |



# Signal interface


| Signal       | Direction | Domain  | Description                               |
| :---         | :---:     | :---:   | :---                                      |
| VDD_1V8      | Input     | VDD_1V8 | Main supply                               |
| OSC_TEMP_1V8 | Output    | VDD_1V8 | Temperature dependent oscillation frequency|
| PWRUP_1V8    | Input     | VDD_1V8 | Power up the circuit                      |
| VSS          | Input     | Ground  |                                           |


# Key parameters


| Parameter           | Min     | Typ             | Max     | Unit  |
| :---                | :---:   | :---:           | :---:   | :---: |
| Technology          |         | Skywater 130 nm |         |       |
| AVDD                | 1.7     | 1.8             | 1.9     | V     |
| Temperature         | -40     | 27              | 125     | C     |
| Frequency (typical) |         | ~4              |         | MHz   |
| Ileak (power-down)  |         |                 | 1       | nA    |
| Iact (active)       |         | ~90             |         | µA    |
| Kerr (1-pt cal)     |         |                 | ±10     | C     |
| Kerr (2-pt cal)     |         |                 | ±5      | C     |


# Milestone 1: The Bandgap

The bandgap OTA is a two-stage Miller OTA (see [BANDGAP_OTA](#bandgap_ota)). The input NMOS transistors are low-threshold-voltage transistors, since they operate with the diode drop in the input common-mode voltage, reducing it from ~0.8V to ~0.5V over the temperature range of -40° to 125°.

The bandgap circuit (see [BANDGAP_CIRCUIT](#bandgap_circuit)) uses a 1:8 BJT ratio (Q1 = 1×, Q2 = 8×). If we compare the voltages across the lower diode-connected BJTs, Q1 and Q2, the voltage difference will be proportional to the size difference and temperature:

$$V_{D1} - V_{D2} = \Delta V_{BE} = V_T \text{ln}\left (\frac{I_D}{I_{S1}}\right ) - V_T \text{ln}\left (\frac{I_D}{I_{S2}}\right ) = V_T \text{ln}(N)$$

Here $V_T = \frac{kT}{q}$. The V_CTAT voltage across Q1 will have a negative temperature coefficient and will be approximately linear over the temperature range of interest (-40° to 125°). I_PTAT will be the current set by the voltage difference $\Delta V_{BE}$ over the resistor, which we denote as R1. The operational amplifier forces its inputs to be equal, resulting in a voltage drop $V_{D1} - V_{D2} = \Delta V_{BE}$ across R1. I_PTAT will thus be $\Delta V_{BE} / R1$.

The plots below show the corner simulations over temperature for PTAT current, CTAT voltage, power-down leakage current, and active supply current. The PTAT current varies significantly across process corners, as verified by the resistance variation of resistor R1 across the different corners. We tested this by replacing R1 with a generic resistor without process variations and observing much less variation, with a worst-case error of less than 10% compared to 30%. The power-down leakage stays well below 1 nA across all corners.

![bandgap measurements](svgs/bandgap_measurement.svg)


# Milestone 2: The Oscillator

The PTAT current from the bandgap charges a timing capacitor (12 MIM caps, see [OSCILLATOR](#oscillator)), and the voltage across the capacitors feeds into the [COMPARATOR](#comparator) alongside the reference voltage V_CTAT. Then, if the capacitor voltage exceeds V_CTAT, the comparator fires, and a reset pulse discharges the capacitor through an NMOS switch, restarting the cycle. The comparator output feeds into a D flip-flop, which divides the frequency by 2 to produce a clean square wave. Since both the charging current (PTAT) and the threshold voltage (CTAT) are proportional to temperature, the resulting output frequency is approximately linear in temperature. Using the equation for current through a capacitor:

$$i = C \frac{dV}{dt} \Rightarrow dt = C \frac{dV}{i} \Rightarrow f = \frac{1}{dt} = \frac{I_{PTAT}}{C \cdot V_{CTAT}} $$

## Temperature error estimation

Since the FSM and counter are not yet implemented, we estimate the temperature measurement error directly from the simulated frequency. The idea is to invert the frequency-to-temperature relationship: given a measured frequency, we compute what temperature a calibrated system would report, and compare that to the actual simulation temperature.

**1-point calibration** uses a single calibration point at 25°C. We take the nominal frequency-vs-temperature slope from the typical corner (KttVt) and apply it to all corners. For each corner, we compute the offset at 25°C and convert frequency back to temperature using:

$$T_{meas} = \text{slope}_{nom} \cdot f + \text{offset}_{25}$$

This assumes all chips share the same slope, which breaks down at extreme PVT corners.

**2-point calibration** fits a line through two calibration points at 25°C and 85°C for each individual corner. This per-chip calibration removes slope variation and only leaves residual non-linearity as error:

$$T_{meas} = \frac{85 - 25}{f_{85} - f_{25}} \cdot (f - f_{25}) + 25$$

The plots below show the oscillator performance across PVT corners. All corners pass the 2-point calibration spec of ±5°C with margin (max 2.1°C error). The 1-point calibration meets ±10°C for most corners, with the extreme corners KffVh and KssVl slightly exceeding the limit.

![oscillator measurements](svgs/oscillator_measurement.svg)


# Schematics

## BANDGAP_OTA

![BANDGAP_OTA schematic](svgs/BANDGAP_OTA.svg)

## BANDGAP_CIRCUIT

![BANDGAP_CIRCUIT schematic](svgs/BANDGAP_CIRCUIT.svg)

## COMPARATOR

![COMPARATOR schematic](svgs/COMPARATOR.svg)

## OSCILLATOR

![OSCILLATOR schematic](svgs/OSCILLATOR.svg)
