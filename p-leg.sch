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
N 340 -390 360 -390 { lab=n_cal_ctrl[0]}
N 560 -390 580 -390 { lab=n_cal_ctrl[1]}
N 400 -420 620 -420 { lab=#net1}
N 400 -360 620 -360 { lab=DQ}
N 340 -290 360 -290 { lab=n_cal_ctrl[2]}
N 560 -290 580 -290 { lab=n_cal_ctrl[3]}
N 400 -320 540 -320 { lab=#net1}
N 400 -260 540 -260 { lab=DQ}
N 470 -420 470 -320 { lab=#net1}
N 490 -360 490 -260 { lab=DQ}
N 540 -320 620 -320 { lab=#net1}
N 540 -260 620 -260 { lab=DQ}
N 590 -450 690 -450 { lab=n_pu_ctrl}
N 730 -520 730 -480 { lab=v1v5}
N 730 -420 730 -320 { lab=#net1}
N 1000 -290 1010 -290 { lab=VDD}
N 400 -390 410 -390 { lab=VDD}
N 620 -390 630 -390 { lab=VDD}
N 400 -290 410 -290 { lab=VDD}
N 620 -290 630 -290 { lab=VDD}
N 240 -450 260 -450 { lab=n_cal_ctrl[3:0]
bus=true}
N 270 -390 340 -390 { lab=n_cal_ctrl[0]}
N 270 -340 560 -340 { lab=n_cal_ctrl[1]}
N 560 -390 560 -340 { lab=n_cal_ctrl[1]}
N 270 -290 340 -290 { lab=n_cal_ctrl[2]}
N 270 -240 560 -240 { lab=n_cal_ctrl[3]}
N 560 -290 560 -240 { lab=n_cal_ctrl[3]}
N 260 -450 260 -250 {bus=true lab=n_cal_ctrl[3:0]}
N 730 -260 730 -180 { lab=DQ}
N 730 -180 820 -180 { lab=DQ}
N 730 -450 770 -450 { lab=VDD}
N 770 -520 770 -450 { lab=VDD}
N 700 -520 730 -520 { lab=v1v5}
N 950 -290 960 -290 { lab=n_cal_ctrl[0]}
N 620 -320 730 -320 { lab=#net1}
N 620 -260 730 -260 { lab=DQ}
N 1000 -320 1000 -260 { lab=VDD}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/vdd.sym} 770 -520 0 0 {name=l3 lab=VDD}
C {sky130/sky130_fd_pr/res_generic_po.sym} 730 -290 0 0 {name=R1
W=0.33
L=1.8
model=res_generic_po
mult=1}
C {devices/vdd.sym} 1010 -290 1 0 {name=l21 lab=VDD}
C {devices/vdd.sym} 410 -390 1 0 {name=l5 lab=VDD}
C {devices/vdd.sym} 630 -390 1 0 {name=l9 lab=VDD}
C {devices/vdd.sym} 410 -290 1 0 {name=l11 lab=VDD}
C {devices/vdd.sym} 630 -290 1 0 {name=l13 lab=VDD}
C {devices/ipin.sym} 240 -450 0 0 {name=p1 lab=n_cal_ctrl[3:0]}
C {devices/bus_connect.sym} 260 -400 1 0 {name=l6 lab=n_cal_ctrl[0]}
C {devices/bus_connect.sym} 260 -300 1 0 {name=l2 lab=n_cal_ctrl[2]}
C {devices/bus_connect.sym} 260 -350 1 0 {name=l8 lab=n_cal_ctrl[1]}
C {devices/bus_connect.sym} 260 -250 1 0 {name=l4 lab=n_cal_ctrl[3]}
C {devices/ipin.sym} 590 -450 0 0 {name=p2 lab=n_pu_ctrl}
C {devices/iopin.sym} 820 -180 0 0 {name=p3 lab=DQ}
C {devices/ipin.sym} 700 -520 0 0 {name=p4 lab=v1v5}
C {devices/lab_pin.sym} 950 -290 0 0 {name=l7 sig_type=std_logic lab=n_cal_ctrl[0]}
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 710 -450 0 0 {name=Mpullup
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
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 980 -290 0 0 {name=Mctrltot
L=0.35
W=1
nf=1
mult=120
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 380 -390 0 0 {name=Mctrl0
L=0.35
W=1
nf=1
mult=64
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 600 -390 0 0 {name=Mctrl1
L=0.35
W=1
nf=1
mult=16
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 380 -290 0 0 {name=Mctrl2
L=0.35
W=1
nf=1
mult=8
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130/sky130_fd_pr/pfet_01v8_lvt.sym} 600 -290 0 0 {name=Mctrl3
L=0.35
W=1
nf=1
mult=4
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
