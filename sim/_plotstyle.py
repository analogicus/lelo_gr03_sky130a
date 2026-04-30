"""Shared matplotlib styling for per-testbench tran.py plots."""

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


def style_ax(ax: Axes) -> None:
    ax.grid(visible=True, linewidth=0.4, alpha=0.5)
    ax.tick_params(labelsize=8)
    ax.title.set_fontsize(9)
    ax.xaxis.label.set_fontsize(8)
    ax.yaxis.label.set_fontsize(8)
