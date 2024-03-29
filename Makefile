
# PDK Path
PDKSPATH=/home/derekhm/cad/share/pdk
PDKNAME=sky130A

# Python version
PYTHON:=python3.6

# Tempertures, Voltages, Process corners to simulate
TEMPS:=125 -40
VOLTAGES:=1.475 1.575
PROCS:=ff ff_mm fs fs_mm hh hh_mm hl hl_mm lh lh_mm ll ll_mm sf sf_mm ss ss_mm tt tt_mm



C1:=$(foreach v, $(VOLTAGES), $(addsuffix _$(v), $(TEMPS)))
CORNS:=$(foreach p, $(PROCS), $(addsuffix _$(p), $(C1)))

# Generate spice scripts from xschem schematics
spice: 
	mkdir spice

# Use a file lock to prevent too many instances of xschem at once. 
# (this causes issues for some reason...)
spice/%.spice: $(XSCHEM) schem/%.sch | spice
	flock /tmp/.spicegenlock make launch-xschem args="-xq -o ./spice/ --netlist ./schem/$*.sch"

# Do not delete intermediate files
.PRECIOUS: spice/%.spice

# SIMPLIFIED LEG SIMULATIONS
SIMPLE_N_LEG_TARGETS:=$(addprefix out/simple_pd_leg_, $(addsuffix /out.json,$(CORNS) ))
SIMPLE_P_LEG_TARGETS:=$(addprefix out/simple_pu_leg_, $(addsuffix /out.json,$(CORNS) ))
.PHONY: simple-leg-sim
simple-leg-sim: $(SIMPLE_N_LEG_TARGETS) $(SIMPLE_P_LEG_TARGETS)
	$(PYTHON) scripts/simplified_leg_result.py

out/simple_pd_leg_%/out.json: spice/test_pd_res.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )	
	$(PYTHON) scripts/sim_simplified_leg.py --dir pd --voltage ${V} --temp ${T} --process ${P}

out/simple_pu_leg_%/out.json: spice/test_pu_res.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_simplified_leg.py --dir pu --voltage $(V) --temp $(T) --process $(P)

# FULL LEG SIMULATIONS
N_LEG_TARGETS:=$(addprefix out/pd_leg_, $(addsuffix /out.json,$(CORNS) ))
P_LEG_TARGETS:=$(addprefix out/pu_leg_, $(addsuffix /out.json,$(CORNS) ))
.PHONY: leg-sim
leg-sim: $(N_LEG_TARGETS) $(P_LEG_TARGETS)
	$(PYTHON) scripts/leg_result.py

out/pd_leg_%/out.json: spice/n-leg_tb.spice schem/n-leg.sch | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )	
	$(PYTHON) scripts/sim_leg.py --dir pd --voltage ${V} --temp ${T} --process ${P}

out/pu_leg_%/out.json: spice/p-leg_tb.spice schem/p-leg.sch | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_leg.py --dir pu --voltage $(V) --temp $(T) --process $(P)

# POST LAYOUT FULL LEG SIMULATIONS
POST_LAYOUT_N_LEG_TARGETS:=$(addprefix out/post_layout_pd_leg_, $(addsuffix /out.json,$(CORNS) ))
POST_LAYOUT_P_LEG_TARGETS:=$(addprefix out/post_layout_pu_leg_, $(addsuffix /out.json,$(CORNS) ))
.PHONY: post-layout-leg-sim
post-layout-leg-sim: $(POST_LAYOUT_N_LEG_TARGETS) $(POST_LAYOUT_P_LEG_TARGETS)
	$(PYTHON) scripts/leg_result.py --post-layout

out/post_layout_pd_leg_%/out.json: spice/post_layout_n-leg_tb.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )	
	$(PYTHON) scripts/sim_leg.py --post-layout --dir pd --voltage ${V} --temp ${T} --process ${P}

out/post_layout_pu_leg_%/out.json: spice/post_layout_p-leg_tb.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_leg.py --post-layout --dir pu --voltage $(V) --temp $(T) --process $(P)

# SSTL RESISTANCE AND CALIBRATION SIMULATIONS
SSTL_PD_7_TARGETS:=$(addprefix out/sstl_pd_7_cal_sim_, $(addsuffix /out.json,$(CORNS) ))
SSTL_PU_7_TARGETS:=$(addprefix out/sstl_pu_7_cal_sim_, $(addsuffix /out.json,$(CORNS) ))
SSTL_PD_6_TARGETS:=$(addprefix out/sstl_pd_6_cal_sim_, $(addsuffix /out.json,$(CORNS) ))
SSTL_PU_6_TARGETS:=$(addprefix out/sstl_pu_6_cal_sim_, $(addsuffix /out.json,$(CORNS) ))

.PHONY: sstl-res-sim
sstl-res-sim: $(SSTL_PD_7_TARGETS) $(SSTL_PU_7_TARGETS) $(SSTL_PD_6_TARGETS) $(SSTL_PU_6_TARGETS)
	$(PYTHON) scripts/sstl_res_result.py

out/results/sstl_%_resistance.json: $(SSTL_PD_7_TARGETS) $(SSTL_PU_7_TARGETS) $(SSTL_PD_6_TARGETS) $(SSTL_PU_6_TARGETS)
	$(PYTHON) scripts/sstl_res_result.py

out/sstl_pd_7_cal_sim_%/out.json: spice/sstl_res_tb.spice schem/SSTL.sch schem/n-leg.sch schem/p-leg.sch | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --dir pd --num-leg-en 7 --voltage $(V) --temp $(T) --process $(P)

out/sstl_pu_7_cal_sim_%/out.json: spice/sstl_res_tb.spice schem/SSTL.sch schem/n-leg.sch schem/p-leg.sch | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --dir pu --num-leg-en 7 --voltage $(V) --temp $(T) --process $(P)

out/sstl_pd_6_cal_sim_%/out.json: spice/sstl_res_tb.spice schem/SSTL.sch schem/n-leg.sch schem/p-leg.sch | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --dir pd --num-leg-en 6 --voltage $(V) --temp $(T) --process $(P)

out/sstl_pu_6_cal_sim_%/out.json: spice/sstl_res_tb.spice schem/SSTL.sch schem/n-leg.sch schem/p-leg.sch | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --dir pu --num-leg-en 6 --voltage $(V) --temp $(T) --process $(P)

# SSTL SLEW SIMULATIONS
SSTL_SLEW_7_TARGETS:=$(addprefix out/sstl_7_slew_, $(addsuffix /out.json,$(CORNS) ))
SSTL_SLEW_6_TARGETS:=$(addprefix out/sstl_6_slew_, $(addsuffix /out.json,$(CORNS) ))

.PHONY: sstl-slew-sim
sstl-slew-sim: $(SSTL_SLEW_7_TARGETS)
	# NOTE: the the spec only specifies a slew requirement for the 7-leg configuraiton, 
	# so the 6-leg configuration slew tests are not run by default.
	$(PYTHON) scripts/sstl_slew_result.py

out/sstl_7_slew_%/out.json: spice/sstl_slew_tb.spice schem/SSTL.sch schem/n-leg.sch schem/p-leg.sch out/results/sstl_pu_7_resistance.json out/results/sstl_pd_7_resistance.json | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_slew.py --num-leg-en 7 --voltage $(V) --temp $(T) --process $(P)

out/sstl_6_slew_%/out.json: spice/sstl_slew_tb.spice schem/SSTL.sch schem/n-leg.sch schem/p-leg.sch out/results/sstl_pu_6_resistance.json out/results/sstl_pd_6_resistance.json | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_slew.py --num-leg-en 6 --voltage $(V) --temp $(T) --process $(P)


# POST LAYOUT SSTL RESISTANCE SIMULATIONS
LAYOUT_SSTL_PD_7_TARGETS:=$(addprefix out/post_layout_sstl_pd_7_cal_sim_, $(addsuffix /out.json,$(CORNS) ))
LAYOUT_SSTL_PU_7_TARGETS:=$(addprefix out/post_layout_sstl_pu_7_cal_sim_, $(addsuffix /out.json,$(CORNS) ))
LAYOUT_SSTL_PD_6_TARGETS:=$(addprefix out/post_layout_sstl_pd_6_cal_sim_, $(addsuffix /out.json,$(CORNS) ))
LAYOUT_SSTL_PU_6_TARGETS:=$(addprefix out/post_layout_sstl_pu_6_cal_sim_, $(addsuffix /out.json,$(CORNS) ))

.PHONY: post-layout-sstl-res-sim
post-layout-sstl-res-sim: $(LAYOUT_SSTL_PD_7_TARGETS) $(LAYOUT_SSTL_PU_7_TARGETS) $(LAYOUT_SSTL_PD_6_TARGETS) $(LAYOUT_SSTL_PU_6_TARGETS)
	$(PYTHON) scripts/sstl_res_result.py --post-layout

out/results/post_layout_sstl_%_resistance.json: $(LAYOUT_SSTL_PD_7_TARGETS) $(LAYOUT_SSTL_PU_7_TARGETS) $(LAYOUT_SSTL_PD_6_TARGETS) $(LAYOUT_SSTL_PU_6_TARGETS)
	$(PYTHON) scripts/sstl_res_result.py --post-layout

out/post_layout_sstl_pd_7_cal_sim_%/out.json: spice/post_layout_sstl_res_tb.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --post-layout --dir pd --num-leg-en 7 --voltage $(V) --temp $(T) --process $(P)

out/post_layout_sstl_pu_7_cal_sim_%/out.json: spice/post_layout_sstl_res_tb.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --post-layout --dir pu --num-leg-en 7 --voltage $(V) --temp $(T) --process $(P)

out/post_layout_sstl_pd_6_cal_sim_%/out.json: spice/post_layout_sstl_res_tb.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --post-layout --dir pd --num-leg-en 6 --voltage $(V) --temp $(T) --process $(P)

out/post_layout_sstl_pu_6_cal_sim_%/out.json: spice/post_layout_sstl_res_tb.spice | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_res.py --post-layout --dir pu --num-leg-en 6 --voltage $(V) --temp $(T) --process $(P)

# POST LAYOUT SSTL SLEW SIMULATIONS
LAYOUT_SSTL_SLEW_7_TARGETS:=$(addprefix out/post_layout_sstl_7_slew_, $(addsuffix /out.json,$(CORNS) ))
LAYOUT_SSTL_SLEW_6_TARGETS:=$(addprefix out/post_layout_sstl_6_slew_, $(addsuffix /out.json,$(CORNS) ))

.PHONY: post-layout-sstl-slew-sim
post-layout-sstl-slew-sim: $(LAYOUT_SSTL_SLEW_7_TARGETS)
	# NOTE: the the spec only specifies a slew requirement for the 7-leg configuraiton, 
	# so the 6-leg configuration slew tests are not run by default.
	$(PYTHON) scripts/sstl_slew_result.py --post-layout

out/post_layout_sstl_7_slew_%/out.json: spice/post_layout_sstl_slew_tb.spice out/results/post_layout_sstl_pu_7_resistance.json out/results/post_layout_sstl_pd_7_resistance.json | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_slew.py --post-layout --num-leg-en 7 --voltage $(V) --temp $(T) --process $(P)

out/post_layout_sstl_6_slew_%/out.json: spice/post_layout_sstl_slew_tb.spice out/results/post_layout_sstl_pu_6_resistance.json out/results/post_layout_sstl_pd_6_resistance.json | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_slew.py --post-layout --num-leg-en 6 --voltage $(V) --temp $(T) --process $(P)

# POST LAYOUT CAPACITANCE SIMULATIONS
LAYOUT_SSTL_CAP_TARGETS:=$(addprefix out/post_layout_sstl_cap_, $(addsuffix /out.json,$(CORNS) ))

.PHONY: post-layout-sstl-cap-sim
post-layout-sstl-cap-sim: $(LAYOUT_SSTL_CAP_TARGETS)
	$(PYTHON) scripts/sstl_cap_result.py --post-layout

out/post_layout_sstl_cap_%/out.json: spice/post_layout_sstl_cap_tb.spice out/results/post_layout_sstl_pu_7_resistance.json out/results/post_layout_sstl_pd_7_resistance.json | out
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	$(PYTHON) scripts/sim_sstl_cap.py --post-layout --voltage $(V) --temp $(T) --process $(P)



.PHONY: list-corners
list-corners: 
	# $(foreach c,$(SIMPLE_N_LEG_TARGETS), ${c})

decode-corner_%:
	$(eval T= `$(PYTHON) scripts/decode_corn_string.py $* t` )
	$(eval V= `$(PYTHON) scripts/decode_corn_string.py $* v` )
	$(eval P= `$(PYTHON) scripts/decode_corn_string.py $* p` )
	echo "Voltage=$(V) Temp=$(T) Process=$(P)"

out:
	mkdir out

### TOOL INSTALATION ##########################################################

NGSPICEREPO=https://github.com/imr/ngspice.git
NGSPICEREV=87b9df668 
XSCHEMREPO=https://github.com/StefanSchippers/xschem.git
XSCHEMREV=290fc3c 
MAGICREPO=https://github.com/RTimothyEdwards/magic.git
MAGICREV=8.3.291
NETGENREPO=https://github.com/RTimothyEdwards/netgen.git
NETGENREV=bfb01e0

NGSPICE=./tools/ngspice-install/bin/ngspice
$(NGSPICE):
	########## INSTALLING NGSPICE ##########
	git clone ${NGSPICEREPO} ./tools/ngspice-src
	cd ./tools/ngspice-src &&\
		git checkout ${NGSPICEREV} &&\
		source /opt/rh/devtoolset-8/enable &&\
		./autogen.sh &&\
		./configure --prefix=`pwd`/../ngspice-install --enable-openmp --enable-xspice &&\
		make &&\
		make install
.PHONY: install-ngspice
install-ngspice: $(NGSPICE)
.PHONY: launch-ngspice
launch-ngspice: $(NGSPICE)
ifndef args
	# TO ADD ARGS, use "make launch-ngspice args=<ARGS_TO_PASS_IN>"
	${NGSPICE} 
else
	${NGSPICE} ${args}
endif

XSCHEM=./tools/xschem-install/bin/xschem
$(XSCHEM): 
	########## INSTALLING XSCHEM ##########
	git clone ${XSCHEMREPO} ./tools/xschem-src
	cd ./tools/xschem-src &&\
		git checkout ${XSCHEMREV} &&\
		source /opt/rh/devtoolset-8/enable &&\
		./configure --prefix=`pwd`/../xschem-install &&\
		make &&\
		make install
	ln -s ${PDKSPATH}/${PDKNAME}/libs.tech/xschem/ ./tools/xschem-install/share/xschem/xschem_library/sky130	
.PHONY: install-xschem
install-xschem: $(XSCHEM)
.PHONY: launch-xschem
launch-xschem: $(XSCHEM)
ifndef args
	# TO ADD ARGS, use "make launch-xschem args=<ARGS_TO_PASS_IN>"
	export PDK_ROOT=${PDKSPATH} && ${XSCHEM} --rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/xschem/xschemrc
else
	export PDK_ROOT=${PDKSPATH} && ${XSCHEM} --rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/xschem/xschemrc ${args}
endif

MAGIC=./tools/magic-install/bin/magic
$(MAGIC): 
	########## INSTALLING MAGIC ##########
	git clone ${MAGICREPO} ./tools/magic-src
	cd ./tools/magic-src &&\
		git checkout ${MAGICREV} &&\
		source /opt/rh/devtoolset-8/enable &&\
		./configure --prefix=`pwd`/../magic-install &&\
		make &&\
		make install
.PHONY: install-magic
install-magic: $(MAGIC)
.PHONY: launch-magic
launch-magic: $(MAGIC)
ifndef args
	# TO ADD ARGS, use "make launch-magic args=<ARGS_TO_PASS_IN>"
	export PDK_ROOT=${PDKSPATH} && ${MAGIC} -d XR -rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/magic/${PDKNAME}.magicrc 
else
	export PDK_ROOT=${PDKSPATH} && ${MAGIC} -d XR -rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/magic/${PDKNAME}.magicrc ${args}
endif

NETGEN=./tools/netgen-install/bin/netgen
$(NETGEN): 
	########## INSTALLING NETGEN ##########
	git clone ${NETGENREPO} ./tools/netgen-src
	cd ./tools/netgen-src &&\
		git checkout ${NETGENREV} &&\
		source /opt/rh/devtoolset-8/enable &&\
		./configure --prefix=`pwd`/../netgen-install &&\
		make &&\
		make install
.PHONY: install-netgen
install-netgen: $(NETGEN)
.PHONY: launch-netgen
launch-netgen: $(NETGEN)
ifndef args
	# TO ADD ARGS, use "make launch-netgen args=<ARGS_TO_PASS_IN>"
	${NETGEN}
else
	${NETGEN} ${args}
endif

.PHONY: netgen-lvs-compare
netgen-lvs-compare: $(NETGEN)
	# USAGE: make netgen-lvs-compare cell1="<FILE1> <CELL_NAME>" cell2="<FILE2> <CELL_NAME>"
	# (If the netlist is not a subcircuit in a file then cell1="<FILE1>" is suffecient.)
	# 
	${NETGEN} -batch lvs "${cell1}" "${cell2}" ./pdk/libs.tech/netgen/sky130A_setup.tcl lvs_result.txt
	# If LVS completed, see "lvs_result.txt" for details

.PHONY: install-tools
.DEFAULT_GOAL:=
install-tools: $(NGSPICE) $(XSCHEM) $(MAGIC) $(NETGEN) pdk
	
pdk:
	ln -s ${PDKSPATH}/${PDKNAME} pdk

.PHONY: clean-tools
clean-tools: $(clean-output)
	rm -rvf ./tools
	unlink pdk

.PHONY: clean-output
clean-output:
	rm -rvf ./out

.PHONY: clean-spice
clean-spice:
	rm -rvf ./spice

.PHONY: edit
edit:
	gnome-text-editor Makefile &

.PHONY: devtoolset-test
devtoolset-test:
	source /opt/rh/devtoolset-8/enable &&\
	gcc -v

.PHONY: echo
echo:
	echo "Makefile test!"

