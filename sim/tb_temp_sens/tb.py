"""Plot tb_temp_sens behavioural sweep as four IEEE-columnwidth PDFs.

Emits to ../../svgs/:
* tempsens_freq.pdf     (frequency vs temperature)
* tempsens_count.pdf    (oscillator count over one f_ref period)
* tempsens_err1pt.pdf   (1-pt calibration residual error)
* tempsens_err2pt.pdf   (2-pt calibration residual error)
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _corners import parse_corner_label
from _plotstyle import (
    IEEE_ACCENT,
    IEEE_COLUMN_WIDTH_IN,
    IEEE_FIG_HEIGHT_IN,
    IEEE_LINE_WIDTH,
    PROC_COLORS,
    VAR_LW,
    VAR_STYLES,
    init_ieee_style,
    legend_above_two_rows,
    save_overlay_pdf,
)

OUTPUT_DIR = Path(__file__).resolve().parent / "output"
SVG_DIR = Path(__file__).resolve().parents[2] / "svgs"


CornerData = tuple[str, str, str, np.ndarray, np.ndarray]


def _load_corners() -> list[CornerData]:
    corners: list[CornerData] = []
    seen: set[str] = set()
    for csv_path in sorted(OUTPUT_DIR.glob("tb_*.csv")):
        corner = csv_path.stem.removeprefix("tb_")
        proc, volt_var = parse_corner_label(corner)
        dedup = proc + volt_var
        if dedup in seen:
            continue
        seen.add(dedup)
        df = pd.read_csv(csv_path)
        t_arr = df["temperature"].to_numpy(dtype=float)
        count = df["count"].to_numpy(dtype=float)
        freq = count * 32768.0
        corners.append((corner, proc, volt_var, t_arr, freq))
    return corners


def _find_nominal_slope(corners: list[CornerData]) -> float | None:
    for _, proc, volt, t, f in corners:
        if proc == "Ktt" and volt == "Vt" and len(t) >= 2:
            return float(np.polyfit(f, t, 1)[0])
    for _, _, _, t, f in corners:
        if len(t) >= 2:
            return float(np.polyfit(f, t, 1)[0])
    return None


def _save_err_pdf(traces, outname: str, accent_pm: float, ylim_abs: float):
    fig, ax = plt.subplots(
        figsize=(IEEE_COLUMN_WIDTH_IN, IEEE_FIG_HEIGHT_IN),
        layout="constrained",
    )
    seen: set[str] = set()
    for label, color, ls, lw, xs, ys in traces:
        kw = {"color": color, "linestyle": ls, "linewidth": lw}
        if label in seen:
            ax.plot(xs, ys, **kw)
        else:
            ax.plot(xs, ys, label=label, **kw)
            seen.add(label)
    ax.axhline(accent_pm, color=IEEE_ACCENT, linestyle="--",
               linewidth=IEEE_LINE_WIDTH,
               label="spec")
    ax.axhline(-accent_pm, color=IEEE_ACCENT, linestyle="--",
               linewidth=IEEE_LINE_WIDTH)
    ax.axvline(0, color="#9ca0b0", linestyle=":", linewidth=IEEE_LINE_WIDTH)
    ax.axvline(70, color="#9ca0b0", linestyle=":", linewidth=IEEE_LINE_WIDTH)
    ax.set_xlabel(r"Temperature [\unit{\celsius}]")
    ax.set_ylabel(r"Error [\unit{\celsius}]")
    ax.set_ylim(-ylim_abs, ylim_abs)
    ax.grid(visible=True)
    legend_above_two_rows(ax)
    out = SVG_DIR / outname
    fig.savefig(out)
    plt.close(fig)
    print(f"saved {out}")


def main() -> None:
    init_ieee_style()
    corners = _load_corners()
    if not corners:
        print(f"no tb_*.csv in {OUTPUT_DIR}", file=sys.stderr)
        return
    nominal_slope = _find_nominal_slope(corners)

    freq_traces, count_traces, err1_traces, err2_traces = [], [], [], []
    for _, proc, volt, t_arr, freq in corners:
        c = PROC_COLORS.get(proc, "#999999")
        ls = VAR_STYLES.get(volt, "-")
        lw = VAR_LW.get(volt, 1.0)
        dedup = proc + volt
        freq_traces.append((dedup, c, ls, lw, list(t_arr), [v / 1e6 for v in freq]))
        count_traces.append((dedup, c, ls, lw, list(t_arr), list(freq / 32768.0)))
        if len(t_arr) >= 2:
            f25 = float(np.interp(25, t_arr, freq))
            f85 = float(np.interp(85, t_arr, freq))
            if nominal_slope is not None:
                offset1 = 25 - nominal_slope * f25
                err1_traces.append((dedup, c, ls, lw, list(t_arr),
                                    list((nominal_slope * freq + offset1) - t_arr)))
            slope2 = (85 - 25) / (f85 - f25)
            offset2 = 25 - slope2 * f25
            err2_traces.append((dedup, c, ls, lw, list(t_arr),
                                list((slope2 * freq + offset2) - t_arr)))

    save_overlay_pdf(
        freq_traces,
        ylabel=r"Frequency [\unit{\mega\hertz}]",
        outname="tempsens_freq.pdf",
    )
    save_overlay_pdf(
        count_traces,
        ylabel=r"Count [LSB]",
        outname="tempsens_count.pdf",
    )
    if err1_traces:
        _save_err_pdf(err1_traces, "tempsens_err1pt.pdf",
                      accent_pm=10.0, ylim_abs=20)
    _save_err_pdf(err2_traces, "tempsens_err2pt.pdf",
                  accent_pm=5.0, ylim_abs=15)


if __name__ == "__main__":
    main()
