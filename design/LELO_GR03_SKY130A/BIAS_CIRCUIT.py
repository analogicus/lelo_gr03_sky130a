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

    branch_gap = 2 * layout.um

    # cicpy default place() puts xb at smaller x than xc (alphabetic).
    # Swap them so xc is on the LEFT and xb is on the RIGHT, per requirement.
    pmos_xc.abutLeft(pmos_xb, space=branch_gap)
    nmos_xc.abutLeft(nmos_xb, space=branch_gap)

    # Add CTAPBOT/CTAPTOP per stack
    for s in (pmos_xc, pmos_xb, nmos_xc, nmos_xb):
        s.addTaps()

    # pmos_xb has 1 device, pmos_xc has 2 → fill xb with a dummy on top.
    # nmos_xc and nmos_xb both have 2 devices, no fill needed.
    pmos.fillDummyTransistors(direction="top")
    pmos.routeDummyDevices()

    # Vertical abut: pmos above nmos, res above pmos
    pmos.abutTop(nmos, space=branch_gap)
    res.abutTop(pmos,  space=branch_gap)

    for g in (res, pmos, nmos):
        g.updateBoundingRect()

    layout._route_scopes = {
        "res": res,   "res_stack": res_stack,
        "pmos": pmos, "pmos_xc": pmos_xc, "pmos_xb": pmos_xb,
        "nmos": nmos, "nmos_xc": nmos_xc, "nmos_xb": nmos_xb,
    }


def beforeRoute(layout):
    # Power rings (M1, drawn explicitly because noPowerRoute=True)
    layout.addRouteRing("M1", "VDD_1V8", "t", widthmult=3, spacemult=2)
    layout.addRouteRing("M1", "VSS",     "b", widthmult=3, spacemult=2)
    layout.addPowerConnection("VDD_1V8", "", "top")
    layout.addPowerConnection("VSS",     "", "bottom")

    # In-group signal routes (M2 vertical stub + M3 horizontal trunk)
    s = layout._route_scopes
    # VB_N spans nmos_xc.xc2 (gate) and nmos_xb.xb6 (gate=drain, since it's diode-connected)
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^VB_N$", "track0", 1, "")
    # VB_P at xc3 (gate=drain, since it's diode-connected)
    s["pmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^VB_P$", "track0", 1, "")
