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
N 730 -360 730 -320 { lab=DQ}
N 730 -260 730 -220 { lab=vpulldown}
N 730 -160 730 -120 { lab=GND}
N 730 -190 730 -160 { lab=GND}
N 400 -390 410 -390 { lab=GND}
N 620 -390 630 -390 { lab=GND}
N 400 -420 620 -420 { lab=DQ}
N 400 -360 620 -360 { lab=vpulldown}
N 400 -290 410 -290 { lab=GND}
N 620 -290 630 -290 { lab=GND}
N 400 -320 540 -320 { lab=DQ}
N 400 -260 540 -260 { lab=vpulldown}
N 470 -420 470 -320 { lab=DQ}
N 490 -360 490 -260 { lab=vpulldown}
N 540 -320 620 -320 { lab=DQ}
N 540 -260 620 -260 { lab=vpulldown}
N 620 -320 730 -320 { lab=DQ}
N 620 -260 730 -260 { lab=vpulldown}
N 730 -420 750 -420 { lab=DQ}
N 290 -390 360 -390 { lab=cal_ctrl[0]}
N 290 -290 360 -290 { lab=cal_ctrl[2]}
N 280 -480 280 -250 { lab=cal_ctrl[3:0]
bus=true}
N 580 -390 580 -340 { lab=cal_ctrl[1]}
N 290 -340 580 -340 { lab=cal_ctrl[1]}
N 580 -290 580 -240 { lab=cal_ctrl[3]}
N 290 -240 580 -240 { lab=cal_ctrl[3]}
N 270 -480 280 -480 { lab=cal_ctrl[3:0]
bus=true}
N 610 -190 620 -190 { lab=pd_ctrl}
N 680 -190 690 -190 { lab=#net1}
N 730 -420 730 -360 { lab=DQ}
N 620 -190 680 -190 {}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {sky130_fd_pr/res_generic_po.sym} 730 -290 0 0 {name=R1
W=0.33
L=1.7
model=res_generic_po
mult=1}
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
C {sky130/sky130_fd_pr/nfet_01v8.sym} 380 -390 0 0 {name=nctrl0
L=0.15
W=0.65
nf=1 
mult=32
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
C {sky130/sky130_fd_pr/nfet_01v8.sym} 600 -390 0 0 {name=nctrl1
L=0.15
W=0.65
nf=1 
mult=8
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
C {sky130/sky130_fd_pr/nfet_01v8.sym} 380 -290 0 0 {name=nctrl2
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
C {devices/gnd.sym} 410 -290 0 0 {name=l11 lab=GND}
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
C {devices/iopin.sym} 750 -420 0 0 {name=p1 lab=DQ}
C {devices/ipin.sym} 610 -190 0 0 {name=p2 lab=pd_ctrl}
C {devices/bus_connect.sym} 280 -250 1 0 {name=l3 lab=cal_ctrl[3]}
C {devices/bus_connect.sym} 280 -350 1 0 {name=l6 lab=cal_ctrl[1]}
C {devices/bus_connect.sym} 280 -300 1 0 {name=l7 lab=cal_ctrl[2]}
C {devices/bus_connect.sym} 280 -400 1 0 {name=l8 lab=cal_ctrl[0]}
C {devices/ipin.sym} 270 -480 0 0 {name=p3 lab=cal_ctrl[3:0]}
