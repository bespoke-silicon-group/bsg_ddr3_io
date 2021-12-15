from leg_sim_util import *
from math import floor
from numpy import arange
from random import randrange
import json

template = 'sstl_slew_tb.spice'

# TODO Move to util file?
def cal2ctrl(n):
  result = [0, 0, 0, 0]
  for b in range(len(bin(n))-2): result[b] = int(bin(n)[::-1][:-2][b] == '1')
  result.reverse()
  return result

def get_valid_cal(json_fname, temp, vdd, proc):  
  with open(json_fname, 'r') as f: j = json.loads(f.read())
  arr = [val for i,val in enumerate(j) if val['temp']==temp and val['vdd']==vdd and val['process']==proc]
  assert (len(arr)>0), 'No calibration found for this corner!'
  assert (len(arr)<2), 'Multiple calibrations found for this corner!'
  return arr[0]['valid_cal_enum']

def sim_slew(name, num_leg_en, pu_cal, pd_cal, temp, vdd, proc):
  replace_dict = {}
  replace_dict['plotName'] = name
  replace_dict['vdd']      = vdd
  replace_dict['temp']     = temp
  replace_dict['process']  = proc
  # Set V_ol_ac and V_oh_ac specific to slew tests
  replace_dict['vohac'] = 0.6*vdd
  replace_dict['volac'] = 0.4*vdd

  for i in range(7): # 7 total pullup and pulldown legs
    s = '0'
    if i < num_leg_en: s = str(vdd)
    replace_dict['puctrl{}'.format(i)] = s
    replace_dict['pdctrl{}'.format(i)] = s
    for j in range(4): # 4 calibration fets for each leg
      s = '0'
      if cal2ctrl(pu_cal)[j]: s = str(vdd)
      replace_dict['pucal{l}{n}'.format(l=i, n=j)] = s
      s = '0'
      if cal2ctrl(pd_cal)[j]: s = str(vdd)
      replace_dict['pdcal{l}{n}'.format(l=i, n=j)] = s

  gen_spice_script(template, name, replace_dict)

  # Launch NGspice
  try:
    print('NGSPICE launched script "{outName}.spice"... '.format(outName=name))
    os.system('''
      make launch-ngspice \
      args=out/scripts/{outName}.spice\\ -b\\ -o\\ out/logs/{outName}.log \
      >/dev/null 2>&1'''.format(outName=name))
    print('NGSPICE complete.')
    sleep(0.200) # 200 ms to leave time for interrupt
  except KeyboardInterrupt:
    print('\nSimulation halted')
    quit()

  # Read output
  data = {}
  with open('out/data/{name}.txt'.format(name=name), 'r') as d_file:
    l = d_file.readline()
    data['slew_up']   = round(0.2*vdd / float(l.split()[1]) / 1e9, 2) # V/ns
    data['slew_down'] = round(0.2*vdd / float(l.split()[3]) / 1e9, 2) # V/ns
  return data




num_leg_en = 7

pu_cal_file = 'sstl_pullup_34_ohm_cal.json'
pd_cal_file = 'sstl_pulldown_34_ohm_cal.json'
if num_leg_en == 6:
  pu_cal_file = 'sstl_pullup_40_ohm_cal.json'
  pd_cal_file = 'sstl_pulldown_40_ohm_cal.json'
data_arr = []
temps = [125, -40] # Temperature edge cases
vdds = [1.475, 1.575] # Edge cases of voltage (1.5V +/-5%)
procs = ['tt', 'tt_mm', 'ff', 'ff_mm', 'fs', 'fs_mm', 'sf', 'sf_mm', 'ss', 'ss_mm']
# procs = ['sf', 'tt', 'ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf_mm', 'ss', 'ss_mm', 'tt_mm']
for temp in temps:
  for vdd in vdds:
    for proc in procs:
      name = 'sstl_{n}_slew_sim_{t}_{v}_{p}'.format(
        n=num_leg_en, t=temp, v=vdd, p=proc)
      pu_cal = get_valid_cal(pu_cal_file, temp, vdd, proc)
      pd_cal = get_valid_cal(pd_cal_file, temp, vdd, proc)
      result = sim_slew(name, num_leg_en, pu_cal, pd_cal, temp, vdd, proc);      
      print('Rising  slew = {} V/ns'.format(result['slew_up']))
      print('Falling slew = {} V/ns'.format(result['slew_down']))
      # Save output
      data_d = {}
      data_d['temp']    = temp
      data_d['vdd']     = vdd
      data_d['process'] = proc
      data_d['slew_up']   = result['slew_up']
      data_d['slew_down'] = result['slew_down']
      data_arr.append(data_d)

json_out_name = 'sstl_{r}_ohm_slew.json'.format(r=round(240/float(num_leg_en)))
with open(json_out_name, 'w') as f: f.write(json.dumps(data_arr, indent=2))

