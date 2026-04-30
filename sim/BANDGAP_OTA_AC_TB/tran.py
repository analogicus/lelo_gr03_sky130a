#!/usr/bin/env python3
"""Plot BANDGAP_OTA AC analysis as one IEEE-columnwidth PDF per metric.

Emits three PDFs to ../../svgs/:
* bandgap_ota_ac_dcgain.pdf
* bandgap_ota_ac_gbw.pdf
* bandgap_ota_ac_pm.pdf
"""

import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _plotstyle import (
    IEEE_ACCENT,
    IEEE_COLUMN_WIDTH_IN,
    IEEE_FIG_HEIGHT_IN,
    IEEE_TRACE,
    init_ieee_style,
)


def _extract(obj: dict) -> dict[str, list[tuple[int, float]]]:
    out: dict[str, list[tuple[int, float]]] = {
        "dcgain": [], "ugbw": [], "pmraw": [],
    }
    for key, val in obj.items():
        m = re.match(r"(dcgain|ugbw|pmraw)_(-?\d+)$", key)
        if m:
            out[m.group(1)].append((int(m.group(2)), float(val)))
    for v in out.values():
        v.sort()
    return out


def _save_panel(temps: list[int], values: list[float],
                ylabel: str, outname: str,
                accent_target: float | None = None,
                accent_label: str | None = None) -> None:
    fig, ax = plt.subplots(
        figsize=(IEEE_COLUMN_WIDTH_IN, IEEE_FIG_HEIGHT_IN),
        layout="constrained",
    )
    ax.plot(temps, values, color=IEEE_TRACE, marker="o", markersize=3)
    if accent_target is not None:
        ax.axhline(accent_target, color=IEEE_ACCENT, linestyle="--",
                   label=accent_label)
        ax.legend(loc="best", frameon=False)
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

    aggregated: dict[str, list[tuple[int, float]]] = {
        "dcgain": [], "ugbw": [], "pmraw": [],
    }
    for cf in corner_files:
        if re.search(r"_-?\d+$", cf.stem):
            continue
        with cf.open() as fi:
            obj = yaml.safe_load(fi)
        if not obj:
            continue
        for k, v in _extract(obj).items():
            aggregated[k].extend(v)

    for k in aggregated:
        aggregated[k].sort()

    if aggregated["dcgain"]:
        temps = [t for t, _ in aggregated["dcgain"]]
        gains = [v for _, v in aggregated["dcgain"]]
        _save_panel(temps, gains,
                    ylabel=r"DC gain [\unit{dB}]",
                    outname="bandgap_ota_ac_dcgain.pdf")

    if aggregated["ugbw"]:
        temps = [t for t, _ in aggregated["ugbw"]]
        gbw_mhz = [v / 1e6 for _, v in aggregated["ugbw"]]
        _save_panel(temps, gbw_mhz,
                    ylabel=r"GBW [\unit{\mega\hertz}]",
                    outname="bandgap_ota_ac_gbw.pdf")

    if aggregated["pmraw"]:
        temps = [t for t, _ in aggregated["pmraw"]]
        pm = [(180 + v if v < 0 else v) for _, v in aggregated["pmraw"]]
        _save_panel(temps, pm,
                    ylabel=r"Phase margin [\unit{\degree}]",
                    outname="bandgap_ota_ac_pm.pdf",
                    accent_target=60,
                    accent_label=r"\qty{60}{\degree} stability target")


if __name__ == "__main__":
    name = sys.argv[1] if len(sys.argv) > 1 else "output_tran/tran"
    main(name)
