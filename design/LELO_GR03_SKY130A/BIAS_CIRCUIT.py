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

    # Vertical abut: pmos above nmos, res above pmos. This is the required
    # floorplan (resistors above the transistor column so VB_P exits left
    # and VB_N exits right). We avoid the earlier "cell-spanning M1 sheet"
    # problem by excluding xa* from addPowerConnection in beforeRoute.
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
    # Power rings. VSS on cicpy M1 (Magic locali) with a clean downward
    # strap from nmos sources. VDD ring is drawn but NOT connected in
    # cicpy — any in-cell VDD strap direction either crosses res's
    # locali bulk frames or cicpy's internal signal tracks. The VDD
    # strap, the resistor intra-stack nets (net5/net6), and the diode
    # gate/drain bridges (xc3, xb6, xc2) are all added in a klayout
    # post-processing step; see work/post_process.py.
    layout.addRouteRing("M1", "VDD_1V8", "t", widthmult=3, spacemult=2)
    layout.addRouteRing("M1", "VSS",     "b", widthmult=3, spacemult=2)
    layout.addPowerConnection("VSS", r"^x[bc]\d+$", "bottom")

    # In-group signal routes (M2 vertical stub + M3 horizontal trunk)
    s = layout._route_scopes
    # VB_N spans nmos_xc.xc2 (gate) and nmos_xb.xb6 (gate=drain, diode-connected).
    # accessLayer=M1 bridges both the M2 gate rect and the M1 drain rect of xb6.
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^VB_N$", "track0", 1, "", accessLayer="M1")
    # VB_P at xc3 (diode-connected). Single-device net — a vertical M2
    # strap inside xc3's column bridges the M2 gate and drain terminals
    # without any M3 horizontal trunk that could collide with neighbours.
    layout.addConnectivityRoute("M2", r"^VB_P$", "||", "", 1, "", r"^xc3$")

    # PWRUP_1V8 connects nmos_xb.xb5 gate and nmos_xc.xc1 gate (both NCH PWRUP switches)
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^PWRUP_1V8$",   "track2", 1, "")
    # PWRUP_N_1V8 connects pmos_xb.xb7 gate and pmos_xc.xc4 gate (both PCH PWRUP switches)
    s["pmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^PWRUP_N_1V8$", "track-2", 1, "")

    # Intra-stack source/drain shorts. cicpy stacks do NOT auto-share
    # diffusion between adjacent devices; the schematic-defined nets that
    # bridge a stack pair (xb5.D↔xb6.S, xc1.D↔xc2.S, xc4.D↔xc3.S) need
    # explicit metal routes. Use track4 to clear the existing track0/track2
    # trunks above and stay inside each stack's column.
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^net2$", "track4", 1, "")
    s["nmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^net3$", "track4", 1, "")
    s["pmos"].addOrthogonalConnectivityRoute("M2", "M3", r"^net4$", "track4", 1, "")

    # net5 and net6 are resistor intra-stack nets — deferred to klayout
    # post-processing, see work/post_process.py.

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
    layout.addPortOnEdge("M3", "VB_N",        "right", "-|", "offset_track0")
