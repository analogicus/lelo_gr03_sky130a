#!/usr/bin/env python3
"""Plot COMPARATOR_TB measurements as one IEEE-columnwidth PDF per metric.

Emits three PDFs to ../../svgs/, one per metric, overlaying every PVT corner:
* comparator_tdr.pdf  (rising propagation delay vs temperature)
* comparator_tdf.pdf  (falling propagation delay vs temperature)
* comparator_idd.pdf  (supply current vs temperature)
"""

import re
import sys
from pathlib import Path

import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from _corners import parse_corner_label
from _plotstyle import (
    PROC_COLORS,
    VAR_LW,
    VAR_STYLES,
    init_ieee_style,
    save_overlay_pdf,
)


def _extract(obj: dict) -> dict[str, list[tuple[int, float]]]:
    out: dict[str, list[tuple[int, float]]] = {"tdr": [], "tdf": [], "idd": []}
    for key, val in obj.items():
        m = re.match(r"(tdr|tdf|idd)_(-?\d+)$", key)
        if m:
            out[m.group(1)].append((int(m.group(2)), float(val)))
    for v in out.values():
        v.sort()
    return out


def _build_traces(corner_files: list[Path]):
    """Return per-metric list of (label, color, linestyle, linewidth, xs, ys).
    Deduplicated by proc+volt so Th/Tl runs collapse."""
    by_metric: dict[str, list] = {k: [] for k in ("tdr", "tdf", "idd")}
    seen: set[str] = set()
    for cf in corner_files:
        base = cf.stem
        if re.search(r"_-?\d+$", base):
            continue
        with cf.open() as fi:
            obj = yaml.safe_load(fi)
        if not obj:
            continue
        label = re.sub(r"^tran_\w*Gt", "", base)
        proc, volt_var = parse_corner_label(label)
        dedup = proc + volt_var
        if dedup in seen:
            continue
        seen.add(dedup)

        c = PROC_COLORS.get(proc, "#999999")
        ls = VAR_STYLES.get(volt_var, "-")
        lw = VAR_LW.get(volt_var, 1.0)
        data = _extract(obj)

        for metric, points in data.items():
            if not points:
                continue
            xs = [t for t, _ in points]
            if metric == "tdr" or metric == "tdf":
                ys = [v * 1e9 for _, v in points]
            else:  # idd
                ys = [abs(v) * 1e6 for _, v in points]
            by_metric[metric].append((dedup, c, ls, lw, xs, ys))
    return by_metric


def main(name: str) -> None:
    init_ieee_style()
    yamlfile = Path(name).with_suffix(".yaml")
    outdir = yamlfile.parent
    corner_files = sorted(outdir.glob("tran_*.yaml"))
    if not corner_files:
        print(f"no tran_*.yaml in {outdir.resolve()}", file=sys.stderr)
        return

    by_metric = _build_traces(corner_files)

    if by_metric["tdr"]:
        save_overlay_pdf(
            by_metric["tdr"],
            ylabel=r"$t_{d,\text{rise}}$ [\unit{\nano\second}]",
            outname="comparator_tdr.pdf",
        )
    if by_metric["tdf"]:
        save_overlay_pdf(
            by_metric["tdf"],
            ylabel=r"$t_{d,\text{fall}}$ [\unit{\nano\second}]",
            outname="comparator_tdf.pdf",
        )
    if by_metric["idd"]:
        save_overlay_pdf(
            by_metric["idd"],
            ylabel=r"$I_\text{DD}$ [\unit{\micro\ampere}]",
            outname="comparator_idd.pdf",
        )


if __name__ == "__main__":
    name = sys.argv[1] if len(sys.argv) > 1 else "output_tran/tran"
    main(name)
