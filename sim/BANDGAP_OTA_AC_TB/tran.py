#!/usr/bin/env python3
"""Plot BANDGAP_OTA AC analysis: DC gain, GBW, phase margin vs temperature."""

import re
from pathlib import Path

import matplotlib.pyplot as plt
import yaml
from matplotlib.axes import Axes

PROC_COLORS = {
    "Kff": "#c44e52",
    "Kfs": "#dd8452",
    "Ksf": "#55a868",
    "Kss": "#4c72b0",
    "Ktt": "#636363",
    "Kttmm": "#8172b3",
}
VAR_STYLES = {"Vh": "-", "Vl": "--", "Vt": "-"}
VAR_LW = {"Vh": 1.2, "Vl": 1.2, "Vt": 1.8}


def _style_ax(ax: Axes) -> None:
    ax.grid(visible=True, linewidth=0.4, alpha=0.5)
    ax.tick_params(labelsize=8)
    ax.title.set_fontsize(9)
    ax.xaxis.label.set_fontsize(8)
    ax.yaxis.label.set_fontsize(8)


def _extract(obj: dict) -> dict[str, list[tuple[int, float]]]:
    out: dict[str, list[tuple[int, float]]] = {
        "dcgain": [], "ugbw": [], "pmraw": [], "f3db": [],
    }
    for key, val in obj.items():
        m = re.match(r"(dcgain|ugbw|pmraw|f3db)_(-?\d+)$", key)
        if m:
            out[m.group(1)].append((int(m.group(2)), float(val)))
    for v in out.values():
        v.sort()
    return out


def _process_corner(cf: Path, seen: set, axes: tuple) -> None:
    ax_g, ax_b, ax_p = axes
    base = cf.stem
    if re.search(r"_\d+$", base):
        return

    with cf.open() as fi:
        obj = yaml.safe_load(fi)
    if not obj:
        return

    label = re.sub(r"^tran_\w*Gt", "", base)
    m = re.match(r"(K\w\w(?:mm)?)(T\w)(V\w)", label)
    proc, volt_var = (m.group(1), m.group(3)) if m else ("Ktt", "Vt")

    dedup = proc + volt_var
    if dedup in seen:
        return
    seen.add(dedup)

    c = PROC_COLORS.get(proc, "#999999")
    ls = VAR_STYLES.get(volt_var, "-")
    lw = VAR_LW.get(volt_var, 1.0)
    kw = {"color": c, "linestyle": ls, "linewidth": lw}

    data = _extract(obj)

    if data["dcgain"]:
        ax_g.plot([t for t, _ in data["dcgain"]], [v for _, v in data["dcgain"]],
                  label=dedup, **kw)
    if data["ugbw"]:
        ax_b.plot([t for t, _ in data["ugbw"]], [v / 1e6 for _, v in data["ugbw"]],
                  **kw)
    if data["pmraw"]:
        # pmraw = phase at GBW. PM = 180 + pmraw for inverting; sign convention varies.
        ax_p.plot([t for t, _ in data["pmraw"]],
                  [180 + v if v < 0 else v for _, v in data["pmraw"]], **kw)


def emit_latex_params(corner_files: list[Path], outpath: Path) -> None:
    """Emit LaTeX \\providecommand lines for any report values this TB drives.

    Currently a no-op skeleton — BANDGAP_OTA_AC_TB does not yet feed values
    into docs/latex_report/params.tex. To wire up a value (e.g., min DC gain
    or worst phase margin):
      1. Compute it from `corner_files`.
      2. Open `outpath` and write `\\providecommand{{\\valX}}{{value}}`.
      3. Add `\\InputIfFileExists{...sim_params.tex}{}{}` in params.tex.
    """
    _ = corner_files, outpath  # unused until populated
    return


def main(name: str) -> None:
    yamlfile = Path(name).with_suffix(".yaml")
    outdir = yamlfile.parent
    corner_files = sorted(outdir.glob("tran_*.yaml"))

    emit_latex_params(corner_files, outdir / "sim_params.tex")

    fig, (ax_g, ax_b, ax_p) = plt.subplots(
        1, 3, figsize=(13, 4), facecolor="#fafafa",
    )
    for ax in (ax_g, ax_b, ax_p):
        ax.set_facecolor("#fafafa")

    seen = set()
    for cf in corner_files:
        _process_corner(cf, seen, (ax_g, ax_b, ax_p))

    ax_g.set_title("DC Gain")
    ax_g.set_xlabel("Temperature [°C]")
    ax_g.set_ylabel("Gain [dB]")
    _style_ax(ax_g)

    ax_b.set_title("Unity-Gain Bandwidth")
    ax_b.set_xlabel("Temperature [°C]")
    ax_b.set_ylabel("GBW [MHz]")
    _style_ax(ax_b)

    ax_p.set_title("Phase Margin")
    ax_p.set_xlabel("Temperature [°C]")
    ax_p.set_ylabel("PM [°]")
    ax_p.axhline(60, color="#cccccc", linewidth=0.8, zorder=0)
    ax_p.axhline(45, color="#cccccc", linewidth=0.8, zorder=0)
    _style_ax(ax_p)

    handles, labels = ax_g.get_legend_handles_labels()
    fig.legend(handles, labels, fontsize=7, frameon=False,
               loc="lower center", bbox_to_anchor=(0.5, -0.02), ncol=8)
    fig.tight_layout(rect=(0, 0.05, 1, 1))
    fig.savefig("../../svgs/bandgap_ota_ac_measurement.svg",
                bbox_inches="tight", facecolor=fig.get_facecolor())


if __name__ == "__main__":
    import sys
    name = sys.argv[1] if len(sys.argv) > 1 else "dummyargument"
    main(name)
