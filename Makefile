
# CONFIGURE THESE:
PDKSPATH=/gro/cad/pdk


PDKNAME=sky130A

NGSPICEREPO=https://git.code.sf.net/p/ngspice/ngspice
XSCHEMREPO=https://github.com/StefanSchippers/xschem.git
MAGICREPO=https://github.com/RTimothyEdwards/magic.git
NETGENREPO=https://github.com/RTimothyEdwards/netgen.git

NGSPICE=./tools/ngspice-install/bin/ngspice
$(NGSPICE):
	########## INSTALLING NGSPICE ##########
	git clone ${NGSPICEREPO} ./tools/ngspice-src
	cd ./tools/ngspice-src &&\
		source /opt/rh/devtoolset-8/enable &&\
		./autogen.sh &&\
		./configure --prefix=`pwd`/../ngspice-install &&\
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
		source /opt/rh/devtoolset-8/enable &&\
		./configure --prefix=`pwd`/../xschem-install &&\
		make &&\
		make install
	ln -s ${PDKSPATH}/${PDKNAME}/libs.tech/xschem/ ./tools/xschem-install/share/xschem/xschem_library/sky130
	# TODO set up sky130 xschem examples?
.PHONY: install-xschem
install-xschem: $(XSCHEM)
.PHONY: launch-xschem
launch-xschem: $(XSCHEM)
ifndef args
	# TO ADD ARGS, use "make launch-xschem args=<ARGS_TO_PASS_IN>"
	${XSCHEM} --rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/xschem/xschemrc
else
	${XSCHEM} --rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/xschem/xschemrc ${args}
endif

MAGIC=./tools/magic-install/bin/magic
$(MAGIC): 
	########## INSTALLING MAGIC ##########
	git clone ${MAGICREPO} ./tools/magic-src
	cd ./tools/magic-src &&\
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
	${MAGIC} -rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/magic/${PDKNAME}.magicrc &
else
	${MAGIC} -rcfile ${PDKSPATH}/${PDKNAME}/libs.tech/magic/${PDKNAME}.magicrc ${args} &
endif

NETGEN=./tools/netgen-install/bin/netgen
$(NETGEN): 
	########## INSTALLING NETGEN ##########
	git clone ${NETGENREPO} ./tools/netgen-src
	cd ./tools/netgen-src &&\
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


.PHONY: install-tools
.DEFAULT_GOAL:=
install-tools: $(NGSPICE) $(XSCHEM) $(MAGIC) $(NETGEN)
	ln -s ${PDKSPATH}/${PDKNAME} pdk

.PHONY: clean-output
clean-output:
	rm -rvf ./out

.PHONY: clean
clean: $(clean-output)
	rm -rvf ./tools

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

