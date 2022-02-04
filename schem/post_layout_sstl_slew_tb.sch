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
N 860 -330 990 -330 { lab=DQ}
N 930 -270 930 -260 { lab=GND}
N 1110 -270 1110 -250 { lab=GND}
N 1110 -270 1150 -270 { lab=GND}
N 1150 -280 1150 -270 { lab=GND}
N 1050 -330 1110 -330 { lab=VDDQ}
N 1150 -330 1150 -320 { lab=VDD}
N -40 -390 -20 -390 { lab=pub1[0:6]}
N 60 -390 80 -390 { lab=pub2[0:6]}
N 160 -390 180 -390 { lab=pub3[0:6]}
N -40 -270 -20 -270 { lab=pdb1[0:6]}
N 60 -270 80 -270 { lab=pdb2[0:6]}
N 160 -270 180 -270 { lab=pdb3[0:6]}
N 260 -390 380 -390 { lab=pub4[0:6]}
N 260 -270 360 -270 { lab=pdb4[0:6]}
N 360 -270 380 -270 { lab=pdb4[0:6]}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 790 -200 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="
* power voltage
vvdd VDD 0 SED_vdd_SED

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

** LEG ENABLE/DISABLE CONTROL
* PULLUP
*          vlow, vhigh, delay, risetime, falltime, pulsewidth, period, phase
vpu_ctrl0 pu_ctrl[0] 0 0 PULSE 0   SED_puctrl0_SED 1n 10p 10p 5n 10n 0
vpu_ctrl1 pu_ctrl[1] 0 0 PULSE 0   SED_puctrl1_SED 1n 10p 10p 5n 10n 0
vpu_ctrl2 pu_ctrl[2] 0 0 PULSE 0   SED_puctrl2_SED 1n 10p 10p 5n 10n 0
vpu_ctrl3 pu_ctrl[3] 0 0 PULSE 0   SED_puctrl3_SED 1n 10p 10p 5n 10n 0
vpu_ctrl4 pu_ctrl[4] 0 0 PULSE 0   SED_puctrl4_SED 1n 10p 10p 5n 10n 0
vpu_ctrl5 pu_ctrl[5] 0 0 PULSE 0   SED_puctrl5_SED 1n 10p 10p 5n 10n 0
vpu_ctrl6 pu_ctrl[6] 0 0 PULSE 0   SED_puctrl6_SED 1n 10p 10p 5n 10n 0
* PULLDOWN (delay was set to 1.1n for better slew...)
vpd_ctrl0 VDD pd_ctrl[0] 0 PULSE 0 SED_pdctrl0_SED 1n 10p 10p 5n 10n 0
vpd_ctrl1 VDD pd_ctrl[1] 0 PULSE 0 SED_pdctrl1_SED 1n 10p 10p 5n 10n 0
vpd_ctrl2 VDD pd_ctrl[2] 0 PULSE 0 SED_pdctrl2_SED 1n 10p 10p 5n 10n 0
vpd_ctrl3 VDD pd_ctrl[3] 0 PULSE 0 SED_pdctrl3_SED 1n 10p 10p 5n 10n 0
vpd_ctrl4 VDD pd_ctrl[4] 0 PULSE 0 SED_pdctrl4_SED 1n 10p 10p 5n 10n 0
vpd_ctrl5 VDD pd_ctrl[5] 0 PULSE 0 SED_pdctrl5_SED 1n 10p 10p 5n 10n 0
vpd_ctrl6 VDD pd_ctrl[6] 0 PULSE 0 SED_pdctrl6_SED 1n 10p 10p 5n 10n 0

.control
save all
set temp=SED_temp_SED

* RUN SIMULATION
tran 1p 8n
* Measure rise time
meas tran tdiff_rise trig dq val=SED_volac_SED rise=1 targ dq val=SED_vohac_SED rise=1
* Measure fall time
meas tran tdiff_fall trig dq val=SED_vohac_SED fall=1 targ dq val=SED_volac_SED fall=1

* OUTPUT
wrdata ./out/SED_plotName_SED/SED_plotName_SED.txt tdiff_rise tdiff_fall
set hcopydevtype = svg
hardcopy ./out/SED_plotName_SED/SED_plotName_SED.svg dq pu_in_test_4 pd_in_test_4 title 'DQ vs time'

hardcopy ./out/SED_plotName_SED/SED_plotName_SED_DBG.svg 
+ pu_in_test_4 
+ pd_in_test_4 
+ \\"x1.p-leg_6/n_cal_ctrl[0]\\"
+ \\"x1.p-leg_6/n_cal_ctrl[1]\\"
+ \\"x1.p-leg_6/n_cal_ctrl[2]\\"
+ \\"x1.p-leg_6/n_cal_ctrl[3]\\"

hardcopy ./out/SED_plotName_SED/SED_plotName_SED_DBG2.svg 
+ pu_in_test_4 
+ pd_in_test_4 
+ \\"x1.p-leg_0/n_pu_ctrl\\"
+ \\"x1.n-leg_0/pd_ctrl\\"



*plot dq pu_in_test_4 pd_in_test_4 x1.v_pu_ctrl_0 x1.v_pd_ctrl_0

.endc
"}
C {devices/code.sym} 930 -200 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./sky130/libs/SED_process_SED_lib.spice SED_process_SED
.include \\\\$::SKYWATER_STDCELLS\\\\/sky130_fd_sc_hd.spice
.include ./layout/lvs_SSTL.spice
"
spice_ignore=false}
C {devices/lab_wire.sym} 860 -330 2 0 {name=l9 sig_type=std_logic lab=DQ}
C {devices/lab_wire.sym} 1050 -330 0 1 {name=l11 sig_type=std_logic lab=VDDQ}
C {devices/lab_pin.sym} -120 -390 0 0 {name=l3 sig_type=std_logic lab=pu_ctrl[0:6]}
C {devices/lab_pin.sym} -120 -270 0 0 {name=l10 sig_type=std_logic lab=pd_ctrl[0:6]}
C {devices/lab_pin.sym} 350 -360 0 0 {name=l13 sig_type=std_logic lab=pu_cal[0:3]}
C {devices/lab_pin.sym} 350 -300 0 0 {name=l14 sig_type=std_logic lab=pd_cal[0:3]}
C {devices/res.sym} 1020 -330 1 0 {name=Rtb
value=25
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 930 -300 0 0 {name=Cpad
m=1
value=1.4p
*value=491f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 930 -260 0 0 {name=l2 lab=GND}
C {devices/vcvs.sym} 1110 -300 0 1 {name=Ehalf_vdd 
value=0.5}
C {devices/gnd.sym} 1110 -250 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} 1150 -330 0 0 {name=l5 lab=VDD}
C {sky130/sky130_stdcells/clkinv_1.sym} -80 -390 0 0 {name=xpui1[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} -80 -270 0 0 {name=xpdi1[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} -20 -390 0 0 {name=l6 sig_type=std_logic lab=pub1[0:6]}
C {devices/lab_wire.sym} 80 -390 0 0 {name=l7 sig_type=std_logic lab=pub2[0:6]}
C {devices/lab_wire.sym} 180 -390 0 0 {name=l8 sig_type=std_logic lab=pub3[0:6]}
C {devices/lab_wire.sym} 330 -390 0 0 {name=l12 sig_type=std_logic lab=pub4[0:6]}
C {devices/lab_wire.sym} -20 -270 0 0 {name=l15 sig_type=std_logic lab=pdb1[0:6]}
C {devices/lab_wire.sym} 80 -270 0 0 {name=l16 sig_type=std_logic lab=pdb2[0:6]}
C {devices/lab_wire.sym} 180 -270 0 0 {name=l17 sig_type=std_logic lab=pdb3[0:6]}
C {devices/lab_wire.sym} 330 -270 0 0 {name=l18 sig_type=std_logic lab=pdb4[0:6]}
C {devices/vsource.sym} 300 -540 1 0 {name=Vtest9 value=0}
C {devices/lab_pin.sym} 270 -540 0 0 {name=l43 sig_type=std_logic lab=pub4[0]}
C {devices/lab_pin.sym} 330 -540 0 1 {name=l44 sig_type=std_logic lab=pu_in_test_4}
C {devices/vsource.sym} 300 -480 1 0 {name=Vtest10 value=0}
C {devices/lab_pin.sym} 270 -480 0 0 {name=l45 sig_type=std_logic lab=pdb4[0]}
C {devices/lab_pin.sym} 330 -480 0 1 {name=l46 sig_type=std_logic lab=pd_in_test_4}
C {sky130/sky130_stdcells/clkinv_1.sym} 20 -390 0 0 {name=xpui2[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 120 -390 0 0 {name=xpui3[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 220 -390 0 0 {name=xpui4[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 20 -270 0 0 {name=xpui5[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 120 -270 0 0 {name=xpui6[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 220 -270 0 0 {name=xpui7[0:6] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {schem/post_layout_SSTL.sym} 360 -210 0 0 {name=X1}
C {devices/gnd.sym} 460 -210 0 0 {name=l19 lab=GND}
C {devices/vdd.sym} 460 -450 0 0 {name=l20 lab=VDD}
