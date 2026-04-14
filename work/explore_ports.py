"""Dump label rectangles per net in the BIAS_CIRCUIT GDS."""
import pya

ly = pya.Layout()
ly.read("gds/BIAS_CIRCUIT.gds")
top = ly.top_cell()

# Find labels (shapes.each for text objects)
LABELS = {
    "li1.label": (67, 5),  # sky130 convention
    "li1.pin": (67, 16),
    "met1.label": (68, 5),
    "met1.pin": (68, 16),
    "met2.label": (69, 5),
    "met2.pin": (69, 16),
    "met3.label": (70, 5),
    "met3.pin": (70, 16),
}

for name, (layer, datatype) in LABELS.items():
    li = ly.find_layer(layer, datatype)
    if li is None:
        continue
    # walk all cells to find labelled shapes anywhere
    seen = []
    for cell in ly.each_cell():
        for s in cell.shapes(li).each():
            if s.is_text():
                t = s.text
                seen.append((cell.name, t.string, t.x, t.y))
    if seen:
        print(f"\n=== {name} ({layer}/{datatype}) ===")
        for c, t, x, y in seen[:40]:
            print(f"  cell={c} label={t!r} @ ({x},{y})")
        if len(seen) > 40:
            print(f"  ... {len(seen)-40} more")
