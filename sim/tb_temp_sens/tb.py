"""Plot TempSens simulation results with calibration error analysis."""

from __future__ import annotations

import re
import sys
from pathlib import Path
from typing import TYPE_CHECKING

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.ticker import MultipleLocator
from scipy.interpolate import UnivariateSpline

if TYPE_CHECKING:
    from matplotlib.axes import Axes

PROC_COLORS: dict[str, str] = {
    "Kff": "#c44e52",
    "Kfs": "#dd8452",
    "Ksf": "#55a868",
    "Kss": "#4c72b0",
    "Ktt": "#636363",
    "Kttmm": "#8172b3",
}
VAR_STYLES: dict[str, str] = {"Vh": "-", "Vl": "--", "Vt": "-"}
VAR_LW: dict[str, float] = {"Vh": 1.2, "Vl": 1.2, "Vt": 1.8}

OUTPUT_DIR = Path(__file__).resolve().parent / "output"
SVG_PATH = Path(__file__).resolve().parent / "../../svgs/temp_sens_measurement.svg"


def _style_ax(ax: Axes) -> None:
    ax.grid(visible=True, linewidth=0.4, alpha=0.5)
    ax.tick_params(labelsize=8)
    ax.title.set_fontsize(9)
    ax.xaxis.label.set_fontsize(8)
    ax.yaxis.label.set_fontsize(8)


def _parse_corner_name(name: str) -> tuple[str, str]:
    """Extract (process, voltage_variant) from a corner label like KttTtVt."""
    m = re.search(r"(K\w\w(?:mm)?)(T\w)(V\w)", name)
    if m:
        return m.group(1), m.group(3)
    return "Ktt", "Vt"


CornerData = tuple[str, str, str, np.ndarray, np.ndarray]


def _load_corners() -> list[CornerData]:
    """Load all per-corner CSVs from the output directory."""
    corners: list[CornerData] = []
    seen: set[str] = set()

    for csv_path in sorted(OUTPUT_DIR.glob("tb_*.csv")):
        corner = csv_path.stem.removeprefix("tb_")
        proc, volt_var = _parse_corner_name(corner)

        dedup_key = proc + volt_var
        if dedup_key in seen:
            continue
        seen.add(dedup_key)

        df = pd.read_csv(csv_path)
        t_arr = df["temperature"].to_numpy(dtype=float)
        count = df["count"].to_numpy(dtype=float)
        freq = count * 32768.0
        corners.append((corner, proc, volt_var, t_arr, freq))

    return corners


def _find_nominal_slope(corners: list[CornerData]) -> float | None:
    """Find the typical slope from the Ktt+Vt corner."""
    min_points = 2
    for _, proc, volt_var, t_arr, freq in corners:
        if proc == "Ktt" and volt_var == "Vt" and len(t_arr) >= min_points:
            coeffs: np.ndarray = np.polyfit(freq, t_arr, 1)
            return float(coeffs[0])

    for _, _, _, t_arr, freq in corners:
        if len(t_arr) >= min_points:
            coeffs = np.polyfit(freq, t_arr, 1)
            return float(coeffs[0])
    return None



def _plot_corners(
    axes: tuple[Axes, Axes, Axes, Axes],
    corners: list[CornerData],
    nominal_slope: float | None,
) -> None:
    """Plot all corners on the four axes."""
    ax1, ax2, ax3, ax4 = axes
    min_points = 2

    for _, proc, volt_var, t_arr, freq in corners:
        short = proc + volt_var
        c = PROC_COLORS.get(proc, "#999999")
        ls = VAR_STYLES.get(volt_var, "-")
        lw = VAR_LW.get(volt_var, 1.0)

        ax1.plot(t_arr, freq / 1e6, label=short, color=c, linestyle=ls, linewidth=lw)
        t_fine = np.linspace(t_arr[0], t_arr[-1], 200)

        if len(t_arr) >= min_points and nominal_slope is not None:
            f25 = float(np.interp(25, t_arr, freq))
            offset = 25 - nominal_slope * f25
            t_meas = nominal_slope * freq + offset
            err = t_meas - t_arr
            spl = UnivariateSpline(t_arr, err, s=len(t_arr) * 2)
            ax2.plot(t_fine, spl(t_fine), color=c, linestyle=ls, linewidth=lw)

        count = freq / 32768.0
        ax3.plot(t_arr, count, color=c, linestyle=ls, linewidth=lw)

        if len(t_arr) >= min_points:
            f25 = float(np.interp(25, t_arr, freq))
            f85 = float(np.interp(85, t_arr, freq))
            slope_2pt = (85 - 25) / (f85 - f25)
            offset_2pt = 25 - slope_2pt * f25
            t_meas_2pt = slope_2pt * freq + offset_2pt
            err_2pt = t_meas_2pt - t_arr
            spl = UnivariateSpline(t_arr, err_2pt, s=len(t_arr) * 2)
            ax4.plot(t_fine, spl(t_fine), color=c, linestyle=ls, linewidth=lw)


def _setup_axes(axes: tuple[Axes, Axes, Axes, Axes]) -> None:
    ax1, ax2, ax3, ax4 = axes

    for ax in (ax1, ax2, ax3, ax4):
        ax.xaxis.set_major_locator(MultipleLocator(10))
    ax2.set_ylim(-20, 20)
    ax4.set_ylim(-15, 15)

    ax1.set_title("Frequency vs Temperature")
    ax1.set_xlabel("Temperature [\u00b0C]")
    ax1.set_ylabel("Frequency [MHz]")
    _style_ax(ax1)

    ax2.set_title("Temp Error (1-pt cal, 25\u00b0C, smoothed)")
    ax2.set_xlabel("Temperature [\u00b0C]")
    ax2.set_ylabel("Error [\u00b0C]")
    ax2.axhline(y=10, color="#cccccc", linewidth=0.8, zorder=0)
    ax2.axhline(y=-10, color="#cccccc", linewidth=0.8, zorder=0)
    _style_ax(ax2)

    ax3.set_title("Oscillator Count vs Temperature")
    ax3.set_xlabel("Temperature [\u00b0C]")
    ax3.set_ylabel("Count [LSB]")
    _style_ax(ax3)

    ax4.set_title("Temp Error (2-pt cal, 25\u00b0C & 85\u00b0C, smoothed)")
    ax4.set_xlabel("Temperature [\u00b0C]")
    ax4.set_ylabel("Error [\u00b0C]")
    ax4.axhline(y=5, color="#cccccc", linewidth=0.8, zorder=0)
    ax4.axhline(y=-5, color="#cccccc", linewidth=0.8, zorder=0)
    _style_ax(ax4)


def main() -> None:
    """Load all corner CSVs, plot calibration results, save SVG."""
    corners = _load_corners()
    nominal_slope = _find_nominal_slope(corners)

    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(
        2,
        2,
        figsize=(10, 7),
        facecolor="#fafafa",
    )
    for ax in (ax1, ax2, ax3, ax4):
        ax.set_facecolor("#fafafa")

    axes = (ax1, ax2, ax3, ax4)
    _plot_corners(axes, corners, nominal_slope)
    _setup_axes(axes)

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
    fig.savefig(SVG_PATH, bbox_inches="tight", facecolor=fig.get_facecolor())
    sys.stdout.write(f"Saved {SVG_PATH}\n")


if __name__ == "__main__":
    main()