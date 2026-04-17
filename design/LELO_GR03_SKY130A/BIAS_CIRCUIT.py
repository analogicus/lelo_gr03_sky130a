#!/usr/bin/env python3
"""
cicpy layout recipe for BIAS_CIRCUIT (LELO_GR03_SKY130A).

Minimal 3-row starting-point floorplan, no signal routing.
  res   (top)    - xa4/5/6 resistor chain
  pmos  (middle) - xc3/4 (left column), xb7 (right column)
  nmos  (bottom) - xc1/2 (left column), xb5/6 (right column)

Power rings are drawn and stacks get taps. Signal nets (VB_P, VB_N,
PWRUP_1V8, PWRUP_N_1V8) are deliberately left unrouted - add them
after reviewing the grid in Magic/KLayout.
"""

data = {
    "afterPaint": [
        {"resetOrigins": [[1]]},
    ]
}


def _inst(layout, name):
    return layout.getInstanceFromInstanceName(name)


def beforePlace(layout):
    # noPowerRoute=True disables cicpy's default M1 power sheet so the
    # explicit rings in beforeRoute don't collide with it.
    layout.noPowerRoute     = True
    layout.place_xspace     = [2 * layout.um]
    layout.place_yspace     = [2 * layout.um]
    layout.place_groupbreak = [3]


def afterPlace(layout):
    gap = 2 * layout.um

    res = layout.makeCellGroup("res")
    res_stack = res.addStack("res_stack", [
        _inst(layout, "xa4"),
        _inst(layout, "xa5"),
        _inst(layout, "xa6"),
    ])
    res_stack.addTaps()

    pmos = layout.makeCellGroup("pmos")
    pmos_xc = pmos.addStack("pmos_xc", [
        _inst(layout, "xc3"),
        _inst(layout, "xc4"),
    ])
    pmos_xb = pmos.addStack("pmos_xb", [
        _inst(layout, "xb7"),
    ])
    pmos_xc.addTaps()
    pmos_xb.addTaps()
    pmos_xc.abutLeft(pmos_xb, space=gap)

    nmos = layout.makeCellGroup("nmos")
    nmos_xc = nmos.addStack("nmos_xc", [
        _inst(layout, "xc1"),
        _inst(layout, "xc2"),
    ])
    nmos_xb = nmos.addStack("nmos_xb", [
        _inst(layout, "xb5"),
        _inst(layout, "xb6"),
    ])
    nmos_xc.addTaps()
    nmos_xb.addTaps()
    nmos_xc.abutLeft(nmos_xb, space=gap)

    pmos.abutTop(nmos, space=gap)
    res.abutTop(pmos,  space=gap)

    for g in (res, pmos, nmos):
        g.updateBoundingRect()


def beforeRoute(layout):
    # Power only. Signal routing deliberately left for a later pass.
    layout.addRouteRing("M1", "VDD_1V8", "t", widthmult=3, spacemult=2)
    layout.addRouteRing("M1", "VSS",     "b", widthmult=3, spacemult=2)
    layout.addPowerConnection("VSS", r"^x[bc]\d+$", "bottom")


def afterPorts(layout):
    # Port labels land on the cell edge so later routing has known
    # targets. LVS will flag these as unconnected until VB_P/VB_N/
    # PWRUP_* are wired up.
    layout.addPortOnEdge("M3", "VB_P",        "left",  "|-", "track0")
    layout.addPortOnEdge("M3", "PWRUP_1V8",   "left",  "|-", "track2")
    layout.addPortOnEdge("M3", "PWRUP_N_1V8", "left",  "|-", "track4")
    layout.addPortOnEdge("M3", "VB_N",        "right", "-|", "offset_track0")
