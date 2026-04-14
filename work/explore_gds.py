"""Explore the BIAS_CIRCUIT GDS: layer names, cell bbox, VDD/VSS rects."""
import pya

ly = pya.Layout()
ly.read("gds/BIAS_CIRCUIT.gds")

print(f"Top cells: {[c.name for c in ly.top_cells()]}")
top = ly.top_cell()
print(f"Top cell: {top.name}, bbox: {top.bbox()}")
print(f"dbu = {ly.dbu} um")

print("\n=== Layers in layout ===")
for li in ly.layer_indexes():
    info = ly.get_info(li)
    print(f"  layer={info.layer}/{info.datatype}  name={info.name!r}")

print("\n=== Top-cell shapes per layer (counts) ===")
for li in ly.layer_indexes():
    info = ly.get_info(li)
    shapes = top.shapes(li)
    n = shapes.size()
    if n > 0:
        print(f"  {info.layer}/{info.datatype} {info.name!r}: {n} shapes")

print("\n=== Instances in top cell ===")
for inst in top.each_inst():
    cell = ly.cell(inst.cell_index)
    bb = inst.bbox()
    print(f"  {cell.name} @ {bb}")
