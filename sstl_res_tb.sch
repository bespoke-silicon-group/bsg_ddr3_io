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
N 860 -330 880 -330 { lab=DQ}
N 350 -390 380 -390 { lab=pu_ctrl[6:0]}
N 350 -360 380 -360 { lab=pu_cal[27:0]}
N 350 -300 380 -300 { lab=pd_cal[27:0]}
N 350 -270 380 -270 { lab=pd_ctrl[6:0]}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/code.sym} 790 -200 0 0 {name=STIMULI 
only_toplevel=true
place=end
value="
* power voltage
vvddq VDDQ 0 0
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


.control
save all
set temp=SED_temp_SED

* RUN SIMULATION
dc vvddq 0.3 1.2 0.05
* OUTPUT
print i(vtest)
wrdata out/data/SED_plotName_SED.txt i(vtest)
set hcopydevtype = svg
hardcopy ./out/plots/SED_plotName_SED.svg I(vtest) vs vddq title 'Resistance vs pin voltage'

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
C {devices/ammeter.sym} 910 -330 3 0 {name=vtest}
C {SSTL.sym} 360 -210 0 0 {name=X1}
C {devices/lab_wire.sym} 860 -330 2 0 {name=l9 sig_type=std_logic lab=DQ}
C {devices/lab_wire.sym} 940 -330 2 0 {name=l11 sig_type=std_logic lab=VDDQ}
C {devices/lab_pin.sym} 350 -390 0 0 {name=l3 sig_type=std_logic lab=pu_ctrl[6:0]}
C {devices/lab_pin.sym} 350 -270 0 0 {name=l10 sig_type=std_logic lab=pd_ctrl[6:0]}
C {devices/lab_pin.sym} 350 -360 0 0 {name=l13 sig_type=std_logic lab=pu_cal[27:0]}
C {devices/lab_pin.sym} 350 -300 0 0 {name=l14 sig_type=std_logic lab=pd_cal[27:0]}
