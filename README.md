[![GDS](../../actions/workflows/gds.yaml/badge.svg)](../../actions/workflows/gds.yaml)
[![DRC](../../actions/workflows/drc.yaml/badge.svg)](../../actions/workflows/drc.yaml)
[![LVS](../../actions/workflows/lvs.yaml/badge.svg)](../../actions/workflows/lvs.yaml)
[![DOCS](../../actions/workflows/docs.yaml/badge.svg)](../../actions/workflows/docs.yaml)

# Who

We are group 3 in the 2026 course of Advanced Integrated Curcuits.

# Why

To get an understanding of design of advanced integrated circuits in CMOS technology, and to get an overview of the circuits needed to make a System-On-Chip.

# How

The course consistns of among other things a project divided into 5(6 if tapeout) milestones. The idea is to design a temperature sensor. Further
below in the README the different milestones will get a short descriptions each.



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
| PWRUP_1V8    | Input     | VDD_1V8 | Power up the circuit
| VSS          | Input     | Ground  |                                           |


# Key parameters


| Parameter           | Min     | Typ             | Max     | Unit  |
| :---                | :---:   | :---:           | :---:   | :---: |
| Technology          |         | Skywater 130 nm |         |       |
| AVDD                | 1.7     | 1.8             | 1.9     | V     |
| Temperature         | -40     | 27              | 125     | C     |


# Milestone 1: The bandgap

The files for milestone 1 are uploaded on the main branch, under the folders design and then LELO_GR03_SKY130A.

The bandgap OTA is a two stage Miller OTA. The input nmos transistors are low treshold voltage transistors since they work with the input common mode voltage of the diode drop from ~0.8V to ~0.5V over the temperature range of -40° to 125°. The circuit diagram is shown in the Schematics page under BANDGAP_OTA.

The Bandgap circuit is shown in the Schematics page under the header BANDGAP_CIRCUIT. If we compare the voltages over the the lower diode connected BJTs, Q1 and Q2, the difference in voltage will be proportional to the size difference and temperature. Given by:

$$V_{D1} - V_{D2} = \Delta V_{BE} = V_T \text{ln}\left (\frac{I_D}{I_{S1}}\right ) - V_T \text{ln}\left (\frac{I_D}{I_{S2}}\right ) = V_T \text{ln}(N)$$

Here $V_T = \frac{kT}{q}$. The V_CTAT voltage will be the voltage over Q1 and will have a negative tempco which is approximately linear over the temperature range of interest (-40° to 125°). I_PTAT will be the current that is set by the voltage difference $\Delta V_{BE}$ over the resistor, which we denote as R1 here. This is accomplished by the op amp which forces its inputs to be equal giving the voltage drop $V_{D1} - V_{D2} = \Delta V_{BE}$ over R1. I_PTAT will thus be = $\Delta V_{BE} / R1$. 

The plots below show the corner simulations over the different temperatures for PTAT and CTAT, as well as the leakage current with respect to temperature. We can see that the PTAT current varies significantly over process corners, which is verified to be the variation in resitance of the resistor R1 for the different corners. This was seen by replacing it with a generic resistor without process variations and seeing much less variation, less than 10% worse case error compared to 30%.

![layout](svgs/bandgap_measurement.svg)


# Milestone 2: The Oscillator 

The files for milestone 1 are uploaded on the main branch, under the folders design and then LELO_GR03_SKY130A.

The Schematic is shown in the Schematics page under the header OSCILLATOR. The current I_PTAT is chargin a capacitor and the voltage across it is compared to the voltage V_CTAT. As the current and voltage in question are both proportional to temperature the resulting output frequency from the comparator will also be linear in temperature. Using the equation for current through a capacitor we have

$$i = C \frac{dV}{dt} => dt = C \frac{dV}{i} => f = \frac{1}{dt} = \frac{I_{PTAT}}{C V_{CTAT}} $$

The plot below shows the frequency from the oscillator with regards to the temperature changes:

![layout](svgs/oscillator_measurement.svg)

