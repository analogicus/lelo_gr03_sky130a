"""Shared corner-label parsing for per-testbench tran.py post-processing."""

import re

_CORNER_RE = re.compile(r"(K\w\w(?:mm)?)(T\w)(V\w)")


def parse_corner_label(label: str) -> tuple[str, str]:
    """Return (process, voltage_variant) for a corner label like KttTtVt.

    Falls back to ("Ktt", "Vt") when the pattern does not match.
    """
    m = _CORNER_RE.search(label)
    if m:
        return m.group(1), m.group(3)
    return "Ktt", "Vt"
