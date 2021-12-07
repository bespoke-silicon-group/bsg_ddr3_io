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
N 350 -360 380 -360 { lab=pu_cal[27:0]}
N 350 -300 380 -300 { lab=pd_cal[27:0]}
N 860 -330 990 -330 { lab=DQ}
N 930 -270 930 -260 { lab=GND}
N 1110 -270 1110 -250 { lab=GND}
N 1110 -270 1150 -270 { lab=GND}
N 1150 -280 1150 -270 { lab=GND}
N 1050 -330 1110 -330 { lab=VDDQ}
N 1150 -330 1150 -320 { lab=VDD}
N -40 -390 -20 -390 { lab=pub1[6:0]}
N 60 -390 80 -390 { lab=pub2[6:0]}
N 160 -390 180 -390 { lab=pub3[6:0]}
N -40 -270 -20 -270 { lab=pdb1[6:0]}
N 60 -270 80 -270 { lab=pdb2[6:0]}
N 160 -270 180 -270 { lab=pdb3[6:0]}
N 260 -390 380 -390 { lab=pub4[6:0]}
N -150 -200 -150 -190 { lab=VDD}
N -70 -200 -70 -190 { lab=VDD}
N -150 -130 -130 -130 { lab=VPWR}
N -150 -110 -130 -110 { lab=VGND}
N -70 -130 -50 -130 { lab=VPB}
N -70 -110 -50 -110 { lab=VNB}
N -150 -50 -150 -40 { lab=GND}
N -70 -50 -70 -40 { lab=GND}
N 260 -270 360 -270 { lab=pdb4[6:0]}
N 360 -270 380 -270 { lab=pdb4[6:0]}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 790 -200 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="
* power voltage
vvdd VDD 0 SED_vdd_SED

** CALIBRATION CONTROL **
* PULLUP
vpu_cal00 pu_cal[0] 0 SED_pucal00_SED
vpu_cal01 pu_cal[1] 0 SED_pucal01_SED
vpu_cal02 pu_cal[2] 0 SED_pucal02_SED
vpu_cal03 pu_cal[3] 0 SED_pucal03_SED
vpu_cal10 pu_cal[4] 0 SED_pucal10_SED
vpu_cal11 pu_cal[5] 0 SED_pucal11_SED
vpu_cal12 pu_cal[6] 0 SED_pucal12_SED
vpu_cal13 pu_cal[7] 0 SED_pucal13_SED
vpu_cal20 pu_cal[8] 0 SED_pucal20_SED
vpu_cal21 pu_cal[9] 0 SED_pucal21_SED
vpu_cal22 pu_cal[10] 0 SED_pucal22_SED
vpu_cal23 pu_cal[11] 0 SED_pucal23_SED
vpu_cal30 pu_cal[12] 0 SED_pucal30_SED
vpu_cal31 pu_cal[13] 0 SED_pucal31_SED
vpu_cal32 pu_cal[14] 0 SED_pucal32_SED
vpu_cal33 pu_cal[15] 0 SED_pucal33_SED
vpu_cal40 pu_cal[16] 0 SED_pucal40_SED
vpu_cal41 pu_cal[17] 0 SED_pucal41_SED
vpu_cal42 pu_cal[18] 0 SED_pucal42_SED
vpu_cal43 pu_cal[19] 0 SED_pucal43_SED
vpu_cal50 pu_cal[20] 0 SED_pucal50_SED
vpu_cal51 pu_cal[21] 0 SED_pucal51_SED
vpu_cal52 pu_cal[22] 0 SED_pucal52_SED
vpu_cal53 pu_cal[23] 0 SED_pucal53_SED
vpu_cal60 pu_cal[24] 0 SED_pucal60_SED
vpu_cal61 pu_cal[25] 0 SED_pucal61_SED
vpu_cal62 pu_cal[26] 0 SED_pucal62_SED
vpu_cal63 pu_cal[27] 0 SED_pucal63_SED
* PULLDOWN
vpd_cal00 pd_cal[0] 0 SED_pdcal00_SED
vpd_cal01 pd_cal[1] 0 SED_pdcal01_SED
vpd_cal02 pd_cal[2] 0 SED_pdcal02_SED
vpd_cal03 pd_cal[3] 0 SED_pdcal03_SED
vpd_cal10 pd_cal[4] 0 SED_pdcal10_SED
vpd_cal11 pd_cal[5] 0 SED_pdcal11_SED
vpd_cal12 pd_cal[6] 0 SED_pdcal12_SED
vpd_cal13 pd_cal[7] 0 SED_pdcal13_SED
vpd_cal20 pd_cal[8] 0 SED_pdcal20_SED
vpd_cal21 pd_cal[9] 0 SED_pdcal21_SED
vpd_cal22 pd_cal[10] 0 SED_pdcal22_SED
vpd_cal23 pd_cal[11] 0 SED_pdcal23_SED
vpd_cal30 pd_cal[12] 0 SED_pdcal30_SED
vpd_cal31 pd_cal[13] 0 SED_pdcal31_SED
vpd_cal32 pd_cal[14] 0 SED_pdcal32_SED
vpd_cal33 pd_cal[15] 0 SED_pdcal33_SED
vpd_cal40 pd_cal[16] 0 SED_pdcal40_SED
vpd_cal41 pd_cal[17] 0 SED_pdcal41_SED
vpd_cal42 pd_cal[18] 0 SED_pdcal42_SED
vpd_cal43 pd_cal[19] 0 SED_pdcal43_SED
vpd_cal50 pd_cal[20] 0 SED_pdcal50_SED
vpd_cal51 pd_cal[21] 0 SED_pdcal51_SED
vpd_cal52 pd_cal[22] 0 SED_pdcal52_SED
vpd_cal53 pd_cal[23] 0 SED_pdcal53_SED
vpd_cal60 pd_cal[24] 0 SED_pdcal60_SED
vpd_cal61 pd_cal[25] 0 SED_pdcal61_SED
vpd_cal62 pd_cal[26] 0 SED_pdcal62_SED
vpd_cal63 pd_cal[27] 0 SED_pdcal63_SED

** LEG ENABLE/DISABLE CONTROL
* PULLUP
vpu_ctrl0 pu_ctrl[0] 0 0 PULSE 0 SED_puctrl0_SED 10n 10p 10p 10n 20n 0
vpu_ctrl1 pu_ctrl[1] 0 0 PULSE 0 SED_puctrl1_SED 10n 10p 10p 10n 20n 0
vpu_ctrl2 pu_ctrl[2] 0 0 PULSE 0 SED_puctrl2_SED 10n 10p 10p 10n 20n 0
vpu_ctrl3 pu_ctrl[3] 0 0 PULSE 0 SED_puctrl3_SED 10n 10p 10p 10n 20n 0
vpu_ctrl4 pu_ctrl[4] 0 0 PULSE 0 SED_puctrl4_SED 10n 10p 10p 10n 20n 0
vpu_ctrl5 pu_ctrl[5] 0 0 PULSE 0 SED_puctrl5_SED 10n 10p 10p 10n 20n 0
vpu_ctrl6 pu_ctrl[6] 0 0 PULSE 0 SED_puctrl6_SED 10n 10p 10p 10n 20n 0
* PULLDOWN
vpd_ctrl0 VDD pd_ctrl[0] 0 PULSE 0 SED_pdctrl0_SED 10n 10p 10p 10n 20n 0
vpd_ctrl1 VDD pd_ctrl[1] 0 PULSE 0 SED_pdctrl1_SED 10n 10p 10p 10n 20n 0
vpd_ctrl2 VDD pd_ctrl[2] 0 PULSE 0 SED_pdctrl2_SED 10n 10p 10p 10n 20n 0
vpd_ctrl3 VDD pd_ctrl[3] 0 PULSE 0 SED_pdctrl3_SED 10n 10p 10p 10n 20n 0
vpd_ctrl4 VDD pd_ctrl[4] 0 PULSE 0 SED_pdctrl4_SED 10n 10p 10p 10n 20n 0
vpd_ctrl5 VDD pd_ctrl[5] 0 PULSE 0 SED_pdctrl5_SED 10n 10p 10p 10n 20n 0
vpd_ctrl6 VDD pd_ctrl[6] 0 PULSE 0 SED_pdctrl6_SED 10n 10p 10p 10n 20n 0

.control
save all
set temp=SED_temp_SED

* RUN SIMULATION
tran 1p 25n
* Measure rise time
meas tran tdiff_rise trig dq val=SED_volac_SED rise=1 targ dq val=SED_vohac_SED rise=1
* Measure fall time
meas tran tdiff_fall trig dq val=SED_vohac_SED fall=1 targ dq val=SED_volac_SED fall=1

* OUTPUT
wrdata ./out/data/SED_plotName_SED.txt tdiff_rise tdiff_fall
set hcopydevtype = svg
hardcopy ./out/plots/SED_plotName_SED.svg dq pu_in_test_4 pd_in_test_4 title 'DQ vs time'

.endc
"}
C {devices/code.sym} 930 -200 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="** Local library links to pdk
.lib ./libs/SED_process_SED_lib.spice SED_process_SED
.include \\\\$::SKYWATER_STDCELLS\\\\/sky130_fd_sc_hd.spice
"
spice_ignore=false}
C {SSTL.sym} 360 -210 0 0 {name=X1}
C {devices/lab_wire.sym} 860 -330 2 0 {name=l9 sig_type=std_logic lab=DQ}
C {devices/lab_wire.sym} 1050 -330 0 1 {name=l11 sig_type=std_logic lab=VDDQ}
C {devices/lab_pin.sym} -120 -390 0 0 {name=l3 sig_type=std_logic lab=pu_ctrl[6:0]}
C {devices/lab_pin.sym} -120 -270 0 0 {name=l10 sig_type=std_logic lab=pd_ctrl[6:0]}
C {devices/lab_pin.sym} 350 -360 0 0 {name=l13 sig_type=std_logic lab=pu_cal[27:0]}
C {devices/lab_pin.sym} 350 -300 0 0 {name=l14 sig_type=std_logic lab=pd_cal[27:0]}
C {devices/res.sym} 1020 -330 1 0 {name=Rtb
value=25
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 930 -300 0 0 {name=Cpad
m=1
value=491f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 930 -260 0 0 {name=l2 lab=GND}
C {devices/vcvs.sym} 1110 -300 0 1 {name=Ehalf_vdd 
value=0.5}
C {devices/gnd.sym} 1110 -250 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} 1150 -330 0 0 {name=l5 lab=VDD}
C {sky130/sky130_stdcells/clkinv_1.sym} -80 -390 0 0 {name=xpui1[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 20 -390 0 0 {name=xpui2[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 120 -390 0 0 {name=xpui3[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 220 -390 0 0 {name=xpui4[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} -80 -270 0 0 {name=xpdi1[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 20 -270 0 0 {name=xpdi2[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 120 -270 0 0 {name=xpdi3[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/clkinv_1.sym} 220 -270 0 0 {name=xpdi4[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} -20 -390 0 0 {name=l6 sig_type=std_logic lab=pub1[6:0]}
C {devices/lab_wire.sym} 80 -390 0 0 {name=l7 sig_type=std_logic lab=pub2[6:0]}
C {devices/lab_wire.sym} 180 -390 0 0 {name=l8 sig_type=std_logic lab=pub3[6:0]}
C {devices/lab_wire.sym} 330 -390 0 0 {name=l12 sig_type=std_logic lab=pub4[6:0]}
C {devices/lab_wire.sym} -20 -270 0 0 {name=l15 sig_type=std_logic lab=pdb1[6:0]}
C {devices/lab_wire.sym} 80 -270 0 0 {name=l16 sig_type=std_logic lab=pdb2[6:0]}
C {devices/lab_wire.sym} 180 -270 0 0 {name=l17 sig_type=std_logic lab=pdb3[6:0]}
C {devices/lab_wire.sym} 330 -270 0 0 {name=l18 sig_type=std_logic lab=pdb4[6:0]}
C {devices/vsource.sym} -150 -160 0 0 {name=V1 value=0}
C {devices/vdd.sym} -150 -200 0 0 {name=l19 lab=VDD}
C {devices/vdd.sym} -70 -200 0 0 {name=l20 lab=VDD}
C {devices/gnd.sym} -150 -40 0 0 {name=l21 lab=GND}
C {devices/gnd.sym} -70 -40 0 0 {name=l22 lab=GND}
C {devices/lab_pin.sym} -130 -130 0 1 {name=l23 sig_type=std_logic lab=VPWR}
C {devices/lab_pin.sym} -130 -110 0 1 {name=l24 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} -50 -130 0 1 {name=l25 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} -50 -110 0 1 {name=l26 sig_type=std_logic lab=VNB}
C {devices/vsource.sym} -150 -80 0 0 {name=V2 value=0}
C {devices/vsource.sym} -70 -160 0 0 {name=V3 value=0}
C {devices/vsource.sym} -70 -80 0 0 {name=V4 value=0}
C {devices/vsource.sym} 330 -540 1 0 {name=Vtest9 value=0}
C {devices/lab_pin.sym} 300 -540 0 0 {name=l43 sig_type=std_logic lab=pub4[0]}
C {devices/lab_pin.sym} 360 -540 0 1 {name=l44 sig_type=std_logic lab=pu_in_test_4}
C {devices/vsource.sym} 330 -480 1 0 {name=Vtest10 value=0}
C {devices/lab_pin.sym} 300 -480 0 0 {name=l45 sig_type=std_logic lab=pdb4[0]}
C {devices/lab_pin.sym} 360 -480 0 1 {name=l46 sig_type=std_logic lab=pd_in_test_4}
