#!/usr/bin/env python3
"""Plot COMPARATOR_TB measurement results: propagation delay and supply current."""

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


def _extract(obj: dict) -> tuple[list, list, list]:
    tdr, tdf, idd = [], [], []
    for key, val in obj.items():
        temp = int(key.split("_")[-1])
        if key.startswith("tdr"):
            tdr.append((temp, val))
        elif key.startswith("tdf"):
            tdf.append((temp, val))
        elif key.startswith("idd"):
            idd.append((temp, val))
    return tdr, tdf, idd


def _process_corner(cf: Path, seen: set, axes: tuple) -> None:
    ax_tdr, ax_tdf, ax_idd = axes
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

    tdr, tdf, idd = _extract(obj)
    tdr.sort()
    tdf.sort()
    idd.sort()

    if tdr:
        ax_tdr.plot([t for t, _ in tdr], [v * 1e9 for _, v in tdr],
                    label=dedup, **kw)
    if tdf:
        ax_tdf.plot([t for t, _ in tdf], [v * 1e9 for _, v in tdf], **kw)
    if idd:
        ax_idd.plot([t for t, _ in idd], [abs(v) * 1e6 for _, v in idd], **kw)


def emit_latex_params(corner_files: list[Path], outpath: Path) -> None:
    """Emit LaTeX \\providecommand lines for any report values this TB drives.

    Currently a no-op skeleton — COMPARATOR_TB does not yet feed values into
    docs/latex_report/params.tex. To wire up (e.g., max propagation delay or
    typical supply current):
      1. Compute the value from `corner_files`.
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

    fig, (ax_tdr, ax_tdf, ax_idd) = plt.subplots(
        1, 3, figsize=(13, 4), facecolor="#fafafa",
    )
    for ax in (ax_tdr, ax_tdf, ax_idd):
        ax.set_facecolor("#fafafa")

    seen = set()
    for cf in corner_files:
        _process_corner(cf, seen, (ax_tdr, ax_tdf, ax_idd))

    ax_tdr.set_title("Propagation Delay (rising)")
    ax_tdr.set_xlabel("Temperature [°C]")
    ax_tdr.set_ylabel("Delay [ns]")
    _style_ax(ax_tdr)

    ax_tdf.set_title("Propagation Delay (falling)")
    ax_tdf.set_xlabel("Temperature [°C]")
    ax_tdf.set_ylabel("Delay [ns]")
    _style_ax(ax_tdf)

    ax_idd.set_title("Supply Current")
    ax_idd.set_xlabel("Temperature [°C]")
    ax_idd.set_ylabel("Current [µA]")
    _style_ax(ax_idd)

    handles, labels = ax_tdr.get_legend_handles_labels()
    fig.legend(handles, labels, fontsize=7, frameon=False,
               loc="lower center", bbox_to_anchor=(0.5, -0.02), ncol=8)
    fig.tight_layout(rect=(0, 0.05, 1, 1))
    fig.savefig("../../svgs/comparator_measurement.svg",
                bbox_inches="tight", facecolor=fig.get_facecolor())


if __name__ == "__main__":
    import sys
    name = sys.argv[1] if len(sys.argv) > 1 else "dummyargument"
    main(name)
