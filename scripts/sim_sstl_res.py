from sys import argv
from leg_sim_util import *
import argparse
from math import floor
from numpy import arange
from random import randrange
import json

def simCal(template, name, ctrl_dict, temp, vdd, proc):
  num_pd_en = 0
  for i in range(7): 
    if ctrl_dict['pd']['en'][i] == 1: num_pd_en += 1
  num_pu_en = 0
  for i in range(7): 
    if ctrl_dict['pu']['en'][i] == 1: num_pu_en += 1
  if (num_pd_en == 0) == (num_pu_en == 0):
    print('Only ONE of pullup or pulldown legs must be enabled for this sim!')
    exit()
  is_pulldown = num_pd_en != 0
  expected_res = 240/max(num_pd_en, num_pu_en)
  direction = 'pu'
  if is_pulldown: direction = 'pd'

  search_max = 15
  search_min = 0
  while True: # until break!
    if search_min > search_max:
      print('Calibration not possible!')
      break
    
    cal = floor((search_max+search_min)/2)
    ctrl_sig = cal2ctrl(cal)
    ctrl_dict['pu']['cal'] = ctrl_sig
    ctrl_dict['pd']['cal'] = ctrl_sig
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
  return None # if calibration not possible

def main():  
  parser = argparse.ArgumentParser(
    description='Generate and run a SSTL leg simulation.')
  parser.add_argument('--dir', required=True, choices=['pu', 'pd'],
    help='Must be one of "pu" (pullup) or "pd" (pulldown)')
  parser.add_argument('--voltage', required=True, 
    help='VDD voltage for the sim')
  parser.add_argument('--temp', required=True, 
    help='temperature (*C) for the sim')
  parser.add_argument('--process', required=True, 
    help='process string for the sim')
  parser.add_argument('--num-leg-en', default=7, type=int,
    help='Number of enabled legs. (Sets the target resistance to "240/num_leg_en ohms")')
  parser.add_argument('--post-layout', action='store_true',
    help='Run post-layout simulation instead.')
  args = parser.parse_args()

  # Set names based on simulation type
  tmp = 'spice/sstl_res_tb.spice' # Original spice script template
  outNameTmp = 'sstl_{d}_{n}_cal_sim_{t}_{v}_{p}'
  if args.post_layout:
    tmp = 'spice/post_layout_sstl_res_tb.spice' # Post-layout spice script template
    outNameTmp = 'post_layout_sstl_{d}_{n}_cal_sim_{t}_{v}_{p}'

  outName = outNameTmp.format(
    d=args.dir, n=args.num_leg_en, t=args.temp, v=args.voltage, p=args.process)

  # Set enables
  ctrl_dict = DEFAULT_CTRL_DICT.copy()
  for i in range(args.num_leg_en): ctrl_dict[args.dir]['en'][i] = 1
  cal_result = simCal(tmp, outName, ctrl_dict, args.temp, args.voltage, args.process)

  # Save output
  data_out = {}
  data_out['vdd']         = args.voltage
  data_out['temperature'] = args.temp
  data_out['process']     = args.process
  data_out['calibration_success'] = (cal_result != None)
  if cal_result != None:
    data_out['valid_cal_enum'] = cal_result['cal']
    data_out['resistances'] = cal_result['res']
  fout_name = 'out/{name}/out.json'.format(name=outName)
  with open(fout_name, 'w') as f: f.write(json.dumps(data_out, indent=2))



if __name__ == '__main__':
  main()