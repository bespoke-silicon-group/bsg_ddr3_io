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
*L=1.73
L=1.7
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
*mult=64
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
C {devices/lab_pin.sym} 1060 -380 0 0 {name=l2 sig_type=std_logic lab=vpulldown}
C {devices/vsource.sym} 970 -300 0 0 {name=Vgate value=SED_vg_SED}
