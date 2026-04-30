"""Shared matplotlib styling for per-testbench tran.py plots.

Two regimes:

* Legacy three/four-panel figures (`style_ax`, `PROC_COLORS`, `VAR_STYLES`,
  `VAR_LW`) for the existing tran.py scripts that pack multiple metrics into
  one SVG.
* Single-panel IEEE-styled PDFs (`init_ieee_style`, `IEEE_*` constants,
  `LATTE_*` palette) for newer scripts that emit one PDF per metric, sized to
  the IEEEtran [conference] columnwidth and rendered via `text.usetex=True`
  so axis labels match the document fonts.
"""

import math

import matplotlib as mpl
from matplotlib.axes import Axes


# ---------------------------------------------------------------------------
# Legacy multi-panel styling (unchanged, kept for existing tran.py scripts).
# ---------------------------------------------------------------------------

PROC_COLORS: dict[str, str] = {
    # Catppuccin Latte palette: cold → hot processes use cool → warm hues.
    "Kff":   "#d20f39",  # red    (fast/fast)
    "Kfs":   "#fe640b",  # peach
    "Ksf":   "#40a02b",  # green
    "Kss":   "#1e66f5",  # blue   (slow/slow)
    "Ktt":   "#4c4f69",  # text   (typical, dark neutral)
    "Kttmm": "#8839ef",  # mauve  (Monte-Carlo overlay)
}
VAR_STYLES: dict[str, str] = {"Vh": "-", "Vl": "--", "Vt": "-"}
VAR_LW: dict[str, float] = {"Vh": 1.2, "Vl": 1.2, "Vt": 1.8}


def style_ax(ax: Axes) -> None:
    ax.grid(visible=True, linewidth=0.4, alpha=0.5)
    ax.tick_params(labelsize=8)
    ax.title.set_fontsize(9)
    ax.xaxis.label.set_fontsize(8)
    ax.yaxis.label.set_fontsize(8)


# ---------------------------------------------------------------------------
# Single-panel IEEE styling (Catppuccin Latte palette + IEEEtran-matched
# fonts via usetex).
# ---------------------------------------------------------------------------

# IEEEtran [conference] columnwidth.
IEEE_COLUMN_WIDTH_PT = 252.0
IEEE_TEX_PT_PER_INCH = 72.27
IEEE_COLUMN_WIDTH_IN = IEEE_COLUMN_WIDTH_PT / IEEE_TEX_PT_PER_INCH

IEEE_GOLDEN_RATIO = (1 + math.sqrt(5)) / 2
IEEE_FIG_HEIGHT_IN = IEEE_COLUMN_WIDTH_IN / IEEE_GOLDEN_RATIO

IEEE_FIGURE_FONT_PT = 9
IEEE_LINE_WIDTH = 0.8
IEEE_GRID_LINE_WIDTH = 0.4

# Catppuccin Latte hex codes
LATTE_TEXT = "#4c4f69"
LATTE_SUBTEXT0 = "#6c6f85"
LATTE_SURFACE0 = "#ccd0da"
LATTE_BLUE = "#1e66f5"
LATTE_GREEN = "#40a02b"
LATTE_RED = "#d20f39"
LATTE_PEACH = "#fe640b"
LATTE_MAUVE = "#8839ef"

# Sensible default trace / accent / grid for single-panel plots.
IEEE_TRACE = LATTE_BLUE
IEEE_ACCENT = LATTE_RED
IEEE_GRID = LATTE_SURFACE0


def save_overlay_pdf(
    traces: list[tuple[str, str, str, float, list[int], list[float]]],
    ylabel: str,
    outname: str,
    accent_target: float | None = None,
    accent_label: str | None = None,
    legend: bool = True,
) -> None:
    """Save a single-panel IEEE-styled PDF with multiple PVT traces overlaid.

    Each trace is (label, color, linestyle, linewidth, x_values, y_values).
    Output goes to ../../svgs/<outname> relative to the calling testbench.
    """
    import matplotlib.pyplot as _plt
    from pathlib import Path as _Path

    fig, ax = _plt.subplots(
        figsize=(IEEE_COLUMN_WIDTH_IN, IEEE_FIG_HEIGHT_IN),
        layout="constrained",
    )
    seen_labels: set[str] = set()
    for label, color, ls, lw, xs, ys in traces:
        kw = {"color": color, "linestyle": ls, "linewidth": lw}
        if label in seen_labels:
            ax.plot(xs, ys, **kw)
        else:
            ax.plot(xs, ys, label=label, **kw)
            seen_labels.add(label)

    if accent_target is not None:
        ax.axhline(accent_target, color=IEEE_ACCENT, linestyle="--",
                   linewidth=IEEE_LINE_WIDTH,
                   label=accent_label)
    ax.set_xlabel(r"Temperature [\unit{\celsius}]")
    ax.set_ylabel(ylabel)
    ax.grid(visible=True)
    if legend and seen_labels:
        ax.legend(loc="best", frameon=False, ncol=2, fontsize=7)

    out = _Path.cwd().resolve()
    # Walk up to find the IP root by looking for a sibling 'svgs' directory.
    while out != out.parent and not (out / "svgs").is_dir():
        out = out.parent
    target = out / "svgs" / outname
    target.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(target)
    _plt.close(fig)
    print(f"saved {target}")


def init_ieee_style() -> None:
    """Set rcParams so single-panel PDFs match the IEEEtran [conference] body
    fonts and column width. Call this once at the top of `main()` in any
    tran.py that uses the IEEE_* constants."""
    mpl.rcParams.update({
        "text.usetex": True,
        "font.family": "serif",
        "text.latex.preamble": (
            r"\usepackage{newtxtext,newtxmath}"
            r"\usepackage{siunitx}"
        ),
        "font.size": IEEE_FIGURE_FONT_PT,
        "axes.labelsize": IEEE_FIGURE_FONT_PT,
        "axes.titlesize": IEEE_FIGURE_FONT_PT,
        "xtick.labelsize": IEEE_FIGURE_FONT_PT,
        "ytick.labelsize": IEEE_FIGURE_FONT_PT,
        "legend.fontsize": IEEE_FIGURE_FONT_PT,
        "lines.linewidth": IEEE_LINE_WIDTH,
        "grid.color": IEEE_GRID,
        "grid.linewidth": IEEE_GRID_LINE_WIDTH,
        "axes.spines.top": False,
        "axes.spines.right": False,
        "savefig.bbox": "tight",
        "savefig.pad_inches": 0,
        "savefig.dpi": 300,
    })
