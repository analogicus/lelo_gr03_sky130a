#!/usr/bin/env python3
import pandas as pd
import yaml
import glob
import re
import pandas as pd
import matplotlib.pyplot as plt

def main(name):
  temps = []
  ipts = []
  vbgs = []

  # Parse ngspice logs (adjust extension if needed)
  for fname in glob.glob("tran_*.log"):
      with open(fname) as f:
          txt = f.read()

      t  = float(re.search(r"TEMP=([-0-9.]+)", txt).group(1))
      ip = float(re.search(r"Iptat=([-0-9.eE]+)", txt).group(1))
      vb = float(re.search(r"Vbg=([-0-9.eE]+)", txt).group(1))

      temps.append(t)
      ipts.append(ip)
      vbgs.append(vb)

  # Build dataframe
  df = pd.DataFrame({
      "Temp_C": temps,
      "I_PTAT": ipts,
      "V_BG": vbgs
  })

  df.sort_values("Temp_C", inplace=True)

  # Save CSV
  df.to_csv("temp_sweep.csv", index=False)

  print(df)

  # -----------------
  # Plot PTAT current
  # -----------------
  plt.figure()
  plt.plot(df["Temp_C"], df["I_PTAT"], marker="o")
  plt.xlabel("Temperature (°C)")
  plt.ylabel("I_PTAT (A)")
  plt.title("PTAT Current vs Temperature")
  plt.grid(True)

  # -----------------
  # Plot Bandgap voltage
  # -----------------
  plt.figure()
  plt.plot(df["Temp_C"], df["V_BG"], marker="o")
  plt.xlabel("Temperature (°C)")
  plt.ylabel("V_BG (V)")
  plt.title("Bandgap Voltage vs Temperature")
  plt.grid(True)

  plt.show()