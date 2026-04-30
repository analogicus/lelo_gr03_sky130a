#!/usr/bin/env python3
"""Plot COMPARATOR_TB measurements as one IEEE-columnwidth PDF per metric.

Emits three PDFs to ../../svgs/:
* comparator_tdr.pdf  (rising propagation delay vs temperature)
* comparator_tdf.pdf  (falling propagation delay vs temperature)
* comparator_idd.pdf  (supply current vs temperature)
"""

import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _plotstyle import (
    IEEE_COLUMN_WIDTH_IN,
    IEEE_FIG_HEIGHT_IN,
    IEEE_TRACE,
    init_ieee_style,
)


def _extract(obj: dict) -> tuple[list, list, list]:
    tdr, tdf, idd = [], [], []
    for key, val in obj.items():
        if key.startswith("tdr_"):
            tdr.append((int(key.split("_")[-1]), float(val)))
        elif key.startswith("tdf_"):
            tdf.append((int(key.split("_")[-1]), float(val)))
        elif key.startswith("idd_"):
            idd.append((int(key.split("_")[-1]), abs(float(val))))
    tdr.sort(); tdf.sort(); idd.sort()
    return tdr, tdf, idd


def _save_panel(temps: list[int], values: list[float],
                ylabel: str, outname: str) -> None:
    fig, ax = plt.subplots(
        figsize=(IEEE_COLUMN_WIDTH_IN, IEEE_FIG_HEIGHT_IN),
        layout="constrained",
    )
    ax.plot(temps, values, color=IEEE_TRACE, marker="o", markersize=3)
    ax.set_xlabel(r"Temperature [\unit{\celsius}]")
    ax.set_ylabel(ylabel)
    ax.grid(visible=True)
    out = Path(__file__).resolve().parents[2] / "svgs" / outname
    out.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(out)
    plt.close(fig)
    print(f"saved {out}")


def main(name: str) -> None:
    init_ieee_style()

    yamlfile = Path(name).with_suffix(".yaml")
    outdir = yamlfile.parent
    corner_files = sorted(outdir.glob("tran_*.yaml"))
    if not corner_files:
        print(f"no tran_*.yaml in {outdir.resolve()}", file=sys.stderr)
        return

    all_tdr, all_tdf, all_idd = [], [], []
    for cf in corner_files:
        if re.search(r"_-?\d+$", cf.stem):
            continue
        with cf.open() as fi:
            obj = yaml.safe_load(fi)
        if not obj:
            continue
        tdr, tdf, idd = _extract(obj)
        all_tdr.extend(tdr); all_tdf.extend(tdf); all_idd.extend(idd)

    all_tdr.sort(); all_tdf.sort(); all_idd.sort()

    if all_tdr:
        _save_panel([t for t, _ in all_tdr], [v * 1e9 for _, v in all_tdr],
                    ylabel=r"$t_{d,\text{rise}}$ [\unit{\nano\second}]",
                    outname="comparator_tdr.pdf")
    if all_tdf:
        _save_panel([t for t, _ in all_tdf], [v * 1e9 for _, v in all_tdf],
                    ylabel=r"$t_{d,\text{fall}}$ [\unit{\nano\second}]",
                    outname="comparator_tdf.pdf")
    if all_idd:
        _save_panel([t for t, _ in all_idd], [v * 1e6 for _, v in all_idd],
                    ylabel=r"$I_\text{DD}$ [\unit{\micro\ampere}]",
                    outname="comparator_idd.pdf")


if __name__ == "__main__":
    name = sys.argv[1] if len(sys.argv) > 1 else "output_tran/tran"
    main(name)
