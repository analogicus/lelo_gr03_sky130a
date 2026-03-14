"""Fit oscillator freq-vs-temp from SPICE YAML data, write Verilog params."""

from __future__ import annotations

import re
import sys
from pathlib import Path

import numpy as np
import yaml

YAML_DIR = Path(__file__).resolve().parent / "../OSCILLATOR_TB/output_tran"
DEFAULT_CORNER = "KttTtVt"


def list_corners() -> list[str]:
    """Return available corner names from the YAML directory."""
    corners: list[str] = []
    for f in sorted(YAML_DIR.glob("tran_*.yaml")):
        if re.search(r"_-?\d+$", f.stem):
            continue
        label = re.sub(r"^tran_\\w*Gt", "", f.stem)
        corners.append(label)
    return corners


def find_yaml(corner: str) -> Path:
    """Find the YAML file matching the given corner name."""
    for f in sorted(YAML_DIR.glob("tran_*.yaml")):
        if re.search(r"_-?\d+$", f.stem):
            continue
        if corner in f.stem:
            return f
    msg = f"No YAML found for corner {corner} in {YAML_DIR}"
    raise FileNotFoundError(msg)


def extract_freq(yaml_path: Path) -> tuple[np.ndarray, np.ndarray]:
    """Extract (temperatures, frequencies_Hz) from a YAML measurement file."""
    with yaml_path.open() as f:
        obj: dict[str, float] = yaml.safe_load(f)

    t1_vals: dict[int, float] = {}
    t2_vals: dict[int, float] = {}
    for key, val in obj.items():
        if key.startswith("t1_"):
            t1_vals[int(key.split("_")[1])] = float(val)
        elif key.startswith("t2_"):
            t2_vals[int(key.split("_")[1])] = float(val)

    temps = sorted(t for t in t1_vals if t in t2_vals)
    freqs = [4.0 / (t2_vals[t] - t1_vals[t]) for t in temps]
    return np.array(temps, dtype=float), np.array(freqs)


def write_params(coeffs: np.ndarray, yaml_name: str, corner: str) -> Path:
    """Write osc_params.vh with polynomial coefficients."""
    out = Path(__file__).resolve().parent / "osc_params.vh"
    with out.open("w") as f:
        f.write(f"// Auto-generated from {yaml_name} (corner: {corner})\n")
        f.write("// Polynomial: freq = a*T^2 + b*T + c  [Hz]\n")
        f.write(f"`define OSC_COEFF_A {coeffs[0]:.6e}\n")
        f.write(f"`define OSC_COEFF_B {coeffs[1]:.6e}\n")
        f.write(f"`define OSC_COEFF_C {coeffs[2]:.6e}\n")
    return out


def main() -> None:
    """Fit polynomial and write osc_params.vh, or list available corners."""
    if len(sys.argv) > 1 and sys.argv[1] == "--list":
        for c in list_corners():
            sys.stdout.write(c + "\n")
        return

    corner = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_CORNER
    yaml_path = find_yaml(corner)
    temps, freqs = extract_freq(yaml_path)
    coeffs = np.polyfit(temps, freqs, 2)
    out = write_params(coeffs, yaml_path.name, corner)

    sys.stdout.write(f"Fitted {corner} ({len(temps)} points) -> {out}\n")
    sys.stdout.write(f"  a={coeffs[0]:.4e}  b={coeffs[1]:.4e}  c={coeffs[2]:.4e}\n")


if __name__ == "__main__":
    main()
