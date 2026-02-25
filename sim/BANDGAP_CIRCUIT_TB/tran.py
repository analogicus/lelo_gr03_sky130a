#!/usr/bin/env python3
import matplotlib.pyplot as plt
import yaml


def main(name):
    # Delete next line if you want to use python post processing
    # return
    yamlfile = name + ".yaml"

    # Read result yaml file
    with open(yamlfile) as fi:
        obj = yaml.safe_load(fi)

    # Do something to parameters
    iptat = []
    vctat = []

    for key, val in obj.items():
        if "iptat" in key:
            iptat.append((int(key[6:]), val))
        elif "vctat" in key:
            vctat.append((int(key[6:]), val))

    iptat.sort(key=lambda x: x[0])
    vctat.sort(key=lambda x: x[0])

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 4))
    ax1.plot([temp for temp, val in iptat], [val * 1e6 for temp, val in iptat])
    ax1.set_title("I PTAT")
    ax1.set_xlabel("Temperature [C]")
    ax1.set_ylabel("Current [uA]")
    ax1.grid(visible=True)
    ax2.plot([temp for temp, val in vctat], [val for temp, val in vctat])
    ax2.set_title("V CTAT")
    ax2.set_xlabel("Temperature [C]")
    ax2.set_ylabel("Voltage [V]")
    ax2.grid(visible=True)

    # Save new yaml file
    # with open(yamlfile,"w") as fo:
    #   yaml.dump(obj,fo)

    fig.savefig("../../docs/bandgap_measurement.svg")
