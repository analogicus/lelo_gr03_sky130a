#!/usr/bin/env python3
"""Auto-update README.md with measured parameters and FSM state diagram."""

from __future__ import annotations

import csv
import re
import sys
from pathlib import Path

import numpy as np
import yaml

ROOT = Path(__file__).resolve().parent.parent


# ---------------------------------------------------------------------------
# FSM extraction
# ---------------------------------------------------------------------------


def extract_fsm(sv_text: str) -> tuple[list[str], list[tuple[str, str, str]]]:
    """Parse typedef enum states and always_comb transitions from SV text.

    Returns (states, transitions) where each transition is (src, dst, condition).
    Self-loops are excluded.
    """
    # Extract states from typedef enum
    enum_m = re.search(r"typedef\s+enum\b[^{]*\{([^}]+)\}", sv_text)
    states: list[str] = []
    if enum_m:
        body = enum_m.group(1)
        for m in re.finditer(r"(\w+)\s*=", body):
            states.append(m.group(1))

    # Extract transitions from always_comb case block
    case_m = re.search(r"always_comb\b.*?case\b.*?\n(.*?)endcase", sv_text, re.DOTALL)
    transitions: list[tuple[str, str, str]] = []
    if case_m:
        case_body = case_m.group(1)
        # Split by state labels — match lines like "      IDLE:" or "      COUNT:   next_state = ..."
        chunks = re.split(r"(?m)^\s*(\w+)\s*:", case_body)
        # chunks[0] is before first state, then alternating state/body
        i = 1
        while i < len(chunks) - 1:
            src = chunks[i]
            body = chunks[i + 1]
            if src == "default":
                i += 2
                continue
            # Find all next_state assignments
            for m in re.finditer(
                r"(?:if\s*\((\w+)\)\s*)?next_state\s*=\s*(\w+)\s*;", body
            ):
                cond = m.group(1) or ""
                dst = m.group(2)
                if src != dst:  # skip self-loops
                    transitions.append((src, dst, cond))
            i += 2

    return states, transitions


def fsm_to_mermaid(
    states: list[str], transitions: list[tuple[str, str, str]]
) -> str:
    """Generate a Mermaid stateDiagram-v2 from states and transitions."""
    lines = ["```mermaid", "stateDiagram-v2"]
    if states:
        lines.append(f"    [*] --> {states[0]}")
    for src, dst, cond in transitions:
        if cond:
            lines.append(f"    {src} --> {dst} : {cond}")
        else:
            lines.append(f"    {src} --> {dst}")
    lines.append("```")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Parameter extraction
# ---------------------------------------------------------------------------


def _find_typical_yaml(pattern: str, root: Path) -> Path | None:
    """Find a YAML matching the glob pattern that contains KttTtVt."""
    for f in sorted(root.glob(pattern)):
        if re.search(r"_\d+$", f.stem):
            continue
        if "KttTtVt" in f.stem:
            return f
    return None


def _parse_osc_freq_25(root: Path) -> float:
    """Extract frequency at 25C in MHz from oscillator YAML."""
    yf = _find_typical_yaml(
        "sim/OSCILLATOR_TB/output_tran/tran_*KttTtVt*.yaml", root
    )
    if yf is None:
        msg = "Typical oscillator YAML not found"
        raise FileNotFoundError(msg)

    with yf.open() as f:
        obj: dict[str, float] = yaml.safe_load(f)

    t1_vals: dict[int, float] = {}
    t2_vals: dict[int, float] = {}
    for key, val in obj.items():
        if key.startswith("t1_"):
            t1_vals[int(key.split("_")[1])] = float(val)
        elif key.startswith("t2_"):
            t2_vals[int(key.split("_")[1])] = float(val)

    # Nearest available temperature to 25
    temps = sorted(t for t in t1_vals if t in t2_vals)
    t_arr = np.array(temps, dtype=float)
    freq_arr = np.array([4.0 / (t2_vals[t] - t1_vals[t]) for t in temps])

    freq_25 = float(np.interp(25.0, t_arr, freq_arr))
    return freq_25 / 1e6


def _parse_bandgap_currents_25(root: Path) -> tuple[float, float]:
    """Extract ileak (nA) and iact (uA) at 25C from bandgap YAML."""
    yf = _find_typical_yaml(
        "sim/BANDGAP_CIRCUIT_TB/output_tran/tran_*KttTtVt*.yaml", root
    )
    if yf is None:
        msg = "Typical bandgap YAML not found"
        raise FileNotFoundError(msg)

    with yf.open() as f:
        obj: dict[str, float] = yaml.safe_load(f)

    ileak_vals: dict[int, float] = {}
    iact_vals: dict[int, float] = {}
    for key, val in obj.items():
        temp = int(key.split("_")[-1])
        if key.startswith("ileak_"):
            ileak_vals[temp] = float(val)
        elif key.startswith("iact_"):
            iact_vals[temp] = float(val)

    # Interpolate to 25C
    ileak_temps = sorted(ileak_vals.keys())
    iact_temps = sorted(iact_vals.keys())

    ileak_25 = float(
        np.interp(25.0, ileak_temps, [ileak_vals[t] for t in ileak_temps])
    )
    iact_25 = float(
        np.interp(25.0, iact_temps, [iact_vals[t] for t in iact_temps])
    )

    return abs(ileak_25) * 1e9, abs(iact_25) * 1e6


def _load_csv_corners(root: Path) -> list[tuple[str, str, str, np.ndarray, np.ndarray]]:
    """Load all per-corner CSVs, deduplicate by proc+volt_var."""
    csv_dir = root / "sim" / "tb_temp_sens" / "output"
    corners = []
    seen: set[str] = set()

    for csv_path in sorted(csv_dir.glob("tb_*.csv")):
        corner = csv_path.stem.removeprefix("tb_")
        m = re.search(r"(K\w\w(?:mm)?)(T\w)(V\w)", corner)
        if m:
            proc, volt_var = m.group(1), m.group(3)
        else:
            proc, volt_var = "Ktt", "Vt"

        dedup_key = proc + volt_var
        if dedup_key in seen:
            continue
        seen.add(dedup_key)

        temps = []
        counts = []
        with csv_path.open() as f:
            reader = csv.DictReader(f)
            for row in reader:
                temps.append(float(row["temperature"]))
                counts.append(float(row["count"]))

        t_arr = np.array(temps)
        freq = np.array(counts) * 32768.0
        corners.append((corner, proc, volt_var, t_arr, freq))

    return corners


def _find_nominal_slope(
    corners: list[tuple[str, str, str, np.ndarray, np.ndarray]],
) -> float:
    """Find typical slope from Ktt+Vt corner."""
    for _, proc, volt_var, t_arr, freq in corners:
        if proc == "Ktt" and volt_var == "Vt" and len(t_arr) >= 2:
            coeffs = np.polyfit(freq, t_arr, 1)
            return float(coeffs[0])

    for _, _, _, t_arr, freq in corners:
        if len(t_arr) >= 2:
            coeffs = np.polyfit(freq, t_arr, 1)
            return float(coeffs[0])

    msg = "No valid corner found for nominal slope"
    raise ValueError(msg)


def _compute_kerr(root: Path) -> tuple[float, float]:
    """Compute max abs calibration error in 0-70C range for 1-pt and 2-pt cal."""
    corners = _load_csv_corners(root)
    nominal_slope = _find_nominal_slope(corners)

    max_err_1pt = 0.0
    max_err_2pt = 0.0

    for _, _proc, _volt_var, t_arr, freq in corners:
        if len(t_arr) < 2:
            continue

        # Restrict to 0-70C range for error evaluation
        mask = (t_arr >= 0) & (t_arr <= 70)
        if not np.any(mask):
            continue

        # 1-point calibration: nominal slope, offset at 25C
        f25 = float(np.interp(25.0, t_arr, freq))
        offset_1pt = 25.0 - nominal_slope * f25
        t_meas_1pt = nominal_slope * freq + offset_1pt
        err_1pt = np.abs(t_meas_1pt[mask] - t_arr[mask])
        max_err_1pt = max(max_err_1pt, float(np.max(err_1pt)))

        # 2-point calibration: line through 25C and 85C per corner
        f85 = float(np.interp(85.0, t_arr, freq))
        if abs(f85 - f25) < 1e-12:
            continue
        slope_2pt = (85.0 - 25.0) / (f85 - f25)
        offset_2pt = 25.0 - slope_2pt * f25
        t_meas_2pt = slope_2pt * freq + offset_2pt
        err_2pt = np.abs(t_meas_2pt[mask] - t_arr[mask])
        max_err_2pt = max(max_err_2pt, float(np.max(err_2pt)))

    return max_err_1pt, max_err_2pt


def extract_params(root: Path) -> dict[str, float]:
    """Extract all measured parameters from simulation data."""
    freq = _parse_osc_freq_25(root)
    ileak, iact = _parse_bandgap_currents_25(root)

    tc_us = 1.0 / 32768.0 * 1e6  # conversion time in us
    ts_ms = 100.0  # sample period in ms
    tc_s = tc_us * 1e-6
    ts_s = ts_ms * 1e-3
    iact_a = iact * 1e-6  # back to amps
    iavg = iact_a * tc_s / ts_s * 1e9 + ileak  # in nA

    kerr1, kerr2 = _compute_kerr(root)

    return {
        "freq": freq,
        "ileak": ileak,
        "iact": iact,
        "iavg": iavg,
        "kerr1": kerr1,
        "kerr2": kerr2,
    }


# ---------------------------------------------------------------------------
# README update
# ---------------------------------------------------------------------------

KEY_PARAMS_TEMPLATE = """\
| Parameter           | Min     | Typ             | Max     | Unit  |
| :---                | :---:   | :---:           | :---:   | :---: |
| Technology          |         | Skywater 130 nm |         |       |
| AVDD                | 1.7     | 1.8             | 1.9     | V     |
| Temperature         | -40     | 27              | 125     | C     |
| Tc (conversion)     |         | ~30.5           |         | \u00b5s    |
| Ts (sample rate)    |         | 100             |         | ms    |
| Frequency           |         | ~{freq:.1f}     |         | MHz   |
| Ileak (power-down)  |         | ~{ileak:.1f}    | 1       | nA    |
| Iact (active)       |         | ~{iact:.0f}     | 100     | \u00b5A    |
| Iavg (average)      |         | ~{iavg:.1f}     | 50      | nA    |
| Kerr (1-pt cal)     |         | \u00b1{kerr1:.1f}    | \u00b110     | C     |
| Kerr (2-pt cal)     |         | \u00b1{kerr2:.1f}    | \u00b15      | C     |
"""


def replace_section(text: str, key: str, content: str) -> str:
    """Replace content between <!-- AUTO:KEY --> and <!-- /AUTO:KEY --> markers."""
    open_marker = f"<!-- AUTO:{key} -->"
    close_marker = f"<!-- /AUTO:{key} -->"

    i_open = text.find(open_marker)
    i_close = text.find(close_marker)

    if i_open < 0 or i_close < 0:
        msg = f"Markers for {key} not found in text"
        raise ValueError(msg)

    before = text[: i_open + len(open_marker)]
    after = text[i_close:]

    return before + "\n" + content + after


def main() -> None:
    """Read RTL + sim data, update README.md sections."""
    sv_path = ROOT / "rtl" / "temp_sens.sv"
    readme_path = ROOT / "README.md"

    # FSM
    sv_text = sv_path.read_text()
    states, transitions = extract_fsm(sv_text)
    mermaid = fsm_to_mermaid(states, transitions)

    fsm_content = mermaid + "\n\n"
    fsm_content += "| State | `o_pwrup_osc` | Description |\n"
    fsm_content += "| :--- | :---: | :--- |\n"
    fsm_content += "| IDLE | 0 | Waiting for trigger. Counter held in reset. |\n"
    fsm_content += "| COUNT | 1 | Oscillator on. Dual-edge counter runs for one 32768 Hz period. |\n"
    fsm_content += "| WAIT | 0 | Oscillator off. Counter values settle (CDC safety). |\n"
    fsm_content += "| CAPTURE | 0 | Count latched into output register. |\n"

    # Parameters
    params = extract_params(ROOT)
    params_content = KEY_PARAMS_TEMPLATE.format(**params)

    # Update README
    readme_text = readme_path.read_text()
    readme_text = replace_section(readme_text, "KEY_PARAMS", params_content)
    readme_text = replace_section(readme_text, "FSM", fsm_content)
    readme_path.write_text(readme_text)

    sys.stdout.write("README.md updated\n")
    sys.stdout.write(f"  Frequency: {params['freq']:.1f} MHz\n")
    sys.stdout.write(f"  Ileak:     {params['ileak']:.1f} nA\n")
    sys.stdout.write(f"  Iact:      {params['iact']:.0f} uA\n")
    sys.stdout.write(f"  Iavg:      {params['iavg']:.1f} nA\n")
    sys.stdout.write(f"  Kerr 1-pt: {params['kerr1']:.1f} C\n")
    sys.stdout.write(f"  Kerr 2-pt: {params['kerr2']:.1f} C\n")


if __name__ == "__main__":
    main()
