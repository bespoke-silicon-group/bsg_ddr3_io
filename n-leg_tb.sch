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
N 1020 -520 1020 -490 { lab=VDDQ}
N 500 -220 500 -210 { lab=cal_ctrl[3]}
N 500 -150 500 -140 { lab=GND}
N 370 -220 370 -210 { lab=cal_ctrl[2]}
N 370 -150 370 -140 { lab=GND}
N 240 -220 240 -210 { lab=cal_ctrl[1]}
N 240 -150 240 -140 { lab=GND}
N 100 -220 100 -210 { lab=cal_ctrl[0]}
N 100 -150 100 -140 { lab=GND}
N 1020 -430 1020 -410 { lab=DQ}
N 490 -350 490 -330 { lab=GND}
N 500 -280 500 -220 { lab=cal_ctrl[3]}
N 370 -280 370 -220 { lab=cal_ctrl[2]}
N 240 -280 240 -220 { lab=cal_ctrl[1]}
N 100 -280 100 -220 { lab=cal_ctrl[0]}
N 90 -290 540 -290 {lab=cal_ctrl[3:0]
bus=true}
N 490 -410 540 -410 { lab=pd_ctrl}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 790 -200 0 0 {name=STIMULI 
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
C {devices/code.sym} 930 -200 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./libs/SED_process_SED_lib.spice SED_process_SED
"
spice_ignore=false}
C {devices/lab_pin.sym} 1020 -520 0 0 {name=l3 sig_type=std_logic lab=VDDQ
}
C {devices/ammeter.sym} 1020 -460 0 0 {name=vtest}
C {devices/gnd.sym} 490 -340 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 490 -380 0 0 {name=Vgate value=SED_vg_SED}
C {devices/vsource.sym} 100 -180 0 0 {name=Vctrl0
*value=0
value=SED_vctrl0_SED}
C {devices/gnd.sym} 500 -140 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} 370 -140 0 0 {name=l15 lab=GND}
C {devices/gnd.sym} 240 -140 0 0 {name=l17 lab=GND}
C {devices/gnd.sym} 100 -140 0 0 {name=l19 lab=GND}
C {devices/vsource.sym} 240 -180 0 0 {name=Vctrl1
*value=0
value=SED_vctrl1_SED}
C {devices/vsource.sym} 370 -180 0 0 {name=Vctrl2
*value=0
value=SED_vctrl2_SED}
C {devices/vsource.sym} 500 -180 0 0 {name=Vctrl3
*value=0
value=SED_vctrl3_SED}
C {/mnt/users/ssd2/homes/hinesd3/proj/n-leg-design/n-leg.sym} 520 -230 0 0 {name=X1}
C {/mnt/users/ssd2/homes/hinesd3/proj/n-leg-design/tools/xschem-install/share/xschem/xschem_library/devices/bus_connect.sym} 90 -290 1 0 {name=l2 lab=cal_ctrl[0]}
C {/mnt/users/ssd2/homes/hinesd3/proj/n-leg-design/tools/xschem-install/share/xschem/xschem_library/devices/bus_connect.sym} 230 -290 1 0 {name=l5 lab=cal_ctrl[1]}
C {/mnt/users/ssd2/homes/hinesd3/proj/n-leg-design/tools/xschem-install/share/xschem/xschem_library/devices/bus_connect.sym} 490 -290 1 0 {name=l6 lab=cal_ctrl[3]}
C {/mnt/users/ssd2/homes/hinesd3/proj/n-leg-design/tools/xschem-install/share/xschem/xschem_library/devices/bus_connect.sym} 360 -290 1 0 {name=l8 lab=cal_ctrl[2]}
C {devices/lab_pin.sym} 490 -410 0 0 {name=l10 sig_type=std_logic lab=pd_ctrl}
C {devices/lab_pin.sym} 1020 -410 2 0 {name=l11 sig_type=std_logic lab=DQ}
C {devices/lab_wire.sym} 480 -290 0 0 {name=l12 sig_type=std_logic_vector lab=cal_ctrl[3:0]}
