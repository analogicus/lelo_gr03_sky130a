#!/usr/bin/env python3
"""Post-process an xschem SVG to fit the viewBox tightly around all content."""

import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

import defusedxml.ElementTree


def _coords_from_d(d: str) -> tuple[list[float], list[float]]:
    """Extract all numeric coordinate pairs from a path d attribute."""
    nums = re.findall(r"[-+]?\d*\.?\d+", d)
    floats = [float(n) for n in nums]
    xs = floats[0::2]
    ys = floats[1::2]
    return xs, ys


def compute_bbox(svg_path: Path | str) -> tuple[float, float, float, float]:
    """Compute the bounding box of all visible SVG elements."""
    ET.register_namespace("", "http://www.w3.org/2000/svg")
    ET.register_namespace("xlink", "http://www.w3.org/1999/xlink")
    tree = defusedxml.ElementTree.parse(svg_path)
    root = tree.getroot()

    all_x, all_y = [], []

    for path in root.iter("{http://www.w3.org/2000/svg}path"):
        d = path.get("d", "")
        xs, ys = _coords_from_d(d)
        all_x.extend(xs)
        all_y.extend(ys)

    for circle in root.iter("{http://www.w3.org/2000/svg}circle"):
        cx = float(circle.get("cx", 0))
        cy = float(circle.get("cy", 0))
        r = float(circle.get("r", 0))
        all_x.extend([cx - r, cx + r])
        all_y.extend([cy - r, cy + r])

    for rect in root.iter("{http://www.w3.org/2000/svg}rect"):
        x = float(rect.get("x", 0))
        y = float(rect.get("y", 0))
        w = float(rect.get("width", 0))
        h = float(rect.get("height", 0))
        # Skip background rect (covers full canvas)
        canvas_width = 900
        canvas_height = 600
        if w >= canvas_width and h >= canvas_height:
            continue
        all_x.extend([x, x + w])
        all_y.extend([y, y + h])

    for text in root.iter("{http://www.w3.org/2000/svg}text"):
        t = text.get("transform", "")
        m = re.search(r"translate\(([\d.e+-]+)[,\s]+([\d.e+-]+)\)", t)
        if m:
            tx, ty = float(m.group(1)), float(m.group(2))
            font_size = float(text.get("font-size", 10))
            content = text.text or ""
            est_width = len(content) * font_size * 0.55
            all_x.extend([tx, tx + est_width])
            all_y.extend([ty - font_size, ty])

    for line in root.iter("{http://www.w3.org/2000/svg}line"):
        all_x.extend([float(line.get("x1", 0)), float(line.get("x2", 0))])
        all_y.extend([float(line.get("y1", 0)), float(line.get("y2", 0))])

    return min(all_x), min(all_y), max(all_x), max(all_y)


def fit_svg(svg_path: Path | str, padding: int = 15) -> None:
    """Fit SVG viewBox tightly around visible content."""
    x_min, y_min, x_max, y_max = compute_bbox(svg_path)

    vb_x = x_min - padding
    vb_y = y_min - padding
    vb_w = (x_max - x_min) + 2 * padding
    vb_h = (y_max - y_min) + 2 * padding

    svg_path_obj = Path(svg_path)
    with svg_path_obj.open() as f:
        content = f.read()

    # Replace the opening <svg> tag: set viewBox and remove fixed width/height
    content = re.sub(
        r'(<svg\b[^>]*?)(\s*width="[^"]*")?(\s*height="[^"]*")?([^>]*>)',
        lambda m: re.sub(
            r'\s*width="[^"]*"',
            "",
            re.sub(r'\s*height="[^"]*"', "", m.group(0)),
        ).replace(
            "<svg",
            f'<svg viewBox="{vb_x:.2f} {vb_y:.2f} {vb_w:.2f} {vb_h:.2f}"',
            1,
        ),
        content,
        count=1,
    )

    # Expand the background rect to cover the viewBox
    content = re.sub(
        r'(<rect class="l0" )x="[^"]*" y="[^"]*" width="[^"]*" height="[^"]*"',
        f'\\1x="{vb_x:.2f}" y="{vb_y:.2f}" width="{vb_w:.2f}" height="{vb_h:.2f}"',
        content,
        count=1,
    )

    with svg_path_obj.open("w") as f:
        f.write(content)


if __name__ == "__main__":
    for path in sys.argv[1:]:
        fit_svg(path)
