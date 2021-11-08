v {xschem version=3.0.0 file_version=1.2 

* Copyright 2021 Stefan Frederik Schippers
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     https://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.

}
G {}
K {}
V {}
S {}
E {}
N 1060 -500 1060 -460 { lab=#net1}
N 1060 -590 1060 -560 { lab=VDDQ}
N 1060 -400 1060 -360 { lab=vpulldown}
N 1060 -300 1060 -260 { lab=GND}
N 970 -330 1020 -330 { lab=#net2}
N 970 -270 1060 -270 { lab=GND}
N 1060 -330 1060 -300 { lab=GND}
N 730 -530 740 -530 { lab=GND}
N 670 -530 690 -530 { lab=v_ctrl0}
N 860 -340 860 -330 { lab=v_ctrl3}
N 860 -270 860 -260 { lab=GND}
N 950 -530 960 -530 { lab=GND}
N 890 -530 910 -530 { lab=v_ctrl1}
N 730 -560 950 -560 { lab=#net1}
N 730 -500 950 -500 { lab=vpulldown}
N 730 -430 740 -430 { lab=GND}
N 670 -430 690 -430 { lab=v_ctrl2}
N 950 -430 960 -430 { lab=GND}
N 890 -430 910 -430 { lab=v_ctrl3}
N 730 -460 870 -460 { lab=#net1}
N 730 -400 870 -400 { lab=vpulldown}
N 800 -560 800 -460 { lab=#net1}
N 820 -500 820 -400 { lab=vpulldown}
N 750 -340 750 -330 { lab=v_ctrl2}
N 750 -270 750 -260 { lab=GND}
N 640 -340 640 -330 { lab=v_ctrl1}
N 640 -270 640 -260 { lab=GND}
N 520 -340 520 -330 { lab=v_ctrl0}
N 520 -270 520 -260 { lab=GND}
N 870 -460 950 -460 { lab=#net1}
N 870 -400 950 -400 { lab=vpulldown}
N 500 -430 510 -430 { lab=GND}
N 440 -430 460 -430 { lab=v_ctrl0}
N 950 -460 1060 -460 { lab=#net1}
N 950 -400 1060 -400 { lab=vpulldown}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 840 -200 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="

* power voltage
vvddq VDDQ 0 0
*.param rwidth=4.6

.control
save all
set temp=SED_temp_SED

* RUN SIMULATION
dc vvddq 0.3 1.2 0.05
* OUTPUT
print v(vddq)/i(vtest)
wrdata out/data/SED_plotName_SED.txt v(vddq)/i(vtest)
set hcopydevtype = svg
hardcopy ./out/plots/SED_plotName_SED.svg vddq/I(vtest) vs vddq title 'Resistance vs pin voltage'

.endc
"}
C {devices/code.sym} 980 -200 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./libs/SED_process_SED_lib.spice SED_process_SED
"
spice_ignore=false}
C {sky130_fd_pr/res_generic_po.sym} 1060 -430 0 0 {name=R1
W=0.33
L=1.73
model=res_generic_po
mult=1}
C {devices/lab_pin.sym} 1060 -590 0 0 {name=l3 sig_type=std_logic lab=VDDQ
}
C {devices/ammeter.sym} 1060 -530 0 0 {name=vtest}
C {devices/gnd.sym} 1060 -260 0 0 {name=l4 lab=GND}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 1040 -330 0 0 {name=n1
L=0.15
W=0.65
nf=1 
mult=64
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 1060 -380 0 0 {name=l2 sig_type=std_logic lab=vpulldown}
C {devices/vsource.sym} 970 -300 0 0 {name=Vgate value=SED_vg_SED}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 710 -530 0 0 {name=nctrl0
L=0.15
W=0.65
nf=1 
mult=12
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/gnd.sym} 740 -530 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 520 -300 0 0 {name=Vctrl0
*value=0
value=SED_vg_SED
*value=SED_ctrl0_SED}
C {devices/lab_pin.sym} 670 -530 0 0 {name=l6 sig_type=std_logic lab=v_ctrl0}
C {devices/gnd.sym} 860 -260 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 860 -340 0 0 {name=l8 sig_type=std_logic lab=v_ctrl3}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 930 -530 0 0 {name=nctrl1
L=0.15
W=0.65
nf=1 
mult=6
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/gnd.sym} 960 -530 0 0 {name=l9 lab=GND}
C {devices/lab_pin.sym} 890 -530 0 0 {name=l10 sig_type=std_logic lab=v_ctrl1}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 710 -430 0 0 {name=nctrl2
L=0.15
W=0.65
nf=1 
mult=3
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/gnd.sym} 740 -430 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 670 -430 0 0 {name=l12 sig_type=std_logic lab=v_ctrl2}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 930 -430 0 0 {name=nctrl3
L=0.15
W=0.975
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/gnd.sym} 960 -430 0 0 {name=l13 lab=GND}
C {devices/lab_pin.sym} 890 -430 0 0 {name=l14 sig_type=std_logic lab=v_ctrl3}
C {devices/gnd.sym} 750 -260 0 0 {name=l15 lab=GND}
C {devices/lab_pin.sym} 750 -340 0 0 {name=l16 sig_type=std_logic lab=v_ctrl2}
C {devices/gnd.sym} 640 -260 0 0 {name=l17 lab=GND}
C {devices/lab_pin.sym} 640 -340 0 0 {name=l18 sig_type=std_logic lab=v_ctrl1
}
C {devices/gnd.sym} 520 -260 0 0 {name=l19 lab=GND}
C {devices/lab_pin.sym} 520 -340 0 0 {name=l20 sig_type=std_logic lab=v_ctrl0}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 480 -430 0 0 {name=nctrl_tot
L=0.15
W=0.65
nf=1 
mult=22
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/gnd.sym} 510 -430 0 0 {name=l21 lab=GND}
C {devices/lab_pin.sym} 440 -430 0 0 {name=l22 sig_type=std_logic lab=v_ctrl0}
C {devices/vsource.sym} 640 -300 0 0 {name=Vctrl1
*value=0
value=SED_vg_SED
*value=SED_ctrl0_SED}
C {devices/vsource.sym} 750 -300 0 0 {name=Vctrl2
*value=0
value=SED_vg_SED
*value=SED_ctrl0_SED}
C {devices/vsource.sym} 860 -300 0 0 {name=Vctrl3
*value=0
value=SED_vg_SED
*value=SED_ctrl0_SED}
