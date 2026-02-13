#!/usr/bin/env python3
import pandas as pd
import yaml
import matplotlib.pyplot as plt

def main(name):
  # Delete next line if you want to use python post processing
  #return
  yamlfile = name + ".yaml"

  # Read result yaml file
  with open(yamlfile) as fi:
    obj = yaml.safe_load(fi)

  # Do something to parameters
  iptat = []
  vctat = []

  for key, val in obj.items():
    if "iptat" in key:
      iptat.append((int(key[6:]), val))
    elif "vctat" in key:
      vctat.append((int(key[6:]), val))

  iptat.sort(key=lambda x : x[0])
  vctat.sort(key=lambda x : x[1])

  plt.plot([temp for temp, val in iptat], [val for temp, val in iptat])
  plt.title("I PTAT")
  plt.xlabel("Temperature [C]")
  plt.ylabel("Current [A]")
  plt.figure()
  plt.plot([temp for temp, val in vctat], [val for temp, val in vctat])
  plt.title("V CTAT")
  plt.xlabel("Temperature [C]")
  plt.ylabel("Voltage [V]")

  # Save new yaml file
  # with open(yamlfile,"w") as fo:
  #   yaml.dump(obj,fo)

  plt.show()