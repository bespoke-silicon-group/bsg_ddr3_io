# DDR3 SSTL Design for SKY130

This repo contains a DDR3 SSTL driver circuit designed for the Skywater 130nm PDK.

Introduction and design overview found [here](docs/).

Installation simulation script instructions [here](docs/simulation_scripts.md).   
PDK installation instructions found [here](docs/pdk_installation.md).

Directory structure:
* `schem`   Xschem schematic files for SSTL design.
* `layout`  Magic format layout files for SSTL design.
* `scripts` Simulation handling and automation Python scripts.
* `docs`    Some extra documentation files.
* `sky130`  Sky130 specific files (standard cell "include" files.)
* `spice`   Output directory for spice scripts generated by Xschem.
* `out`     Output directory for simulation results.
* `tools`   Instillation directory for the open source DEA tools used for design and simulation.

## Implementation

This circuit was implemented in a Efabless MPW-5 project which can be found in ([this repo](https://github.com/derekcom17/caravel_user_project_ddr3_sstl)).
