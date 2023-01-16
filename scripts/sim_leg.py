from sys import argv
from leg_sim_util import *
import argparse
import json

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
  parser.add_argument('--ctrl-sig', default='1,1,1,1',
    help='Control signal string: 4 comma seperated "0" or "1" such as 0,1,0,1')
  parser.add_argument('--post-layout', action='store_true',
    help='Run post-layout simulation instead.')
  args = parser.parse_args()
  
  # Select template spice script
  d = 'n'
  if args.dir == 'pu':
    d = 'p'  
  tmp = 'spice/{d}-leg_tb.spice'.format(d=d)
  outname = '{d}_leg_{t}_{v}_{p}'.format(d=args.dir, v=args.voltage, t=args.temp, p=args.process)
  if args.post_layout:
    tmp = 'spice/post_layout_{d}-leg_tb.spice'.format(d=d)
    outname = 'post_layout_{d}_leg_{t}_{v}_{p}'.format(d=args.dir, v=args.voltage, t=args.temp, p=args.process)

  # Generate control signal list
  ctrl_sig = [int(c) for c in args.ctrl_sig.split(',')]
  # Run simulation
  result = sim_leg_res(tmp, outname, 
    temp=args.temp, gateVoltage=args.voltage, vdd=args.voltage, process=args.process, ctrl_sig=ctrl_sig);
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