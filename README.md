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

The OTA is based on a two stage Miller OTA. The transistors were chosen for their low treshold voltage, as they worked with the set voltage.

The overhead bandgap curcuit was made from the standard bandgap design following the instructions in the AIC course.

The sizes for CTAT and PTAT were calculated using the formulas from the course.

The layouts for milestone 1 can be found under Schematics. These include BANDGAP_CURICUIT and BANDGAP_OTA, and together they convert the temperature into a current and a voltage.

The PTAT plots:
![layout](svgs/bandgap_measurement.svg)


# Milestone 2: The Oscillator 

The files for milestone 1 are uploaded on the main branch, under the folders design and then LELO_GR03_SKY130A.

The Oscillator is based on the one in LELO_TEMP with some adjusted components and design choices. The capacitor in the oscillator is set so the frequency is ok. The layouts for the Oscillator and Comparator used in milestone 2 can be found under Schematics. The two new layouts made for this milestone are OSCILLATOR and COMPARATOR, these in tandem with the layouts from Milestone 1 create a curcuit that converts the temperature into a frequency. 

The frequency/temperature plots
![layout](svgs/oscillator_measurement.svg)