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
N 350 -360 380 -360 { lab=pu_cal[0:3]}
N 350 -300 380 -300 { lab=pd_cal[0:3]}
N 860 -330 920 -330 { lab=DQ}
N 980 -330 1000 -330 { lab=VDDQ}
N 320 -390 380 -390 { lab=pu_ctrl[0:6]}
N 320 -270 380 -270 { lab=pd_ctrl[0:6]}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 790 -200 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="
* power voltage
vvdd VDD 0 SED_vdd_SED

** LEG CONTROL **
vpu_ctrl0 pu_ctrl[0] 0 SED_puctrl0_SED
vpu_ctrl1 pu_ctrl[1] 0 SED_puctrl1_SED 
vpu_ctrl2 pu_ctrl[2] 0 SED_puctrl2_SED 
vpu_ctrl3 pu_ctrl[3] 0 SED_puctrl3_SED 
vpu_ctrl4 pu_ctrl[4] 0 SED_puctrl4_SED 
vpu_ctrl5 pu_ctrl[5] 0 SED_puctrl5_SED 
vpu_ctrl6 pu_ctrl[6] 0 SED_puctrl6_SED 
* PULLDOWN
vpd_ctrl0 pd_ctrl[0] 0 SED_pdctrl0_SED
vpd_ctrl1 pd_ctrl[1] 0 SED_pdctrl1_SED 
vpd_ctrl2 pd_ctrl[2] 0 SED_pdctrl2_SED 
vpd_ctrl3 pd_ctrl[3] 0 SED_pdctrl3_SED 
vpd_ctrl4 pd_ctrl[4] 0 SED_pdctrl4_SED 
vpd_ctrl5 pd_ctrl[5] 0 SED_pdctrl5_SED 
vpd_ctrl6 pd_ctrl[6] 0 SED_pdctrl6_SED 

** CALIBRATION CONTROL **
* PULLUP
vpu_cal0 pu_cal[0] 0 SED_pucal0_SED
vpu_cal1 pu_cal[1] 0 SED_pucal1_SED
vpu_cal2 pu_cal[2] 0 SED_pucal2_SED
vpu_cal3 pu_cal[3] 0 SED_pucal3_SED
* PULLDOWN
vpd_cal0 pd_cal[0] 0 SED_pdcal0_SED
vpd_cal1 pd_cal[1] 0 SED_pdcal1_SED
vpd_cal2 pd_cal[2] 0 SED_pdcal2_SED
vpd_cal3 pd_cal[3] 0 SED_pdcal3_SED

* INPUT SIGNAL
*                vlow,       vhigh, delay, risetime, falltime, pulsewidth, period, phase
vvddq vddq 0 0 PULSE 0 SED_vdd_SED  0.25n  10p       10p       2n          4n      0

.control
save all
set temp=SED_temp_SED
set num_threads=6

* RUN SIMULATION
tran 1p 4.25n
* Measure rise time
meas tran tdiff_charge    trig at=0.25n targ dq val=SED_vih_SED rise=1
* Measure fall time
meas tran tdiff_discharge trig at=2.25n targ dq val=SED_vil_SED fall=1

* OUTPUT
wrdata ./out/SED_plotName_SED/SED_plotName_SED.txt tdiff_charge tdiff_discharge
set hcopydevtype = svg
hardcopy ./out/SED_plotName_SED/SED_plotName_SED.svg dq vddq title 'DQ vs time'

.endc
"}
C {devices/code.sym} 930 -200 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./sky130/libs/SED_process_SED_lib.spice SED_process_SED
.include \\\\$::SKYWATER_STDCELLS\\\\/sky130_fd_sc_hd.spice
.include ./layout/pex_SSTL.spice
"
spice_ignore=false}
C {devices/lab_wire.sym} 860 -330 2 0 {name=l9 sig_type=std_logic lab=DQ}
C {devices/lab_wire.sym} 1000 -330 0 1 {name=l11 sig_type=std_logic lab=VDDQ}
C {devices/lab_pin.sym} 350 -360 0 0 {name=l13 sig_type=std_logic lab=pu_cal[0:3]}
C {devices/lab_pin.sym} 350 -300 0 0 {name=l14 sig_type=std_logic lab=pd_cal[0:3]}
C {devices/res.sym} 950 -330 1 0 {name=Rtb
value=25
footprint=1206
device=resistor
m=1}
C {schem/post_layout_SSTL.sym} 360 -210 0 0 {name=X1}
C {devices/gnd.sym} 460 -210 0 0 {name=l19 lab=GND}
C {devices/vdd.sym} 460 -450 0 0 {name=l20 lab=VDD}
C {devices/lab_pin.sym} 320 -390 0 0 {name=l2 sig_type=std_logic lab=pu_ctrl[0:6]}
C {devices/lab_pin.sym} 320 -270 0 0 {name=l3 sig_type=std_logic lab=pd_ctrl[0:6]}
