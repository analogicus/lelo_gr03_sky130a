#!/usr/bin/env python3
"""
cicpy layout recipe for BIAS_CIRCUIT (LELO_GR03_SKY130A).

Phase B floorplan: primitive-grouped 3-row stack
  res   (top)     — xa4/5/6 resistor chain
  pmos  (middle)  — xc3/4 (left), xb7 (right)
  nmos  (bottom)  — xc1/2 (left), xb5/6 (right)
Outputs: VB_P on left edge, VB_N on right edge.

See docs/plans/2026-04-13-bias-circuit-layout-recipe-design.md for the full design.
"""

data = {
    "afterPaint": [
        {"resetOrigins": [[1]]},
    ]
}


def beforePlace(layout):
    layout.noPowerRoute     = True
    layout.place_xspace     = [0]
    layout.place_yspace     = [0]
    layout.place_groupbreak = [3]   # wrap after 3 instance groups (xa, xb, xc)


def _inst(layout, name):
    return layout.getInstanceFromInstanceName(name)


def afterPlace(layout):
    # res group (top) — single resistor stack
    res = layout.makeCellGroup("res")
    res_stack = res.addStack("res_stack", [
        _inst(layout, "xa4"),
        _inst(layout, "xa5"),
        _inst(layout, "xa6"),
    ])

    # pmos group (middle)
    pmos = layout.makeCellGroup("pmos")
    pmos_xc = pmos.addStack("pmos_xc", [
        _inst(layout, "xc3"),
        _inst(layout, "xc4"),
    ])
    pmos_xb = pmos.addStack("pmos_xb", [
        _inst(layout, "xb7"),
    ])

    # nmos group (bottom)
    nmos = layout.makeCellGroup("nmos")
    nmos_xc = nmos.addStack("nmos_xc", [
        _inst(layout, "xc1"),
        _inst(layout, "xc2"),
    ])
    nmos_xb = nmos.addStack("nmos_xb", [
        _inst(layout, "xb5"),
        _inst(layout, "xb6"),
    ])

    layout._scopes = {
        "res": res,   "res_stack": res_stack,
        "pmos": pmos, "pmos_xc": pmos_xc, "pmos_xb": pmos_xb,
        "nmos": nmos, "nmos_xc": nmos_xc, "nmos_xb": nmos_xb,
    }
