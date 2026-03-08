#!/usr/bin/env python3
import glob
import os
import re
import numpy as np
import matplotlib.pyplot as plt
import yaml


# Muted, high-contrast palette — matches bandgap plots
PROC_COLORS = {
    "Kff": "#c44e52",   # muted red
    "Kfs": "#dd8452",   # warm ochre
    "Ksf": "#55a868",   # sage green
    "Kss": "#4c72b0",   # steel blue
    "Ktt": "#636363",   # dark gray
    "Kttmm": "#8172b3", # soft purple
}
VAR_STYLES = {"Vh": "-", "Vl": "--", "Vt": "-"}
VAR_LW = {"Vh": 1.2, "Vl": 1.2, "Vt": 1.8}


def _style_ax(ax):
    ax.grid(visible=True, linewidth=0.4, alpha=0.5)
    ax.tick_params(labelsize=8)
    ax.title.set_fontsize(9)
    ax.xaxis.label.set_fontsize(8)
    ax.yaxis.label.set_fontsize(8)


def _parse_corner(cf):
    """Read a corner YAML and return (label, proc, volt_var, temps, freq, idd_vals)."""
    base = os.path.splitext(os.path.basename(cf))[0]
    if re.search(r"_\d+$", base):
        return None

    with open(cf) as fi:
        obj = yaml.safe_load(fi)
    if not obj:
        return None

    label = re.sub(r"^tran_\w*Gt", "", base)
    m = re.match(r"(K\w\w(?:mm)?)(T\w)(V\w)", label)
    if m:
        proc, volt_var = m.group(1), m.group(3)
    else:
        proc, volt_var = "Ktt", "Vt"

    t1_vals = {}
    t2_vals = {}
    idd_vals = {}
    for key, val in obj.items():
        if key.startswith("t1_"):
            t1_vals[int(key.split("_")[1])] = float(val)
        elif key.startswith("t2_"):
            t2_vals[int(key.split("_")[1])] = float(val)
        elif key.startswith("idd_"):
            idd_vals[int(key.split("_")[1])] = float(val)

    temps = sorted(t for t in t1_vals if t in t2_vals)
    freq = [1.0 / ((t2_vals[t] - t1_vals[t]) / 4.0) / 1e6 for t in temps]

    return label, proc, volt_var, temps, freq, idd_vals


def main(name):
    yamlfile = name + ".yaml"
    outdir = os.path.dirname(yamlfile)
    corner_files = sorted(glob.glob(os.path.join(outdir, "tran_*.yaml")))

    # First pass: parse all corners, find typical slope
    corners = []
    seen = set()
    nominal_slope = None

    for cf in corner_files:
        result = _parse_corner(cf)
        if result is None:
            continue
        label, proc, volt_var, temps, freq, idd_vals = result

        dedup_key = proc + volt_var
        if dedup_key in seen:
            continue
        seen.add(dedup_key)

        corners.append(result)

        # Get nominal slope from typical corner (KttVt)
        if proc == "Ktt" and volt_var == "Vt" and len(temps) >= 2:
            t_arr = np.array(temps, dtype=float)
            f_arr = np.array(freq)
            # slope = dT/df from linear fit
            coeffs = np.polyfit(f_arr, t_arr, 1)
            nominal_slope = coeffs[0]  # degC per MHz

    if nominal_slope is None:
        print("Warning: typical corner not found, using first corner for slope")
        for _, _, _, temps, freq, _ in corners:
            if len(temps) >= 2:
                coeffs = np.polyfit(np.array(freq), np.array(temps, dtype=float), 1)
                nominal_slope = coeffs[0]
                break

    # Second pass: plot
    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(10, 7),
                                                   facecolor="#fafafa")
    for ax in (ax1, ax2, ax3, ax4):
        ax.set_facecolor("#fafafa")

    for label, proc, volt_var, temps, freq, idd_vals in corners:
        short_label = proc + volt_var
        c = PROC_COLORS.get(proc, "#999999")
        ls = VAR_STYLES.get(volt_var, "-")
        lw = VAR_LW.get(volt_var, 1.0)
        kw = dict(color=c, linestyle=ls, linewidth=lw)

        t_arr = np.array(temps, dtype=float)
        f_arr = np.array(freq)

        # Frequency vs temperature
        if temps and freq:
            ax1.plot(temps, freq, label=short_label, **kw)

        # 1-point calibration error (25C): fixed nominal slope, offset at 25C
        if len(temps) >= 2 and nominal_slope is not None:
            f25 = np.interp(25, t_arr, f_arr)
            offset = 25 - nominal_slope * f25
            t_meas = nominal_slope * f_arr + offset
            ax2.plot(temps, t_meas - t_arr, **kw)

        # Active supply current
        idd_temps = sorted(idd_vals.keys())
        if idd_temps:
            ax3.plot(idd_temps, [abs(idd_vals[t]) * 1e6 for t in idd_temps],
                     **kw)

        # 2-point calibration error (25C, 85C): line through both points
        if len(temps) >= 2:
            f25 = np.interp(25, t_arr, f_arr)
            f85 = np.interp(85, t_arr, f_arr)
            slope_2pt = (85 - 25) / (f85 - f25)
            offset_2pt = 25 - slope_2pt * f25
            t_meas_2pt = slope_2pt * f_arr + offset_2pt
            ax4.plot(temps, t_meas_2pt - t_arr, **kw)

    ax1.set_title("Frequency vs Temperature")
    ax1.set_xlabel("Temperature [\u00b0C]")
    ax1.set_ylabel("Frequency [MHz]")
    _style_ax(ax1)

    ax2.set_title("Temp Error (1-pt cal, 25\u00b0C)")
    ax2.set_xlabel("Temperature [\u00b0C]")
    ax2.set_ylabel("Error [\u00b0C]")
    ax2.axhline(y=10, color="#cccccc", linewidth=0.8, zorder=0)
    ax2.axhline(y=-10, color="#cccccc", linewidth=0.8, zorder=0)
    _style_ax(ax2)

    ax3.set_title("Active Supply Current")
    ax3.set_xlabel("Temperature [\u00b0C]")
    ax3.set_ylabel("Current [\u00b5A]")
    _style_ax(ax3)

    ax4.set_title("Temp Error (2-pt cal, 25\u00b0C & 85\u00b0C)")
    ax4.set_xlabel("Temperature [\u00b0C]")
    ax4.set_ylabel("Error [\u00b0C]")
    ax4.axhline(y=5, color="#cccccc", linewidth=0.8, zorder=0)
    ax4.axhline(y=-5, color="#cccccc", linewidth=0.8, zorder=0)
    _style_ax(ax4)

    handles, labels = ax1.get_legend_handles_labels()
    fig.legend(handles, labels, fontsize=7, frameon=False,
               loc="lower center", bbox_to_anchor=(0.5, -0.01), ncol=6)
    fig.tight_layout(rect=(0, 0.05, 1, 1))
    fig.savefig("../../svgs/oscillator_measurement.svg", bbox_inches="tight",
                facecolor=fig.get_facecolor())


if __name__ == "__main__":
    import sys
    main(sys.argv[1])
