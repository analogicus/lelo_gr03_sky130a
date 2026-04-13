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
