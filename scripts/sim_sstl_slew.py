from sys import argv
from leg_sim_util import *
import argparse
from math import floor
from numpy import arange
from random import randrange
import json

def get_valid_cal(json_fname, temp, vdd, proc):  
  with open(json_fname, 'r') as f: j = json.loads(f.read())
  arr = [val for i,val in enumerate(j) if val['temperature']==temp and val['vdd']==vdd and val['process']==proc]
  assert (len(arr)>0), 'No calibration found for this corner!'
  assert (len(arr)<2), 'Multiple calibrations found for this corner!'
  assert (arr[0]['calibration_success']==True), 'Calibration failed for this corner!'
  return arr[0]['valid_cal_enum']

def sim_slew(template, name, num_leg_en, pu_cal, pd_cal, temp, vdd, proc):
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
    replace_dict['pucal{}'.format(j)] = s
    s = '0'
    if cal2ctrl(pd_cal)[j]: s = str(vdd)
    replace_dict['pdcal{}'.format(j)] = s

  gen_spice_script(template, name, replace_dict)

  # Launch NGspice
  try:
    print('NGSPICE launched script "{outName}.spice"... '.format(outName=name))
    os.system('''
      make launch-ngspice \
      args=out/{outName}/{outName}.spice\\ -b\\ -o\\ out/{outName}/{outName}.log \
      >/dev/null 2>&1'''.format(outName=name))
    print('NGSPICE complete.')
    sleep(0.200) # 200 ms to leave time for interrupt
  except KeyboardInterrupt:
    print('\nSimulation halted')
    quit()

  # Read output
  data = {}
  with open('out/{name}/{name}.txt'.format(name=name), 'r') as d_file:
    l = d_file.readline()
    data['slew_up']   = round(0.2*vdd / float(l.split()[1]) / 1e9, 2) # V/ns
    data['slew_down'] = round(0.2*vdd / float(l.split()[3]) / 1e9, 2) # V/ns
  return data


def main():  
  parser = argparse.ArgumentParser(
    description='Generate and run a SSTL leg simulation.')
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
  tmp = 'spice/sstl_slew_tb.spice' # Original spice script template
  outNameTmp = 'sstl_{n}_slew_{t}_{v}_{p}'
  puCalTmp = './out/results/sstl_pu_{n}_resistance.json'
  pdCalTmp = './out/results/sstl_pd_{n}_resistance.json'
  if args.post_layout:
    tmp = 'spice/post_layout_sstl_slew_tb.spice' # Post-layout spice script template
    outNameTmp = 'post_layout_sstl_{n}_slew_{t}_{v}_{p}'
    puCalTmp = './out/results/post_layout_sstl_pu_{n}_resistance.json'
    pdCalTmp = './out/results/post_layout_sstl_pd_{n}_resistance.json'

  outName = outNameTmp.format(n=args.num_leg_en, t=args.temp, v=args.voltage, p=args.process)

  pu_cal_file = puCalTmp.format(n=args.num_leg_en)
  pd_cal_file = pdCalTmp.format(n=args.num_leg_en)
  pu_cal = get_valid_cal(pu_cal_file, args.temp, args.voltage, args.process)
  pd_cal = get_valid_cal(pd_cal_file, args.temp, args.voltage, args.process)

  result = sim_slew(tmp, outName, args.num_leg_en, pu_cal, pd_cal, float(args.temp), float(args.voltage), args.process)

  data_out = {}
  data_out['vdd']         = args.voltage
  data_out['temperature'] = args.temp
  data_out['process']     = args.process
  data_out['pu_cal_enum'] = pu_cal
  data_out['pd_cal_enum'] = pd_cal
  data_out.update(result) # Add slew results to dictionary
  fout_name = 'out/{name}/out.json'.format(name=outName)
  with open(fout_name, 'w') as f: f.write(json.dumps(data_out, indent=2))


if __name__ == '__main__':
  main()