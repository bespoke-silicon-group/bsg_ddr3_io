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
N 530 -490 530 -480 { lab=VDD}
N 400 -490 400 -480 { lab=VDD}
N 270 -490 270 -480 { lab=VDD}
N 130 -490 130 -480 { lab=VDD}
N 490 -320 490 -310 { lab=VDD}
N 1050 -250 1050 -230 { lab=DQ}
N 1050 -170 1050 -150 { lab=VDDQ}
N 570 -120 570 -100 { lab=VDDQ}
N 460 -120 460 -110 { lab=GND}
N 460 -180 570 -180 { lab=v1v5}
N 140 -370 570 -370 { lab=n_cal_ctrl[3:0]
bus=true}
N 530 -420 530 -380 { lab=n_cal_ctrl[3]}
N 400 -420 400 -380 { lab=n_cal_ctrl[2]}
N 270 -420 270 -380 { lab=n_cal_ctrl[1]}
N 130 -420 130 -380 { lab=n_cal_ctrl[0]}
N 490 -250 570 -250 { lab=n_pu_ctrl}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 670 -180 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="

* power voltage
vvdd VDD 0 1.8

.control
save all
set temp=SED_temp_SED

* RUN SIMULATION
dc Vpinvoltage 0.3 1.2 0.05
* OUTPUT
print (1.5-vddq)/i(vtest)
wrdata out/data/SED_plotName_SED.txt (1.5-vddq)/i(vtest)
set hcopydevtype = svg
hardcopy ./out/plots/SED_plotName_SED.svg (1.5-vddq)/I(vtest) vs vddq title 'Resistance vs pin voltage'

.endc
"}
C {devices/code.sym} 810 -180 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./libs/SED_process_SED_lib.spice SED_process_SED
"
spice_ignore=false}
C {devices/vsource.sym} 130 -450 0 0 {name=Vctrl0
*value=0
value=SED_vctrl0_SED}
C {devices/vsource.sym} 270 -450 0 0 {name=Vctrl1
*value=0
value=SED_vctrl1_SED}
C {devices/vsource.sym} 400 -450 0 0 {name=Vctrl2
*value=0
value=SED_vctrl2_SED}
C {devices/vsource.sym} 530 -450 0 0 {name=Vctrl3
*value=0
value=SED_vctrl3_SED}
C {devices/vsource.sym} 490 -280 0 0 {name=Vgate
value=SED_vg_SED
}
C {devices/vdd.sym} 490 -320 0 0 {name=l2 lab=VDD}
C {devices/ammeter.sym} 1050 -200 0 0 {name=Vtest}
C {devices/lab_pin.sym} 1050 -150 0 0 {name=l4 sig_type=std_logic lab=VDDQ}
C {devices/vdd.sym} 530 -490 0 0 {name=l7 lab=VDD}
C {devices/vdd.sym} 400 -490 0 0 {name=l15 lab=VDD}
C {devices/vdd.sym} 270 -490 0 0 {name=l17 lab=VDD}
C {devices/vdd.sym} 130 -490 0 0 {name=l19 lab=VDD}
C {devices/vsource.sym} 460 -150 0 0 {name=V1v5
value=SED_v1v5_SED
}
C {devices/vsource.sym} 570 -150 0 0 {name=Vpinvoltage
value=0
}
C {devices/gnd.sym} 460 -110 0 0 {name=l23 lab=GND}
C {devices/lab_pin.sym} 570 -100 0 0 {name=l24 sig_type=std_logic lab=VDDQ}
C {p-leg.sym} 550 -190 0 0 {name=X1}
C {devices/bus_connect.sym} 540 -370 3 0 {name=l3 lab=n_cal_ctrl[3]}
C {devices/bus_connect.sym} 410 -370 3 0 {name=l5 lab=n_cal_ctrl[2]}
C {devices/bus_connect.sym} 280 -370 3 0 {name=l6 lab=n_cal_ctrl[1]}
C {devices/bus_connect.sym} 140 -370 3 0 {name=l8 lab=n_cal_ctrl[0]}
C {devices/lab_wire.sym} 350 -370 2 0 {name=l9 sig_type=std_logic lab=n_cal_ctrl[3:0]}
C {devices/lab_pin.sym} 490 -250 0 0 {name=l10 sig_type=std_logic lab=n_pu_ctrl}
C {devices/lab_pin.sym} 1050 -250 2 0 {name=l11 sig_type=std_logic lab=DQ}
C {devices/lab_pin.sym} 910 -420 0 0 {name=l12 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 460 -180 0 0 {name=l13 sig_type=std_logic lab=v1v5}
