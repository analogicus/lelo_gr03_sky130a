#!/usr/bin/env python3
"""Plot BANDGAP_OTA AC analysis: DC gain, GBW, phase margin vs temperature."""

import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _corners import parse_corner_label
from _plotstyle import PROC_COLORS, VAR_LW, VAR_STYLES, style_ax


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
    proc, volt_var = parse_corner_label(label)

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


def main(name: str) -> None:
    yamlfile = Path(name).with_suffix(".yaml")
    outdir = yamlfile.parent
    corner_files = sorted(outdir.glob("tran_*.yaml"))

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
    style_ax(ax_g)

    ax_b.set_title("Unity-Gain Bandwidth")
    ax_b.set_xlabel("Temperature [°C]")
    ax_b.set_ylabel("GBW [MHz]")
    style_ax(ax_b)

    ax_p.set_title("Phase Margin")
    ax_p.set_xlabel("Temperature [°C]")
    ax_p.set_ylabel("PM [°]")
    ax_p.axhline(60, color="#cccccc", linewidth=0.8, zorder=0)
    ax_p.axhline(45, color="#cccccc", linewidth=0.8, zorder=0)
    style_ax(ax_p)

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
