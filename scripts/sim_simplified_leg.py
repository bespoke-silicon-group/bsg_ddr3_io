from sys import argv
from leg_sim_util import *
import argparse
import json

def main():  
  parser = argparse.ArgumentParser(
    description='Generate and run a simplified SSTL leg simulation.')
  parser.add_argument('--dir', required=True, choices=['pu', 'pd'],
    help='Must be one of "pu" (pullup) or "pd" (pulldown)')
  parser.add_argument('--voltage', required=True, 
    help='VDD voltage for the sim')
  parser.add_argument('--temp', required=True, 
    help='temperature (*C) for the sim')
  parser.add_argument('--process', required=True, 
    help='process string for the sim')
  args = parser.parse_args()
  
  outname = 'simple_{d}_leg_{t}_{v}_{p}'.format(d=args.dir, v=args.voltage, t=args.temp, p=args.process)

  # Select template spice script
  tmp = 'spice/test_{d}_res.spice'.format(d=args.dir)  
  # Run simulation
  result = sim_leg_res(tmp, outname, 
    temp=args.temp, gateVoltage=args.voltage, vdd=args.voltage, process=args.process);
  # Write output
  data_out = {}
  data_out['vdd']         = args.voltage
  data_out['temperature'] = args.temp
  data_out['process']     = args.process
  data_out['resistances'] = result
  fout_name = 'out/{name}/out.json'.format(name=outname)
  with open(fout_name, 'w') as f: f.write(json.dumps(data_out, indent=2))

if __name__ == '__main__':
  main()