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
N 730 -360 730 -320 { lab=#net1}
N 730 -450 730 -420 { lab=VDDQ}
N 730 -260 730 -220 { lab=vpulldown}
N 730 -160 730 -120 { lab=GND}
N 640 -190 690 -190 { lab=#net2}
N 640 -130 730 -130 { lab=GND}
N 730 -190 730 -160 { lab=GND}
N 400 -390 410 -390 { lab=GND}
N 340 -390 360 -390 { lab=v_ctrl0}
N 510 -200 510 -190 { lab=v_ctrl3}
N 510 -130 510 -120 { lab=GND}
N 620 -390 630 -390 { lab=GND}
N 560 -390 580 -390 { lab=v_ctrl1}
N 400 -420 620 -420 { lab=#net1}
N 400 -360 620 -360 { lab=vpulldown}
N 400 -290 410 -290 { lab=GND}
N 340 -290 360 -290 { lab=v_ctrl2}
N 620 -290 630 -290 { lab=GND}
N 560 -290 580 -290 { lab=v_ctrl3}
N 400 -320 540 -320 { lab=#net1}
N 400 -260 540 -260 { lab=vpulldown}
N 470 -420 470 -320 { lab=#net1}
N 490 -360 490 -260 { lab=vpulldown}
N 380 -200 380 -190 { lab=v_ctrl2}
N 380 -130 380 -120 { lab=GND}
N 250 -200 250 -190 { lab=v_ctrl1}
N 250 -130 250 -120 { lab=GND}
N 110 -200 110 -190 { lab=v_ctrl0}
N 110 -130 110 -120 { lab=GND}
N 540 -320 620 -320 { lab=#net1}
N 540 -260 620 -260 { lab=vpulldown}
N 950 -290 960 -290 { lab=GND}
N 890 -290 910 -290 { lab=v_ctrl0}
N 620 -320 730 -320 { lab=#net1}
N 620 -260 730 -260 { lab=vpulldown}
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
C {sky130_fd_pr/res_generic_po.sym} 730 -290 0 0 {name=R1
W=0.33
L=1.7
model=res_generic_po
mult=1}
C {devices/lab_pin.sym} 730 -450 0 0 {name=l3 sig_type=std_logic lab=VDDQ
}
C {devices/ammeter.sym} 730 -390 0 0 {name=vtest}
C {devices/gnd.sym} 730 -120 0 0 {name=l4 lab=GND}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 710 -190 0 0 {name=n1
L=0.15
W=0.65
nf=1 
mult=48
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 730 -240 0 0 {name=l2 sig_type=std_logic lab=vpulldown}
C {devices/vsource.sym} 640 -160 0 0 {name=Vgate value=SED_vg_SED}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 380 -390 0 0 {name=nctrl0
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
C {devices/gnd.sym} 410 -390 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 110 -160 0 0 {name=Vctrl0
*value=0
value=SED_vctrl0_SED}
C {devices/lab_pin.sym} 340 -390 0 0 {name=l6 sig_type=std_logic lab=v_ctrl0}
C {devices/gnd.sym} 510 -120 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 510 -200 0 0 {name=l8 sig_type=std_logic lab=v_ctrl3}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 600 -390 0 0 {name=nctrl1
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
C {devices/gnd.sym} 630 -390 0 0 {name=l9 lab=GND}
C {devices/lab_pin.sym} 560 -390 0 0 {name=l10 sig_type=std_logic lab=v_ctrl1}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 380 -290 0 0 {name=nctrl2
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
C {devices/gnd.sym} 410 -290 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 340 -290 0 0 {name=l12 sig_type=std_logic lab=v_ctrl2}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 600 -290 0 0 {name=nctrl3
L=0.15
W=0.5
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
C {devices/gnd.sym} 630 -290 0 0 {name=l13 lab=GND}
C {devices/lab_pin.sym} 560 -290 0 0 {name=l14 sig_type=std_logic lab=v_ctrl3}
C {devices/gnd.sym} 380 -120 0 0 {name=l15 lab=GND}
C {devices/lab_pin.sym} 380 -200 0 0 {name=l16 sig_type=std_logic lab=v_ctrl2}
C {devices/gnd.sym} 250 -120 0 0 {name=l17 lab=GND}
C {devices/lab_pin.sym} 250 -200 0 0 {name=l18 sig_type=std_logic lab=v_ctrl1
}
C {devices/gnd.sym} 110 -120 0 0 {name=l19 lab=GND}
C {devices/lab_pin.sym} 110 -200 0 0 {name=l20 sig_type=std_logic lab=v_ctrl0}
C {sky130/sky130_fd_pr/nfet_01v8.sym} 930 -290 0 0 {name=nctrl_tot
L=0.15
W=0.65
nf=1 
mult=11
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/gnd.sym} 960 -290 0 0 {name=l21 lab=GND}
C {devices/lab_pin.sym} 890 -290 0 0 {name=l22 sig_type=std_logic lab=v_ctrl0}
C {devices/vsource.sym} 250 -160 0 0 {name=Vctrl1
*value=0
value=SED_vctrl1_SED}
C {devices/vsource.sym} 380 -160 0 0 {name=Vctrl2
*value=0
value=SED_vctrl2_SED}
C {devices/vsource.sym} 510 -160 0 0 {name=Vctrl3
*value=0
value=SED_vctrl3_SED}
