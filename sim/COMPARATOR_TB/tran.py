#!/usr/bin/env python3
"""Plot COMPARATOR_TB measurement results: propagation delay and supply current."""

import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _corners import parse_corner_label
from _plotstyle import PROC_COLORS, VAR_LW, VAR_STYLES, style_ax


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
    proc, volt_var = parse_corner_label(label)

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


def main(name: str) -> None:
    yamlfile = Path(name).with_suffix(".yaml")
    outdir = yamlfile.parent
    corner_files = sorted(outdir.glob("tran_*.yaml"))

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
    style_ax(ax_tdr)

    ax_tdf.set_title("Propagation Delay (falling)")
    ax_tdf.set_xlabel("Temperature [°C]")
    ax_tdf.set_ylabel("Delay [ns]")
    style_ax(ax_tdf)

    ax_idd.set_title("Supply Current")
    ax_idd.set_xlabel("Temperature [°C]")
    ax_idd.set_ylabel("Current [µA]")
    style_ax(ax_idd)

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
