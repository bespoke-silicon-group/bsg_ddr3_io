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
N 640 -550 640 -510 { lab=v1v5}
N 540 -550 540 -540 { lab=VDD}
N 540 -480 600 -480 { lab=#net1}
N 640 -450 640 -430 { lab=#net2}
N 640 -370 640 -350 { lab=#net3}
N 640 -290 640 -270 { lab=VDDQ}
N 640 -110 640 -90 { lab=GND}
N 750 -110 750 -90 { lab=VDDQ}
N 640 -170 750 -170 { lab=v1v5}
N 640 -480 670 -480 { lab=VDD}
N 670 -510 670 -480 { lab=VDD}
N 780 -510 780 -450 { lab=#net4}
N 740 -480 780 -480 { lab=#net4}
N 900 -510 900 -450 { lab=#net5}
N 860 -480 900 -480 { lab=#net5}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 840 -200 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="

* power voltage
vvdd VDD 0 1.8

*.param rwidth=4.6

.control
save all
set temp=SED_temp_SED

* RUN SIMULATION
dc Vpinvoltage 0.3 1.2 0.05
* OUTPUT
print (SED_v1v5_SED-vddq)/i(vtest)
wrdata out/data/SED_plotName_SED.txt (SED_v1v5_SED-vddq)/i(vtest)
set hcopydevtype = svg
hardcopy ./out/plots/SED_plotName_SED.svg (SED_v1v5_SED-vddq)/I(vtest) vs vddq title 'Resistance vs pin voltage'

.endc
"}
C {devices/code.sym} 980 -200 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./libs/SED_process_SED_lib.spice SED_process_SED
"
spice_ignore=false}
C {devices/vdd.sym} 540 -550 0 0 {name=l5 lab=VDD}
C {devices/vsource.sym} 540 -510 0 0 {name=Vgate value=SED_vg_SED}
C {devices/vdd.sym} 670 -510 0 0 {name=l6 lab=VDD}
C {sky130_fd_pr/res_generic_po.sym} 640 -400 0 0 {name=R1
W=0.33
L=1.8
model=res_generic_po
mult=1}
C {devices/ammeter.sym} 640 -320 0 0 {name=vtest}
C {devices/lab_pin.sym} 640 -270 0 0 {name=l7 sig_type=std_logic lab=VDDQ}
C {sky130/sky130_fd_pr/pfet_01v8_hvt.sym} 760 -480 0 0 {name=M2
L=0.15
W=1
nf=1
mult=256
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_hvt
spiceprefix=X
}
C {devices/vsource.sym} 640 -140 0 0 {name=V1v5 value=SED_v1v5_SED}
C {devices/vsource.sym} 750 -140 0 0 {name=Vpinvoltage value=0}
C {devices/gnd.sym} 640 -90 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 750 -90 0 0 {name=l3 sig_type=std_logic lab=VDDQ}
C {devices/lab_pin.sym} 640 -550 0 0 {name=l4 sig_type=std_logic lab=v1v5}
C {sky130/sky130_fd_pr/pfet_01v8.sym} 880 -480 0 0 {name=M1
L=0.15
W=1
nf=1
mult=256
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 620 -480 0 0 {name=M3
L=0.35
W=1
nf=1
mult=128
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/lab_pin.sym} 640 -170 0 0 {name=l8 sig_type=std_logic lab=v1v5}
