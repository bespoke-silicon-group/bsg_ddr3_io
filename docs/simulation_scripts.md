# SSTL Design Simulations

Several Make targets run simulations designed to measure properties of the SSTL circuit and it sub-components (legs).
The various simulations help the user step through the several design steps laid out in The SSTL Design Document.
The aim is to easily create new SSTL designs for future process nodes.

## Tool instillation

First, install the open source EDA tools: xschem, ngspice, netgen, magic.

The tool instilation process was designed for CentOS-7, here is the list of known dependences. (Which can be installed with yum.)
* xorg-x11-server-xorg
* xorg-x11-xauth
* xorg-x11-apps
* libXaw-devel
* libXpm-devel
* readline-devel
* tcl
* tcl-devel
* tk
* tk-devel
* mesa-libGL-devel
* cairo-devel
* glut
* glut-devel
* patch
* Python3
* centos-release-scl (for devtoolset)
* devtoolset-8
* flex
* bison

With dependences installed, run the make target `make install-tools`.

The tools are not automatically added to path. They can be instead launch with these make targets:
* `make launch-xschem`
* `make launch-ngspice`
* `make launch-magic`
* `make launch-netgen`

If you would like to pass in additional arguments, add the "args" variable
Example: `make launch-magic args="-noconsole"`

## Simulation Summary

Defining corners in the Makefile: *TODO*

1. Simplified leg simulations
   Make target: `simple-leg-sim`
   Dependant files (input designs): `schem/test_pd_res.sch`, `schem/test_pu_res.sch`
   Main output: `out/results/simplified_pd_resistance.json`, `out/results/simplified_pu_resistance.json`

   This simulation is designed to help find a good size for the main control FETs and resistors for each leg. (Steps 1 and 2 in the design process document.) One spice simulation is run per PVT corner. A summary of the simulations is printed at the end. If you are trying to find a good size for the main control FETs and resistors, then the minimum measured resistances should be slightly above the allowed minimum resistance is the specification.

2. Complete leg simulations
   Make target: `leg-sim`
   Dependant files (input designs): `schem/n-leg_tb.sch`, `schem/p-leg_tb.sch`
   Main output: `out/results/pd_resistance.json`, `out/results/pu_resistance.json`

   This simulation is designed to size the calibration FETs for each leg. This covers step 4 in the design process document. (It can also be used to cover step 3, which is kind of optional.) If all 4 calibration FETs are added to the schematics, then they will all be turned on in the simulations. This is meant to check that the leg can meet the high-resistance PVT corner. If you are trying to find a good total size for the calibration FETs, then the maximum measured resistances should be slight below the allowed maximum resistance in the specification. (By "total size" I mean sum of the widths of all the calibration FETs.)

3. SSTL Resistance/Calibration Simulation
   Make target: `sstl-res-sim`
   Dependant files (input designs): `schem/sstl_res_tb.sch`, `schem/SSTL.sch`, `schem/n-leg.sch`, `schem/p-leg.sch`
   Main output: `out/sstl_pd_6_resistance.json`, `out/sstl_pu_6_resistance.json`, `out/sstl_pd_7_resistance.json`, `out/sstl_pu_7_resistance.json`

   This simulation tests all of the resistance requirements for each of the PVT corners. At every PVT corner, the calibration process is simulated. So long as the resistance requirements are not met, the simulation repeats with different calibration configuration until the resistance requirements are met (or it is shown they can never be met.)
   This covers steps 4 and 5 in the design process document. 
   There are 4 cases in which calibration can fail:
   * With all calibration FETs disabled, the resistance is still too low. This means the resistance of the resistor and main control FET needs to be increased.
   * With all calibration FETs enabled, the resistance is still too high. This means the resistance of some/all of the calibration FETs need to be decreased. (This could also be solved by decreasing the resistance of the main control FET.)
   * At least one resistance is too high at a calibration setting, but increasing the calibration by one increment results in a too low resistance. In other words, the calibration FETs do not provide enough fine control of the leg resistance. This means the sizes of the calibration FETs need to be re-distributed. 
   * At any calibration setting, one resistance is below the allowed minimum, while another resistance is above the allowed maximum. The easiest way to resolve this is to decrease the resistance of the main control FET while increasing the resistance of the resistor. (The resistor has better linearity than the FET.)

4. SSTL Slew Simulation
   Make target: `sstl-slew-sim`
   Dependant files (input designs): 
   Main output: 

5. Post-layout SSTL Resistance/Calibration Simulation
   Make target: `post-layout-sstl-res-sim`
   Dependant files (input designs): 
   Main output: 

6. Post-layout SSTL Slew Simulation
   Make target: `post-layout-sstl-slew-sim`
   Dependant files (input designs): 
   Main output: 

## Netlist Generation from Layout

