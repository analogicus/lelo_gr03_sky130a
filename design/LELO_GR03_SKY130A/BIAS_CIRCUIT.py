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

    # NOTE: pmos_xb is one device shorter than pmos_xc, but we deliberately
    # do NOT call pmos.fillDummyTransistors() here. cicpy's helper places a
    # fake transistor cell with the SAME cell name as the base device and
    # then routes its bulk-to-D/S terminals on M1, which both shorts the
    # auto-generated VDD power straps to internal signal nets and causes
    # massive connectivity failures. The unfilled height gap above pmos_xb
    # may prompt a DRC diff-edge violation that we'll address in Task 14.

    # Vertical abut nmos above pmos. Then place the resistor stack to the
    # RIGHT of the transistor column instead of stacking it on top — the
    # resistor cells are much wider than the transistors and their M1
    # bulk frames would otherwise span the full cell width, blocking the
    # power straps that addPowerConnection extends from the pmos bulks.
    pmos.abutTop(nmos, space=branch_gap)
    res.abutRight(pmos, space=branch_gap)

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
    # Connect transistor bulks to the M1 power rings. Restrict the include
    # list to ^x[bc] so that the resistor instances (xa4/5/6) are NOT
    # included — cicpy's addPowerConnection extends the resistor's wide
    # M1 bulk frame to the rings, producing a cell-spanning M1 sheet.
    layout.addPowerConnection("VDD_1V8", r"^x[bc]\d+$", "top")
    layout.addPowerConnection("VSS",     r"^x[bc]\d+$", "bottom")

    # In-group signal routes (M2 vertical stub + M3 horizontal trunk)
    s = layout._route_scopes
    # VB_N spans nmos_xc.xc2 (gate) and nmos_xb.xb6 (gate=drain, since it's diode-connected)
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^VB_N$", "track0", 1, "")
    # VB_P at xc3 (gate=drain, since it's diode-connected)
    s["pmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^VB_P$", "track0", 1, "")

    # PWRUP_1V8 connects nmos_xb.xb5 gate and nmos_xc.xc1 gate (both NCH PWRUP switches)
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^PWRUP_1V8$",   "track2", 1, "")
    # PWRUP_N_1V8 connects pmos_xb.xb7 gate and pmos_xc.xc4 gate (both PCH PWRUP switches)
    s["pmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^PWRUP_N_1V8$", "track2,left", 1, "")

    # Intra-stack source/drain shorts. cicpy stacks do NOT auto-share
    # diffusion between adjacent devices; the schematic-defined nets that
    # bridge a stack pair (xb5.D↔xb6.S, xc1.D↔xc2.S, xc4.D↔xc3.S) need
    # explicit metal routes. Use track4 to clear the existing track0/track2
    # trunks above and stay inside each stack's column.
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^net2$", "track4", 1, "")
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^net3$", "track4", 1, "")
    s["pmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^net4$", "track4", 1, "")

    # Resistor stack internal nets (xa5.N↔xa6.N=net5, xa4.P↔xa5.P=net6) — TODO

    # Cross-group: net1 connects xa6 (top of res) to xb7 (top of pmos_xb)
    layout.addOrthogonalConnectivityRoute(
        "M4", "M3", r"^net1$",
        "track0", 1, "", r"^(xa6|xb7)$",
        accessLayer="M2",
    )


def afterPorts(layout):
    layout.addPortOnEdge("M3", "VB_P",        "left",  "|-", "track0")
    layout.addPortOnEdge("M3", "PWRUP_1V8",   "left",  "|-", "track2")
    layout.addPortOnEdge("M3", "PWRUP_N_1V8", "left",  "|-", "track4")
    # layout.addPortOnEdge("M3", "VB_N",        "right", "-|", "track0")  # debug
