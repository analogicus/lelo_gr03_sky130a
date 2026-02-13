#!/usr/bin/env python3
"""Read ngspice raw files from temperature sweep and plot I_PTAT and V_CTAT vs temperature."""

import glob
import os
import re
import csv
import cicsim
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

RAW_DIR = os.path.join(os.path.dirname(__file__), "output_tran")
RAW_PATTERN = os.path.join(RAW_DIR, "tran_SchGtKttTtVt_*.raw")
CSV_OUT = os.path.join(RAW_DIR, "temp_sweep.csv")

def extract_temp(filename):
    """Extract temperature from filename like tran_SchGtKttTtVt_-40.raw"""
    m = re.search(r'_(-?\d+)\.raw$', filename)
    return int(m.group(1)) if m else None

def main():
    raw_files = sorted(glob.glob(RAW_PATTERN), key=lambda f: extract_temp(f))

    temps = []
    iptat_vals = []
    vctat_vals = []

    for rawfile in raw_files:
        temp = extract_temp(rawfile)
        if temp is None:
            continue

        df = cicsim.toDataFrame(rawfile)

        # Average over last 20% of simulation (steady state)
        n = len(df)
        start = int(0.8 * n)

        iptat = df['i(vptat)'].iloc[start:].mean()
        vctat = df['v(v_ctat)'].iloc[start:].mean()

        temps.append(temp)
        iptat_vals.append(iptat)
        vctat_vals.append(vctat)

        print(f"T={temp:4d}C  I_PTAT={iptat:.4e} A  V_CTAT={vctat:.4f} V")

    # Save to CSV
    with open(CSV_OUT, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['Temp_C', 'I_PTAT', 'V_CTAT'])
        for t, i, v in zip(temps, iptat_vals, vctat_vals):
            writer.writerow([t, f"{i:.6e}", f"{v:.6f}"])
    print(f"\nCSV saved to {CSV_OUT}")

    # Plot
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))

    ax1.plot(temps, [i * 1e6 for i in iptat_vals], 'o-', color='tab:blue')
    ax1.set_title("PTAT Current vs Temperature")
    ax1.set_xlabel("Temperature (°C)")
    ax1.set_ylabel("I_PTAT (µA)")
    ax1.grid(True)

    ax2.plot(temps, vctat_vals, 'o-', color='tab:red')
    ax2.set_title("Bandgap Voltage vs Temperature")
    ax2.set_xlabel("Temperature (°C)")
    ax2.set_ylabel("V_CTAT (V)")
    ax2.grid(True)

    fig.tight_layout()
    fig.savefig(os.path.join(RAW_DIR, "ptat_current.png"), dpi=150)
    fig.savefig(os.path.join(RAW_DIR, "bandgap_voltage.png"), dpi=150)
    print(f"Plots saved to {RAW_DIR}/")

    plt.show()

if __name__ == "__main__":
    main()
