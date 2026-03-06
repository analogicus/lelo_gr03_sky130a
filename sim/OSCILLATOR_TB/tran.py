#!/usr/bin/env python3
import matplotlib.pyplot as plt
import yaml


def main(name):
    yamlfile = name + ".yaml"

    # Read result yaml file
    with open(yamlfile) as fi:
        obj = yaml.safe_load(fi)

    t1_vals = {}
    t2_vals = {}

    # Extract measurements
    for key, val in obj.items():
        if key.startswith("t1_"):
            temp = int(key.split("_")[1])
            t1_vals[temp] = float(val)

        elif key.startswith("t2_"):
            temp = int(key.split("_")[1])
            t2_vals[temp] = float(val)

    # Compute frequency
    temps = sorted(t1_vals.keys())
    freq = []

    for t in temps:
        if t in t2_vals:
            period = (t2_vals[t] - t1_vals[t]) / 4.0
            freq.append(1.0 / period)

    # Plot
    fig, ax = plt.subplots(figsize=(6, 4))
    ax.plot(temps, freq)
    ax.set_title("Frequency vs Temperature")
    ax.set_xlabel("Temperature [C]")
    ax.set_ylabel("Frequency [Hz]")
    ax.grid(True)

    fig.tight_layout()
    fig.savefig("../../svgs/oscillator_measurement.svg")


if __name__ == "__main__":
    import sys
    main(sys.argv[1])