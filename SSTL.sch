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
N 640 -1000 640 -880 { lab=DQ}
N 1200 -1000 1200 -880 { lab=DQ}
N 1760 -1000 1760 -880 { lab=DQ}
N 2320 -1000 2320 -880 { lab=DQ}
N 2880 -1000 2880 -880 { lab=DQ}
N 3440 -1000 3440 -880 { lab=DQ}
N 4000 -1000 4000 -880 { lab=DQ}
N 1200 -940 1760 -940 { lab=DQ}
N 1760 -940 2320 -940 { lab=DQ}
N 2320 -940 2880 -940 { lab=DQ}
N 2880 -940 3440 -940 { lab=DQ}
N 3440 -940 4000 -940 { lab=DQ}
N 4000 -940 4120 -940 { lab=DQ}
N 640 -940 1200 -940 { lab=DQ}
N 140 -1000 160 -1000 { lab=n_pu_ctrl[6]}
N 120 -1220 680 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 120 -1180 680 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 140 -1210 140 -1000 { lab=n_pu_ctrl[6]}
N 160 -1170 160 -1120 { lab=n_pu_cal_ctrl[27:24]
bus=true}
N 120 -700 680 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 120 -660 680 -660 { lab=pd_ctrl[6:0]
bus=true}
N 140 -880 140 -670 { lab=pd_ctrl[6]}
N 140 -880 160 -880 { lab=pd_ctrl[6]}
N 160 -760 160 -710 { lab=pd_cal_ctrl[27:24]
bus=true}
N 700 -1000 720 -1000 { lab=n_pu_ctrl[5]}
N 680 -1220 1240 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 680 -1180 1240 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 700 -1210 700 -1000 { lab=n_pu_ctrl[5]}
N 720 -1170 720 -1120 { lab=n_pu_cal_ctrl[23:20]
bus=true}
N 680 -700 1240 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 680 -660 1240 -660 { lab=pd_ctrl[6:0]
bus=true}
N 700 -880 700 -670 { lab=pd_ctrl[5]}
N 700 -880 720 -880 { lab=pd_ctrl[5]}
N 720 -760 720 -710 { lab=pd_cal_ctrl[23:20]
bus=true}
N 1260 -1000 1280 -1000 { lab=n_pu_ctrl[4]}
N 1240 -1220 1800 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 1240 -1180 1800 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 1260 -1210 1260 -1000 { lab=n_pu_ctrl[4]}
N 1280 -1170 1280 -1120 { lab=n_pu_cal_ctrl[19:16]
bus=true}
N 1240 -700 1800 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 1240 -660 1800 -660 { lab=pd_ctrl[6:0]
bus=true}
N 1260 -880 1260 -670 { lab=pd_ctrl[4]}
N 1260 -880 1280 -880 { lab=pd_ctrl[4]}
N 1280 -760 1280 -710 { lab=pd_cal_ctrl[19:16]
bus=true}
N 1820 -1000 1840 -1000 { lab=n_pu_ctrl[3]}
N 1800 -1220 2360 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 1800 -1180 2360 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 1820 -1210 1820 -1000 { lab=n_pu_ctrl[3]}
N 1840 -1170 1840 -1120 { lab=n_pu_cal_ctrl[15:12]
bus=true}
N 1800 -700 2360 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 1800 -660 2360 -660 { lab=pd_ctrl[6:0]
bus=true}
N 1820 -880 1820 -670 { lab=pd_ctrl[3]}
N 1820 -880 1840 -880 { lab=pd_ctrl[3]}
N 1840 -760 1840 -710 { lab=pd_cal_ctrl[15:12]
bus=true}
N 2380 -1000 2400 -1000 { lab=n_pu_ctrl[2]}
N 2360 -1220 2920 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 2360 -1180 2920 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 2380 -1210 2380 -1000 { lab=n_pu_ctrl[2]}
N 2400 -1170 2400 -1120 { lab=n_pu_cal_ctrl[11:8]
bus=true}
N 2360 -700 2920 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 2360 -660 2920 -660 { lab=pd_ctrl[6:0]
bus=true}
N 2380 -880 2380 -670 { lab=pd_ctrl[2]}
N 2380 -880 2400 -880 { lab=pd_ctrl[2]}
N 2400 -760 2400 -710 { lab=pd_cal_ctrl[11:8]
bus=true}
N 2940 -1000 2960 -1000 { lab=n_pu_ctrl[1]}
N 2920 -1220 3480 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 2920 -1180 3480 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 2940 -1210 2940 -1000 { lab=n_pu_ctrl[1]}
N 2960 -1170 2960 -1120 { lab=n_pu_cal_ctrl[7:4]
bus=true}
N 2920 -700 3480 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 2920 -660 3480 -660 { lab=pd_ctrl[6:0]
bus=true}
N 2940 -880 2940 -670 { lab=pd_ctrl[1]}
N 2940 -880 2960 -880 { lab=pd_ctrl[1]}
N 2960 -760 2960 -710 { lab=pd_cal_ctrl[7:4]
bus=true}
N 3500 -1000 3520 -1000 { lab=n_pu_ctrl[0]}
N 3480 -1220 4040 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 3480 -1180 4040 -1180 { lab=n_pu_cal_ctrl[27:0]
bus=true}
N 3500 -1210 3500 -1000 { lab=n_pu_ctrl[0]}
N 3520 -1170 3520 -1120 { lab=n_pu_cal_ctrl[3:0]
bus=true}
N 3480 -700 4040 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 3480 -660 4040 -660 { lab=pd_ctrl[6:0]
bus=true}
N 3500 -880 3500 -670 { lab=pd_ctrl[0]}
N 3500 -880 3520 -880 { lab=pd_ctrl[0]}
N 3520 -760 3520 -710 { lab=pd_cal_ctrl[3:0]
bus=true}
N 240 -580 280 -580 { lab=pdc4[6:0]
bus=true}
N 240 -1300 280 -1300 { lab=puc4[6:0]
bus=true}
N 120 -1300 160 -1300 { lab=puc1[6:0]
bus=true}
N 20 -1180 40 -1180 { lab=pu_cal_ctrl[27:0]
bus=true}
N 20 -700 120 -700 { lab=pd_cal_ctrl[27:0]
bus=true}
N 20 -1300 40 -1300 { lab=pu_ctrl[6:0]
bus=true}
N 20 -580 160 -580 { lab=pd_ctrl[6:0]
bus=true}
N 360 -1300 420 -1300 { lab=n_pu_ctrl[6:0]
bus=true}
N 420 -1300 420 -1220 { lab=n_pu_ctrl[6:0]
bus=true}
N 360 -580 420 -580 { lab=pd_ctrl[6:0]
bus=true}
N 420 -660 420 -580 { lab=pd_ctrl[6:0]
bus=true}
N 40 -420 80 -420 { lab=VPWR}
N 40 -380 80 -380 { lab=VGND}
N 40 -490 40 -480 { lab=VDD}
N 40 -320 40 -310 { lab=GND}
N 180 -420 220 -420 { lab=VPB}
N 180 -380 220 -380 { lab=VNB}
N 180 -490 180 -480 { lab=VDD}
N 180 -320 180 -310 { lab=GND}
C {p-leg.sym} 140 -940 0 0 {name=X1}
C {n-leg.sym} 140 -700 0 0 {name=X2}
C {p-leg.sym} 700 -940 0 0 {name=X3}
C {n-leg.sym} 700 -700 0 0 {name=X4}
C {p-leg.sym} 1260 -940 0 0 {name=X5}
C {n-leg.sym} 1260 -700 0 0 {name=X6}
C {p-leg.sym} 1820 -940 0 0 {name=X7}
C {n-leg.sym} 1820 -700 0 0 {name=X8}
C {p-leg.sym} 2380 -940 0 0 {name=X9}
C {n-leg.sym} 2380 -700 0 0 {name=X10}
C {p-leg.sym} 2940 -940 0 0 {name=X11}
C {n-leg.sym} 2940 -700 0 0 {name=X12}
C {p-leg.sym} 3500 -940 0 0 {name=X13}
C {n-leg.sym} 3500 -700 0 0 {name=X14}
C {devices/iopin.sym} 4120 -940 0 0 {name=p1 lab=DQ}
C {devices/title.sym} 150 -30 0 0 {name=l1 author="Derek H-M"}
C {devices/bus_connect.sym} 130 -1220 1 0 {name=l2 lab=n_pu_ctrl[6]}
C {devices/bus_connect.sym} 150 -1180 1 0 {name=l3 lab=n_pu_cal_ctrl[27:24]}
C {devices/bus_connect.sym} 170 -700 3 0 {name=l4 lab=pd_cal_ctrl[27:24]}
C {devices/bus_connect.sym} 150 -660 3 0 {name=l5 lab=pd_ctrl[6]}
C {devices/bus_connect.sym} 690 -1220 1 0 {name=l6 lab=n_pu_ctrl[5]}
C {devices/bus_connect.sym} 710 -1180 1 0 {name=l7 lab=n_pu_cal_ctrl[23:20]}
C {devices/bus_connect.sym} 730 -700 3 0 {name=l8 lab=pd_cal_ctrl[23:20]}
C {devices/bus_connect.sym} 710 -660 3 0 {name=l9 lab=pd_ctrl[5]}
C {devices/bus_connect.sym} 1250 -1220 1 0 {name=l10 lab=n_pu_ctrl[4]
}
C {devices/bus_connect.sym} 1270 -1180 1 0 {name=l11 lab=n_pu_cal_ctrl[19:16]}
C {devices/bus_connect.sym} 1290 -700 3 0 {name=l12 lab=pd_cal_ctrl[19:16]}
C {devices/bus_connect.sym} 1270 -660 3 0 {name=l13 lab=pd_ctrl[4]}
C {devices/bus_connect.sym} 1810 -1220 1 0 {name=l14 lab=n_pu_ctrl[3]}
C {devices/bus_connect.sym} 1830 -1180 1 0 {name=l15 lab=n_pu_cal_ctrl[15:12]}
C {devices/bus_connect.sym} 1850 -700 3 0 {name=l16 lab=pd_cal_ctrl[15:12]}
C {devices/bus_connect.sym} 1830 -660 3 0 {name=l17 lab=pd_ctrl[3]}
C {devices/bus_connect.sym} 2370 -1220 1 0 {name=l18 lab=n_pu_ctrl[2]}
C {devices/bus_connect.sym} 2390 -1180 1 0 {name=l19 lab=n_pu_cal_ctrl[11:8]}
C {devices/bus_connect.sym} 2410 -700 3 0 {name=l20 lab=pd_cal_ctrl[11:8]}
C {devices/bus_connect.sym} 2390 -660 3 0 {name=l21 lab=pd_ctrl[2]}
C {devices/bus_connect.sym} 2930 -1220 1 0 {name=l22 lab=n_pu_ctrl[1]}
C {devices/bus_connect.sym} 2950 -1180 1 0 {name=l23 lab=n_pu_cal_ctrl[7:4]}
C {devices/bus_connect.sym} 2970 -700 3 0 {name=l24 lab=pd_cal_ctrl[7:4]}
C {devices/bus_connect.sym} 2950 -660 3 0 {name=l25 lab=pd_ctrl[1]}
C {devices/bus_connect.sym} 3490 -1220 1 0 {name=l26 lab=n_pu_ctrl[0]}
C {devices/bus_connect.sym} 3510 -1180 1 0 {name=l27 lab=n_pu_cal_ctrl[3:0]}
C {devices/bus_connect.sym} 3530 -700 3 0 {name=l28 lab=pd_cal_ctrl[3:0]}
C {devices/bus_connect.sym} 3510 -660 3 0 {name=l29 lab=pd_ctrl[0]}
C {sky130/sky130_stdcells/inv_4.sym} 200 -580 0 0 {name=xpd_buff_4[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/inv_6.sym} 320 -580 0 0 {name=xpd_buff_6[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/inv_4.sym} 200 -1300 0 0 {name=xpu_buff_4[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/inv_6.sym} 320 -1300 0 0 {name=xpu_buff_6[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130/sky130_stdcells/inv_1.sym} 80 -1300 0 0 {name=xpu_buff_1[6:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {devices/ipin.sym} 20 -1180 0 0 {name=p2 lab=pu_cal_ctrl[27:0]}
C {sky130/sky130_stdcells/inv_1.sym} 80 -1180 0 0 {name=xpu_cal_inv[27:0] VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} 380 -1220 0 0 {name=l30 sig_type=std_logic lab=n_pu_ctrl[6:0]}
C {devices/lab_wire.sym} 380 -1180 0 0 {name=l31 sig_type=std_logic lab=n_pu_cal_ctrl[27:0]}
C {devices/ipin.sym} 20 -700 0 0 {name=p3 lab=pd_cal_ctrl[27:0]}
C {devices/lab_wire.sym} 360 -700 0 0 {name=l32 sig_type=std_logic lab=pd_cal_ctrl[27:0]}
C {devices/ipin.sym} 20 -1300 0 0 {name=p4 lab=pu_ctrl[6:0]}
C {devices/ipin.sym} 20 -580 0 0 {name=p5 lab=pd_ctrl[6:0]}
C {devices/lab_wire.sym} 360 -660 0 0 {name=l33 sig_type=std_logic lab=pd_ctrl[6:0]}
C {devices/lab_wire.sym} 160 -1300 0 0 {name=l35 sig_type=std_logic lab=puc1[6:0]}
C {devices/lab_wire.sym} 280 -1300 0 0 {name=l34 sig_type=std_logic lab=puc4[6:0]}
C {devices/lab_wire.sym} 280 -580 0 0 {name=l36 sig_type=std_logic lab=pdc4[6:0]}
C {devices/vdd.sym} 40 -490 0 0 {name=l37 lab=VDD}
C {devices/gnd.sym} 40 -310 0 0 {name=l38 lab=GND}
C {devices/lab_pin.sym} 80 -420 2 0 {name=l39 sig_type=std_logic lab=VPWR}
C {devices/lab_pin.sym} 220 -420 2 0 {name=l41 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} 80 -380 2 0 {name=l42 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 220 -380 2 0 {name=l44 sig_type=std_logic lab=VNB}
C {devices/vsource.sym} 40 -450 0 0 {name=V1 value=0}
C {devices/vsource.sym} 40 -350 0 0 {name=V2 value=0}
C {devices/vdd.sym} 180 -490 0 0 {name=l40 lab=VDD}
C {devices/gnd.sym} 180 -310 0 0 {name=l43 lab=GND}
C {devices/vsource.sym} 180 -450 0 0 {name=V3 value=0}
C {devices/vsource.sym} 180 -350 0 0 {name=V4 value=0}
C {devices/lab_pin.sym} 500 -1170 0 0 {name=l45 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 1060 -1170 0 0 {name=l46 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 1620 -1170 0 0 {name=l47 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 2180 -1170 0 0 {name=l48 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 2740 -1170 0 0 {name=l49 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 3300 -1170 0 0 {name=l50 sig_type=std_logic lab=v1v5}
C {devices/lab_pin.sym} 3860 -1170 0 0 {name=l51 sig_type=std_logic lab=v1v5}
