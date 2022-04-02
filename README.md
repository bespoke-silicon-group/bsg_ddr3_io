# DDR3 SSTL Design for SKY130

This repo contains a DDR3 SSTL driver circuit designed for the Skywater 130nm PDK.

Introduction and design overview found [here](docs/SSTL_design.pdf).

Simulation script instructions [here](docs/simulation_scripts.md).

Directory structure:
* `schem`   Xschem schematic files for SSTL design.
* `layout`  Magic format layout files for SSTL design.
* `scripts` Simulation handling and automation Python scripts.
* `docs`    Some extra documentation files.
* `sky130`  Sky130 specific files (standard cell "include" files.)
* `spice`   Output directory for spice scripts generated by Xschem.
* `out`     Output directory for simulation results.
* `tools`   Instilation directory for the open source DEA tools used for design and simulation.

