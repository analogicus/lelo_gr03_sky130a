#!/usr/bin/env python3
"""Plot OSCILLATOR_TB measurement results."""

import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _corners import parse_corner_label
from _plotstyle import PROC_COLORS, VAR_LW, VAR_STYLES, style_ax


def _parse_measurements(obj: dict) -> tuple[dict, dict, dict]:
    """Extract timing and current measurements from yaml object."""
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
    return t1_vals, t2_vals, idd_vals


def _parse_corner(cf: Path) -> tuple | None:
    """Read a corner YAML and return (label, proc, volt_var, temps, freq, idd_vals)."""
    base = cf.stem
    if re.search(r"_\d+$", base):
        return None

    with cf.open() as fi:
        obj = yaml.safe_load(fi)
    if not obj:
        return None

    label = re.sub(r"^tran_\w*Gt", "", base)
    proc, volt_var = parse_corner_label(label)

    t1_vals, t2_vals, idd_vals = _parse_measurements(obj)

    temps = sorted(t for t in t1_vals if t in t2_vals)
    freq = [1.0 / ((t2_vals[t] - t1_vals[t]) / 4.0) / 1e6 for t in temps]

    return label, proc, volt_var, temps, freq, idd_vals


def _find_nominal_slope(corners: list) -> float | None:
    """Find slope using only 0–70°C range (Ktt+Vt preferred)."""
    min_temps = 2

    def compute_slope(temps, freq):
        t_arr = np.array(temps, dtype=float)
        f_arr = np.array(freq)

        # Filter -30–120°C
        mask = (t_arr >= -40) & (t_arr <= 125)
        t_arr = t_arr[mask]
        f_arr = f_arr[mask]

        if len(t_arr) < min_temps:
            return None

        coeffs = np.polyfit(f_arr, t_arr, 1)
        return coeffs[0]

    # Prefer Ktt + Vt
    for proc, volt_var, temps, freq in [(c[1], c[2], c[3], c[4]) for c in corners]:
        if proc == "Ktt" and volt_var == "Vt":
            slope = compute_slope(temps, freq)
            if slope is not None:
                return slope

    # Fallback: first valid corner
    for _, _, temps, freq in [(c[1], c[2], c[3], c[4]) for c in corners]:
        slope = compute_slope(temps, freq)
        if slope is not None:
            return slope

    return None


def _plot_corner_data(axes: tuple, corners: list, nominal_slope: float | None) -> None:
    """Plot oscillator measurement data for all corners."""
    ax1, ax2, ax3, ax4 = axes
    min_temps = 2
    for _label, proc, volt_var, temps, freq, idd_vals in corners:
        short_label = proc + volt_var
        c = PROC_COLORS.get(proc, "#999999")
        ls = VAR_STYLES.get(volt_var, "-")
        lw = VAR_LW.get(volt_var, 1.0)
        kw = {"color": c, "linestyle": ls, "linewidth": lw}

        t_arr = np.array(temps, dtype=float)
        f_arr = np.array(freq)

        # Frequency vs temperature
        if temps and freq:
            ax1.plot(temps, freq, label=short_label, **kw)

        # 1-point calibration error (25C): fixed nominal slope, offset at 25C
        if len(temps) >= min_temps and nominal_slope is not None:
            f25 = np.interp(25, t_arr, f_arr)
            offset = 25 - nominal_slope * f25
            t_meas = nominal_slope * f_arr + offset
            ax2.plot(temps, t_meas - t_arr, **kw)

        # Active supply current
        idd_temps = sorted(idd_vals.keys())
        if idd_temps:
            ax3.plot(idd_temps, [abs(idd_vals[t]) * 1e6 for t in idd_temps], **kw)

        # 2-point calibration error (25C, 85C): line through both points
        if len(temps) >= min_temps:
            f25 = np.interp(25, t_arr, f_arr)
            f85 = np.interp(85, t_arr, f_arr)
            slope_2pt = (85 - 25) / (f85 - f25)
            offset_2pt = 25 - slope_2pt * f25
            t_meas_2pt = slope_2pt * f_arr + offset_2pt
            ax4.plot(temps, t_meas_2pt - t_arr, **kw)


def _setup_oscillator_axes(axes: tuple) -> None:
    """Configure oscillator plot axes titles, labels, and styling."""
    ax1, ax2, ax3, ax4 = axes
    ax1.set_title("Frequency vs Temperature")
    ax1.set_xlabel("Temperature [°C]")
    ax1.set_ylabel("Frequency [MHz]")
    style_ax(ax1)

    ax2.set_title("Temp Error (1-pt cal, 25°C)")
    ax2.set_xlabel("Temperature [°C]")
    ax2.set_ylabel("Error [°C]")
    ax2.axhline(y=10, color="#cccccc", linewidth=0.8, zorder=0)
    ax2.axhline(y=-10, color="#cccccc", linewidth=0.8, zorder=0)
    ax2.axvline(0, color="#aaaaaa", linewidth=0.8, linestyle="--")
    ax2.axvline(70, color="#aaaaaa", linewidth=0.8, linestyle="--")
    style_ax(ax2)

    ax3.set_title("Active Supply Current")
    ax3.set_xlabel("Temperature [°C]")
    ax3.set_ylabel("Current [µA]")
    style_ax(ax3)

    ax4.set_title("Temp Error (2-pt cal, 25°C & 85°C)")
    ax4.set_xlabel("Temperature [°C]")
    ax4.set_ylabel("Error [°C]")
    ax4.axhline(y=5, color="#cccccc", linewidth=0.8, zorder=0)
    ax4.axhline(y=-5, color="#cccccc", linewidth=0.8, zorder=0)
    ax4.axvline(0, color="#aaaaaa", linewidth=0.8, linestyle="--")
    ax4.axvline(70, color="#aaaaaa", linewidth=0.8, linestyle="--")
    style_ax(ax4)


def emit_latex_params(corners: list, nominal_slope: float | None, outpath: Path) -> None:
    """Worst-case 1-pt and 2-pt calibration error across non-MC PVT corners,
    using the project spec's definitions (l01_project.pdf, Section II.A):

      Kerrone — 1-pt cal: production tester measures f at 25 °C; runtime
                computes T_est = nominal_slope * (f - f_25) + 25.
                Spec scope: 0–70 °C. Spec target: ±10 °C.

      Kerrtwo — 2-pt cal: production tester measures f at 25 °C and 85 °C;
                runtime computes T_est along the line through both points.
                Spec scope: 0–70 °C. Spec target: ±5 °C.

    Worst |error| is taken across all post-layout PVT corners (excluding MC),
    restricted to the 0–70 °C subrange the spec measures accuracy in.

    \\providecommand means a hand value in params.tex always wins.
    """
    scope_lo, scope_hi = 0, 70
    cal_lo, cal_hi = 25, 85
    min_pts_for_cal = 2
    err_one_abs_max = 0.0
    err_two_abs_max = 0.0

    for _label, proc, _volt_var, temps, freq, _idd in corners:
        if "mm" in proc:  # skip Monte Carlo runs
            continue
        if len(temps) < min_pts_for_cal:
            continue
        t_arr = np.array(temps, dtype=float)
        f_arr = np.array(freq)
        in_scope = (t_arr >= scope_lo) & (t_arr <= scope_hi)
        if not in_scope.any():
            continue

        f_lo = np.interp(cal_lo, t_arr, f_arr)
        f_hi = np.interp(cal_hi, t_arr, f_arr)

        # 1-pt cal: fixed nominal slope, anchor at 25 °C
        if nominal_slope is not None:
            offset = cal_lo - nominal_slope * f_lo
            err_one = nominal_slope * f_arr + offset - t_arr
            err_one_abs_max = max(err_one_abs_max, float(np.max(np.abs(err_one[in_scope]))))

        # 2-pt cal: line through (25 °C, f_25) and (85 °C, f_85)
        slope_two = (cal_hi - cal_lo) / (f_hi - f_lo)
        offset_two = cal_lo - slope_two * f_lo
        err_two = slope_two * f_arr + offset_two - t_arr
        err_two_abs_max = max(err_two_abs_max, float(np.max(np.abs(err_two[in_scope]))))

    with outpath.open("w") as f:
        f.write("% Auto-generated by sim/OSCILLATOR_TB/tran.py — do not edit by hand.\n")
        f.write(f"% Worst-case 1-pt / 2-pt cal residual in {scope_lo}–{scope_hi} °C, per spec.\n")
        if nominal_slope is not None:
            f.write(f"\\providecommand{{\\valKerrone}}{{{err_one_abs_max:.1f}}}\n")
        f.write(f"\\providecommand{{\\valKerrtwo}}{{{err_two_abs_max:.1f}}}\n")


def main(name: str) -> None:
    """Plot oscillator measurement results."""
    yamlfile = Path(name).with_suffix(".yaml")
    outdir = Path("output_tran")
    corner_files = sorted(outdir.glob("tran_*.yaml"))

    # First pass: parse all corners, find typical slope
    corners = []
    seen = set()

    for cf in corner_files:
        result = _parse_corner(cf)
        if result is None:
            continue
        _label, proc, volt_var, _temps, _freq, _idd_vals = result

        dedup_key = proc + volt_var
        if dedup_key in seen:
            continue
        seen.add(dedup_key)

        corners.append(result)

    nominal_slope = _find_nominal_slope(corners)

    emit_latex_params(corners, nominal_slope, outdir / "sim_params.tex")

    # Second pass: plot
    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(
        2,
        2,
        figsize=(10, 7),
        facecolor="#fafafa",
    )
    for ax in (ax1, ax2, ax3, ax4):
        ax.set_facecolor("#fafafa")

    _plot_corner_data((ax1, ax2, ax3, ax4), corners, nominal_slope)
    _setup_oscillator_axes((ax1, ax2, ax3, ax4))

    handles, labels = ax1.get_legend_handles_labels()
    fig.legend(
        handles,
        labels,
        fontsize=7,
        frameon=False,
        loc="lower center",
        bbox_to_anchor=(0.5, -0.01),
        ncol=6,
    )
    fig.tight_layout(rect=(0, 0.05, 1, 1))
    fig.savefig(
        "../../svgs/oscillator_measurement.svg",
        bbox_inches="tight",
        facecolor=fig.get_facecolor(),
    )


if __name__ == "__main__":
    import sys
    name = sys.argv[1] if len(sys.argv) > 1 else "dummyargument"
    main(name)
