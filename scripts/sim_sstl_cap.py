from sys import argv
from leg_sim_util import *
import argparse
from math import floor
from numpy import arange
from random import randrange
import json
from warnings import warn

def get_valid_cal(json_fname, temp, vdd, proc):  
  with open(json_fname, 'r') as f: j = json.loads(f.read())
  arr = [val for i,val in enumerate(j) if val['temperature']==temp and val['vdd']==vdd and val['process']==proc]
  if len(arr)<=0:
    # return None
    warn('No calibration fround for this corner, using default cal enum: 7')
    return 7 # Return default cal enum so simulation runs anyway
  assert (len(arr)<2), 'Multiple calibrations found for this corner!'
  if (arr[0]['calibration_success']==False):
    warn('Calibration failed for this corner! using MAX cal enum: 15')
    return 15
  return arr[0]['valid_cal_enum']

def sim_slew(template, name, pu_cal, pd_cal, temp, vdd, proc):
  replace_dict = {}
  replace_dict['plotName'] = name
  replace_dict['vdd']      = vdd
  replace_dict['temp']     = temp
  replace_dict['process']  = proc

  for j in range(4): # 4 calibration fets for each leg
    s = '0'
    if cal2ctrl(pu_cal)[j]: s = str(vdd)
    replace_dict['pucal{}'.format(j)] = s
    s = '0'
    if cal2ctrl(pd_cal)[j]: s = str(vdd)
    replace_dict['pdcal{}'.format(j)] = s

  replace_dict['vih'] = 0.95*vdd
  replace_dict['vil'] = 0.05*vdd
  
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
    # charge_time = 3*25ohms*C
    data['cap_charge']    = round(float(l.split()[1])/(3*25) * 1e12, 3) # pF
    data['cap_discharge'] = round(float(l.split()[3])/(3*25) * 1e12, 3) # pF
  return data


def main():  
  parser = argparse.ArgumentParser(
    description='Generate and run a SSTL measurement simulation.')
  parser.add_argument('--voltage', required=True, 
    help='VDD voltage for the sim')
  parser.add_argument('--temp', required=True, 
    help='temperature (*C) for the sim')
  parser.add_argument('--process', required=True, 
    help='process string for the sim')
  parser.add_argument('--post-layout', action='store_true',
    help='Run post-layout simulation instead.')
  args = parser.parse_args()

  # Set names based on simulation type
  tmp = '' # schematic sim not supported
  outNameTmp = 'sstl_cap_{t}_{v}_{p}'
  puCalTmp = './out/results/sstl_pu_{n}_resistance.json'
  pdCalTmp = './out/results/sstl_pd_{n}_resistance.json'
  if args.post_layout:
    tmp = 'spice/post_layout_sstl_cap_tb.spice' # Post-layout spice script template
    outNameTmp = 'post_layout_sstl_cap_{t}_{v}_{p}'
    puCalTmp = './out/results/post_layout_sstl_pu_{n}_resistance.json'
    pdCalTmp = './out/results/post_layout_sstl_pd_{n}_resistance.json'

  outName = outNameTmp.format(t=args.temp, v=args.voltage, p=args.process)

  pu_cal_file = puCalTmp.format(n=7) # Load the 7-leg calibration
  pd_cal_file = pdCalTmp.format(n=7)
  pu_cal = get_valid_cal(pu_cal_file, args.temp, args.voltage, args.process)
  pd_cal = get_valid_cal(pd_cal_file, args.temp, args.voltage, args.process)
  if pu_cal == None or pd_cal == None:
    warn('No calibration for this corner! Skipping Slew sim')
    return

  result = sim_slew(tmp, outName, pu_cal, pd_cal, float(args.temp), float(args.voltage), args.process)

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
