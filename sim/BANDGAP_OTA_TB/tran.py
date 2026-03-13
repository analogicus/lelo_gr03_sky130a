#!/usr/bin/env python3
"""Post-process BANDGAP_OTA_TB transient simulation results."""

from pathlib import Path

import yaml


def main(name: str) -> None:
    """Post-process BANDGAP_OTA_TB simulation results."""
    # Delete next line if you want to use python post processing
    return
    yamlfile = Path(name).with_suffix(".yaml")

    # Read result yaml file
    with yamlfile.open() as fi:
        obj = yaml.safe_load(fi)

    # Do something to parameters

    # Save new yaml file
    with yamlfile.open("w") as fo:
        yaml.dump(obj, fo)
