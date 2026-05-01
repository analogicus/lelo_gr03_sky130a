#!/usr/bin/env python3
"""Aggregate Monte Carlo runs of OSCILLATOR_TB.

Reads every ``tran_SchGtKttmmTtVt*.yaml`` under ``output_tran/``, computes
the two-point-calibrated temperature error for each sample, and emits:

* ``../../svgs/osc_mc_err2pt.pdf`` — error vs temperature, all samples + ±3σ
  envelope, with the ±5 °C spec lines.
* ``../../svgs/osc_mc_hist.pdf``  — histogram of worst-case |error| in
  0–70 °C across the sample population.
* ``output_tran/sim_params_mc.tex`` — ``\\valMcN``, ``\\valMcKerrtwoMean``,
  ``\\valMcKerrtwoSigma``, ``\\valMcKerrtwoUL`` for the report.

The 2-pt calibration matches ``tran.py``: anchors at 25 °C and 85 °C; the
worst-case is taken over the spec scope 0 °C to 70 °C.
"""

from __future__ import annotations

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _plotstyle import (  # noqa: E402
    IEEE_ACCENT,
    IEEE_COLUMN_WIDTH_IN,
    IEEE_FIG_HEIGHT_IN,
    IEEE_LINE_WIDTH,
    init_ieee_style,
    legend_above_two_rows,
)

CAL_LO, CAL_HI = 25, 85
SCOPE_LO, SCOPE_HI = 0, 70
SPEC_PM = 5.0


def _load_sample(path: Path) -> tuple[np.ndarray, np.ndarray] | None:
    with path.open() as fi:
        obj = yaml.safe_load(fi)
    if not obj:
        return None
    t1, t2 = {}, {}
    for k, v in obj.items():
        if k.startswith("t1_"):
            t1[int(k.split("_")[1])] = float(v)
        elif k.startswith("t2_"):
            t2[int(k.split("_")[1])] = float(v)
    temps = sorted(t for t in t1 if t in t2)
    if len(temps) < 2:
        return None
    # tran.meas captures rise 1 and rise 5 — four full periods.
    freq = np.array([1.0 / ((t2[t] - t1[t]) / 4.0) for t in temps])
    return np.array(temps, dtype=float), freq


def _cal2pt(temps: np.ndarray, freq: np.ndarray) -> np.ndarray:
    f_lo = float(np.interp(CAL_LO, temps, freq))
    f_hi = float(np.interp(CAL_HI, temps, freq))
    slope = (CAL_HI - CAL_LO) / (f_hi - f_lo)
    offset = CAL_LO - slope * f_lo
    return slope * freq + offset - temps


def main() -> None:
    init_ieee_style()
    here = Path(__file__).resolve().parent
    out_dir = here / "output_tran"
    samples = sorted(out_dir.glob("tran_SchGtKttmmTtVt*.yaml"))
    if not samples:
        sys.exit(f"no MC samples found under {out_dir}/")

    errors: list[tuple[np.ndarray, np.ndarray]] = []
    for s in samples:
        r = _load_sample(s)
        if r is None:
            continue
        temps, freq = r
        err = _cal2pt(temps, freq)
        errors.append((temps, err))

    n = len(errors)
    if n < 2:
        sys.exit(f"need at least 2 valid samples, got {n}")

    # Worst-case |error| per sample within spec scope.
    worst = []
    for temps, err in errors:
        in_scope = (temps >= SCOPE_LO) & (temps <= SCOPE_HI)
        worst.append(float(np.max(np.abs(err[in_scope]))))
    worst_arr = np.array(worst)
    mean = float(worst_arr.mean())
    sigma = float(worst_arr.std(ddof=1))
    p3s = mean + 3 * sigma

    # ±3σ envelope of error vs temperature.
    common_t = errors[0][0]
    stacked = np.stack([np.interp(common_t, t, e) for t, e in errors])
    env_mean = stacked.mean(axis=0)
    env_sigma = stacked.std(axis=0, ddof=1)

    svg_dir = here.parents[1] / "docs" / "latex_report" / "figures"
    svg_dir.mkdir(parents=True, exist_ok=True)

    # ---- error envelope PDF ----------------------------------------------
    fig, ax = plt.subplots(
        figsize=(IEEE_COLUMN_WIDTH_IN, IEEE_FIG_HEIGHT_IN),
        layout="constrained",
    )
    for temps, err in errors:
        ax.plot(temps, err, color="#5b6078", linewidth=0.5, alpha=0.45)
    ax.plot(common_t, env_mean, color=IEEE_ACCENT, linewidth=IEEE_LINE_WIDTH,
            label="mean")
    ax.plot(common_t, env_mean + 3 * env_sigma, color=IEEE_ACCENT,
            linestyle="--", linewidth=IEEE_LINE_WIDTH, label=r"$\pm 3\sigma$")
    ax.plot(common_t, env_mean - 3 * env_sigma, color=IEEE_ACCENT,
            linestyle="--", linewidth=IEEE_LINE_WIDTH)
    ax.axhline(SPEC_PM, color="#9ca0b0", linestyle=":",
               linewidth=IEEE_LINE_WIDTH,
               label="spec")
    ax.axhline(-SPEC_PM, color="#9ca0b0", linestyle=":",
               linewidth=IEEE_LINE_WIDTH)
    ax.axvline(SCOPE_LO, color="#9ca0b0", linestyle=":",
               linewidth=IEEE_LINE_WIDTH)
    ax.axvline(SCOPE_HI, color="#9ca0b0", linestyle=":",
               linewidth=IEEE_LINE_WIDTH)
    ax.set_xlabel(r"Temperature [\unit{\celsius}]")
    ax.set_ylabel(r"Error [\unit{\celsius}]")
    ax.grid(visible=True)
    legend_above_two_rows(ax)
    out = svg_dir / "osc_mc_err2pt.pdf"
    fig.savefig(out)
    plt.close(fig)
    print(f"saved {out} ({n} samples)")

    # ---- histogram PDF ---------------------------------------------------
    fig, ax = plt.subplots(
        figsize=(IEEE_COLUMN_WIDTH_IN, IEEE_FIG_HEIGHT_IN),
        layout="constrained",
    )
    ax.hist(worst_arr, bins=12, color="#8caaee", edgecolor="#414559",
            linewidth=0.6)
    ax.axvline(SPEC_PM, color=IEEE_ACCENT, linestyle="--",
               linewidth=IEEE_LINE_WIDTH,
               label="spec")
    ax.axvline(p3s, color="#40a02b", linestyle="-",
               linewidth=IEEE_LINE_WIDTH,
               label=rf"mean+3$\sigma$={p3s:.2f}")
    ax.set_xlabel(r"Worst $|K_{err,2}|$ in 0--70 \unit{\celsius} [\unit{\celsius}]")
    ax.set_ylabel("Samples")
    legend_above_two_rows(ax)
    out = svg_dir / "osc_mc_hist.pdf"
    fig.savefig(out)
    plt.close(fig)
    print(f"saved {out}")

    # ---- LaTeX params ----------------------------------------------------
    params_path = out_dir / "sim_params_mc.tex"
    with params_path.open("w") as fo:
        fo.write("% Auto-generated by sim/OSCILLATOR_TB/tran_mc.py — do not edit.\n")
        fo.write(f"\\providecommand{{\\valMcN}}{{{n}}}\n")
        fo.write(f"\\providecommand{{\\valMcKerrtwoMean}}{{{mean:.2f}}}\n")
        fo.write(f"\\providecommand{{\\valMcKerrtwoSigma}}{{{sigma:.2f}}}\n")
        fo.write(f"\\providecommand{{\\valMcKerrtwoUL}}{{{p3s:.2f}}}\n")
    print(f"saved {params_path}: N={n} mean={mean:.2f} sigma={sigma:.2f} 3s={p3s:.2f}")


if __name__ == "__main__":
    main()
