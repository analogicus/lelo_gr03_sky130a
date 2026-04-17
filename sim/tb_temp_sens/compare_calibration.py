#!/usr/bin/env python3
"""Extract peak 1-pt and 2-pt calibration error from a temp/count CSV."""
import sys
from pathlib import Path

import numpy as np
import pandas as pd


def peak_errors(csv_path: Path) -> tuple[float, float]:
    df = pd.read_csv(csv_path)
    t = df["temperature"].astype(float).to_numpy()
    count = df["count"].astype(float).to_numpy()
    freq = count * 32768.0

    coeffs = np.polyfit(freq, t, 1)
    f25 = float(np.interp(25, t, freq))
    f85 = float(np.interp(85, t, freq))

    offset_1pt = 25 - coeffs[0] * f25
    t_1pt = coeffs[0] * freq + offset_1pt
    e1 = float(np.max(np.abs(t_1pt - t)))

    slope_2pt = (85 - 25) / (f85 - f25)
    offset_2pt = 25 - slope_2pt * f25
    t_2pt = slope_2pt * freq + offset_2pt
    e2 = float(np.max(np.abs(t_2pt - t)))

    return e1, e2


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: compare_calibration.py <rtl.csv> [<gls.csv>]", file=sys.stderr)
        return 2

    rtl_path = Path(sys.argv[1])
    rtl_e1, rtl_e2 = peak_errors(rtl_path)

    if len(sys.argv) == 2:
        print(f"{rtl_path.name}: 1pt={rtl_e1:.3f}  2pt={rtl_e2:.3f}")
        return 0

    gls_path = Path(sys.argv[2])
    gls_e1, gls_e2 = peak_errors(gls_path)
    ok = gls_e1 <= rtl_e1 + 1e-6 and gls_e2 <= rtl_e2 + 1e-6
    verdict = "OK" if ok else "FAIL"
    print(
        f"{rtl_path.name} vs {gls_path.name}: "
        f"rtl[1pt={rtl_e1:.3f} 2pt={rtl_e2:.3f}] "
        f"gls[1pt={gls_e1:.3f} 2pt={gls_e2:.3f}] {verdict}"
    )
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
