#!/usr/bin/env python3
"""Plot BANDGAP_CIRCUIT_TB measurement results."""

import re
from pathlib import Path

import matplotlib.pyplot as plt
import yaml
from matplotlib.axes import Axes

# Muted, high-contrast palette — distinct but cohesive
PROC_COLORS = {
    "Kff": "#c44e52",  # muted red
    "Kfs": "#dd8452",  # warm ochre
    "Ksf": "#55a868",  # sage green
    "Kss": "#4c72b0",  # steel blue
    "Ktt": "#636363",  # dark gray
    "Kttmm": "#8172b3",  # soft purple
}
# Solid = high voltage, dashed = low voltage, typical = solid
VAR_STYLES = {"Vh": "-", "Vl": "--", "Vt": "-"}
VAR_LW = {"Vh": 1.2, "Vl": 1.2, "Vt": 1.8}


def _style_ax(ax: Axes) -> None:
    ax.grid(visible=True, linewidth=0.4, alpha=0.5)
    ax.tick_params(labelsize=8)
    ax.title.set_fontsize(9)
    ax.xaxis.label.set_fontsize(8)
    ax.yaxis.label.set_fontsize(8)


def _extract_measurements(obj: dict) -> tuple[list, list, list, list]:
    """Extract temperature and measurement arrays from yaml object."""
    iptat = []
    vctat = []
    ileak = []
    iact = []
    for key, val in obj.items():
        temp = int(key.split("_")[-1])
        if key.startswith("iptat"):
            iptat.append((temp, val))
        elif key.startswith("vctat"):
            vctat.append((temp, val))
        elif key.startswith("ileak"):
            ileak.append((temp, val))
        elif key.startswith("iact"):
            iact.append((temp, val))
    return iptat, vctat, ileak, iact


def _setup_axes_labels(ax1: Axes, ax2: Axes, ax3: Axes, ax4: Axes) -> None:
    """Configure axes titles, labels, and styling."""
    ax1.set_title("PTAT Current")
    ax1.set_xlabel("Temperature [°C]")
    ax1.set_ylabel("Current [µA]")
    _style_ax(ax1)
    ax2.set_title("CTAT Voltage")
    ax2.set_xlabel("Temperature [°C]")
    ax2.set_ylabel("Voltage [V]")
    _style_ax(ax2)
    ax3.set_title("Power-Down Leakage")
    ax3.set_xlabel("Temperature [°C]")
    ax3.set_ylabel("Current [nA]")
    ax3.set_ylim(0, 2)
    _style_ax(ax3)
    ax4.set_title("Active Supply Current")
    ax4.set_xlabel("Temperature [°C]")
    ax4.set_ylabel("Current [µA]")
    _style_ax(ax4)


def _process_corner_file(
    cf: Path,
    seen: set,
    axes: tuple,
) -> None:
    """Process a single corner file and plot its data."""
    ax1, ax2, ax3, ax4 = axes
    base = cf.stem
    if re.search(r"_\d+$", base):
        return

    with cf.open() as fi:
        obj = yaml.safe_load(fi)
    if not obj:
        return

    label = re.sub(r"^tran_\w*Gt", "", base)

    m = re.match(r"(K\w\w(?:mm)?)(T\w)(V\w)", label)
    if m:
        proc, volt_var = m.group(1), m.group(3)
    else:
        proc, volt_var = "Ktt", "Vt"

    # Th and Tl produce identical results — deduplicate
    dedup_key = proc + volt_var
    if dedup_key in seen:
        return
    seen.add(dedup_key)

    short_label = proc + volt_var

    c = PROC_COLORS.get(proc, "#999999")
    ls = VAR_STYLES.get(volt_var, "-")
    lw = VAR_LW.get(volt_var, 1.0)

    iptat, vctat, ileak, iact = _extract_measurements(obj)

    iptat.sort(key=lambda x: x[0])
    vctat.sort(key=lambda x: x[0])
    ileak.sort(key=lambda x: x[0])
    iact.sort(key=lambda x: x[0])

    kw = {"color": c, "linestyle": ls, "linewidth": lw}

    if iptat:
        ax1.plot(
            [t for t, _ in iptat],
            [v * 1e6 for _, v in iptat],
            label=short_label,
            **kw,
        )
    if vctat:
        ax2.plot([t for t, _ in vctat], [v for _, v in vctat], **kw)
    if ileak:
        ax3.plot([t for t, _ in ileak], [abs(v) * 1e9 for _, v in ileak], **kw)
    if iact:
        ax4.plot([t for t, _ in iact], [abs(v) * 1e6 for _, v in iact], **kw)


def main(name: str) -> None:
    """Plot simulation results from corner yaml files."""
    yamlfile = Path(name).with_suffix(".yaml")
    outdir = yamlfile.parent

    corner_files = sorted(outdir.glob("tran_*.yaml"))

    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(
        2,
        2,
        figsize=(10, 7),
        facecolor="#fafafa",
    )
    for ax in (ax1, ax2, ax3, ax4):
        ax.set_facecolor("#fafafa")

    seen = set()

    for cf in corner_files:
        _process_corner_file(cf, seen, (ax1, ax2, ax3, ax4))

    _setup_axes_labels(ax1, ax2, ax3, ax4)

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
        "../../svgs/bandgap_measurement.svg",
        bbox_inches="tight",
        facecolor=fig.get_facecolor(),
    )
