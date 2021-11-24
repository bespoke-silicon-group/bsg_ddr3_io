from sys import argv
from leg_sim_util import *
from math import floor
from numpy import arange
from random import randrange
import json

def cal2ctrl(n):
  result = [0, 0, 0, 0]
  for b in range(len(bin(n))-2): result[b] = int(bin(n)[::-1][:-2][b] == '1')
  result.reverse()
  return result

def simCal(template, ctrl_dict, temp, vdd, proc):
  num_pd_en = 0
  for i in range(7): 
    if ctrl_dict['pd'][i]['en'] == 1: num_pd_en += 1
  num_pu_en = 0
  for i in range(7): 
    if ctrl_dict['pu'][i]['en'] == 1: num_pu_en += 1
  if (num_pd_en == 0) == (num_pu_en == 0):
    print('Only ONE of pullup or pulldown legs must be enabled for this sim!')
    exit()
  is_pulldown = num_pd_en != 0
  expected_res = 240/max(num_pd_en, num_pu_en)
  direction = 'pu'
  if is_pulldown: direction = 'pd'

  name = 'sstl_{d}_{n}_cal_sim_{t}_{v}_{p}'.format(
    d=direction, n=max(num_pd_en, num_pu_en), t=temp, v=vdd, p=proc)


  search_max = 15
  search_min = 0
  while True: # until break!
    if search_min > search_max:
      print('Calibration not possible!')
      break
    
    cal = floor((search_max+search_min)/2)
    ctrl_sig = cal2ctrl(cal)
    for i in range(7): ctrl_dict['pu'][i]['cal'] = ctrl_sig
    for i in range(7): ctrl_dict['pd'][i]['cal'] = ctrl_sig
    print('Trying cal = {c}: {a}'.format(c=cal, a=ctrl_sig))
    
    result = sstl_res_sim(template, outName=name, is_pulldown=is_pulldown, 
      temp=temp, vddVoltage=vdd, process=proc, ctrl_dict=ctrl_dict)

    print('Resistances: {l}, {m}, {h}'.format(
      l=round(result['r_lvt']), m=round(result['r_mvt']), h=round(result['r_hvt'])))
    res = checkResReq(result, expected_res=expected_res, negate=is_pulldown)
    
    if not(any(res)): # If all in range, we found calibration!
      print('Calibration found: {c} target resistance = {t} ohms.'.format(
        c=ctrl_sig, t=round(expected_res, 2)))      
      return {'cal':cal, 'res':result}
    elif 1 in res and -1 in res: # If some out of range on either end, calibration is impossible!
      print('Calibration impossible with resistances: {r} target resistance = {t} ohms.'.format(
        r=result, t=round(expected_res, 2)))
      break
    elif 1 in res: # Resistance was too high
      search_min = cal+1
    elif -1 in res: # Resistance was too low
      search_max = cal-1
    else: assert(False)
  assert(False, 'CALIBRATION FAILED!') 









tmp = 'sstl_res_tb.spice' # Spice script template
# Default control signal set
ctrl_dict = {'pu':[ {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}],
             'pd':[ {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}, {'en':0, 'cal':[0,1,1,1]}]}

# Decide template script and output name based on user choice of 'pulldown' or 'pullup'
if len(argv)>2 and argv[1]=='pulldown':
  for i in range(int(argv[2])): ctrl_dict['pd'][i]['en'] = 1
elif len(argv)>2 and argv[1]=='pullup':
  for i in range(int(argv[2])): ctrl_dict['pu'][i]['en'] = 1
else:
  print('Missing argument. "pulldown" or "pullup"')
  print('Usage: {fname} pulldown/pullup <NUM_LEG_ENABLED_OPTION>'.format(fname=argv[0]))
  quit()

with open('sstl_cal_log.txt', 'w') as outf: pass # Clear previous log
cal_arr = []
temps = [-40, 125] # Temperature edge cases
vdds = [1.575, 1.475] # Edge cases of voltage (1.5V +/-5%)
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
for temp in temps:
  for vdd in vdds:
    for proc in procs:
      output = simCal(tmp, ctrl_dict, temp, vdd, proc)
      # Save output
      out_dict = {}
      out_dict['temp'] = temp
      out_dict['vdd'] = vdd
      out_dict['process'] = proc
      out_dict['valid_cal_enum'] = output['cal']
      out_dict['calibrated_resistances'] = [round(output['res']['r_lvt'],1),
                                            round(output['res']['r_mvt'],1),
                                            round(output['res']['r_hvt'],1) ]
      cal_arr.append(out_dict)

      with open('sstl_cal_log.txt', 'a') as outf:
        outf.write('{t}, {v}, {p}\t\t{cal}\t{res}\n'.format(
          t=temp, v=vdd, p=proc, cal=output['cal'], res=output['res']))
      print()
      print()

json_out_name = 'sstl_{t}_{r}_ohm_cal.json'.format(t=argv[1], r=round(240/float(argv[2])))
with open(json_out_name, 'w') as f: f.write(json.dumps(cal_arr, indent=2))
print('ALL CORNER CALIBRATION CASES PASSED!')