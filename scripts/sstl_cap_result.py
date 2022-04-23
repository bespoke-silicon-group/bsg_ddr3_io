from sys import argv
from leg_sim_util import *
import argparse
import json
import os, re

def main():
  parser = argparse.ArgumentParser(
    description='Collect output from SSTL capacitance measurement simulation')
  parser.add_argument('--post-layout', action='store_true',
    help='Run post-layout simulation instead.')
  args = parser.parse_args()

  # Set names based on simulation type
  reTmp = '' # Schematic sim not supported
  foutNameTmp = 'out/results/sstl_cap.json'
  if args.post_layout:
    reTmp = '^post_layout_sstl_cap_*' # Post-layout spice script regex string
    foutNameTmp = 'out/results/post_layout_sstl_cap.json'

  out_dirs = os.listdir('./out/')

  # Filter output directories
  r = re.compile(reTmp)    
  dirs = list(filter(r.search, out_dirs))

  # Combine into single JSON
  all_data = []    
  for name in dirs:
    with open('./out/'+name+'/out.json', 'r') as f: data = json.loads(f.read())
    all_data.append(data)      

  # Write output
  try: os.mkdir('./out/results')
  except: pass
  fout_name = foutNameTmp
  with open(fout_name, 'w') as f: f.write(json.dumps(all_data, indent=2))

  # Print summary
  print()
  print('SSTL input capacitance:')
  # Print minimum capacitance
  min_cap_up   = min([x['cap_charge']    for x in all_data])
  min_cap_down = min([x['cap_discharge'] for x in all_data])
  min_cap = min([min_cap_up, min_cap_down])
  if min_cap == min_cap_up:
    idx = [x['cap_charge'] for x in all_data].index(min_cap_up)
  else:
    idx = [x['cap_discharge'] for x in all_data].index(min_cap_down)
  print('Minimum capacitance = {s} pF ({t}*C, {v}V, "{p}" process)'.format(
    s=min_cap, t=all_data[idx]['temperature'], v=all_data[idx]['vdd'], p=all_data[idx]['process'])) 

  # Print maximum capacitance
  max_cap_up   = max([x['cap_charge']    for x in all_data])
  max_cap_down = max([x['cap_discharge'] for x in all_data])
  max_cap = max([max_cap_up, max_cap_down])
  if max_cap == max_cap_up:
    idx = [x['cap_charge'] for x in all_data].index(max_cap_up)
  else:
    idx = [x['cap_discharge'] for x in all_data].index(max_cap_down)
  print('Maximum capacitance = {s} pF ({t}*C, {v}V, "{p}" process)'.format(
    s=max_cap, t=all_data[idx]['temperature'], v=all_data[idx]['vdd'], p=all_data[idx]['process']))
    
  print()

if __name__ == '__main__':
  main()