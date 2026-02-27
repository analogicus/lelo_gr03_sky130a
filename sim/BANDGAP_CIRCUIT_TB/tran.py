#!/usr/bin/env python3
import glob
import os
import re
import matplotlib.pyplot as plt
import yaml


def main(name):
    yamlfile = name + ".yaml"
    outdir = os.path.dirname(yamlfile)

    # Find all corner YAML files in the output directory, skip MC runs (_N.yaml)
    corner_files = sorted(glob.glob(os.path.join(outdir, "tran_*.yaml")))

    fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(14, 4))

    for cf in corner_files:
        # Skip Monte Carlo individual runs (ending in _N.yaml)
        base = os.path.splitext(os.path.basename(cf))[0]
        if re.search(r"_\d+$", base):
            continue

        with open(cf) as fi:
            obj = yaml.safe_load(fi)

        if not obj:
            continue

        # Extract corner label from filename (e.g. tran_SchGtKttTtVt -> KttTtVt)
        label = re.sub(r"^tran_\w*Gt", "", base)

        iptat = []
        vctat = []
        ileak = []
        for key, val in obj.items():
            temp = int(key.split("_")[-1])
            if key.startswith("iptat"):
                iptat.append((temp, val))
            elif key.startswith("vctat"):
                vctat.append((temp, val))
            elif key.startswith("ileak"):
                ileak.append((temp, val))

        iptat.sort(key=lambda x: x[0])
        vctat.sort(key=lambda x: x[0])
        ileak.sort(key=lambda x: x[0])

        if iptat:
            ax1.plot([t for t, _ in iptat], [v * 1e6 for _, v in iptat], label=label)
        if vctat:
            ax2.plot([t for t, _ in vctat], [v for _, v in vctat], label=label)
        if ileak:
            ax3.plot([t for t, _ in ileak], [abs(v) * 1e9 for _, v in ileak], label=label)

    ax1.set_title("I PTAT")
    ax1.set_xlabel("Temperature [C]")
    ax1.set_ylabel("Current [uA]")
    ax1.grid(visible=True)
    ax1.legend(fontsize="small")
    ax2.set_title("V CTAT")
    ax2.set_xlabel("Temperature [C]")
    ax2.set_ylabel("Voltage [V]")
    ax2.grid(visible=True)
    ax2.legend(fontsize="small")
    ax3.set_title("Leakage (power down)")
    ax3.set_xlabel("Temperature [C]")
    ax3.set_ylabel("Current [nA]")
    ax3.axhline(y=1, color="r", linestyle="--", label="1 nA spec")
    ax3.grid(visible=True)
    ax3.legend(fontsize="small")

    fig.tight_layout()
    fig.savefig("../../docs/bandgap_measurement.svg")
