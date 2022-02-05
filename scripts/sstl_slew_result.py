from sys import argv
from leg_sim_util import *
import argparse
import json
import os, re

def main():
  parser = argparse.ArgumentParser(
    description='Collect output from SSTL slew simulation')
  parser.add_argument('--post-layout', action='store_true',
    help='Run post-layout simulation instead.')
  args = parser.parse_args()

  # Set names based on simulation type
  reTmp = '^sstl_{t}_slew_*' # Original spice script regex string
  foutNameTmp = 'out/results/sstl_{t}_slew.json'
  if args.post_layout:
    reTmp = '^post_layout_sstl_{t}_slew_*' # Post-layout spice script regex string
    foutNameTmp = 'out/results/post_layout_sstl_{t}_slew.json'

  out_dirs = os.listdir('./out/')

  # NOTE: the spec only specifies a slew requirement for the 7-leg configuraiton
  output_templates = ['7'] # ['7', '6']

  for ot in output_templates:
    # Filter output directories
    r = re.compile(reTmp.format(t=ot))    
    dirs = list(filter(r.search, out_dirs))

    # Combine into single JSON
    all_data = []    
    for name in dirs:
      with open('./out/'+name+'/out.json', 'r') as f: data = json.loads(f.read())
      all_data.append(data)      

    # Write output
    try: os.mkdir('./out/results')
    except: pass
    fout_name = foutNameTmp.format(t=ot)
    with open(fout_name, 'w') as f: f.write(json.dumps(all_data, indent=2))

    # Print summary
    print()
    print('With {n} legs enabled:'.format(n=ot))
    # Print minimum slew
    min_slew_down = min([x['slew_down'] for x in all_data])
    min_slew_up   = min([x['slew_up']   for x in all_data])
    if min_slew_up < min_slew_down:
      idx = [x['slew_up'] for x in all_data].index(min_slew_up)
      print('Minimum slew = {s} V/ns (slew up, {t}*C, {v}V, "{p}" process)'.format(
        s=min_slew_up, t=all_data[idx]['temperature'], v=all_data[idx]['vdd'], p=all_data[idx]['process']))
    else:
      idx = [x['slew_down'] for x in all_data].index(min_slew_down)
      print('Minimum slew = {s} V/ns (slew down, {t}*C, {v}V, "{p}" process)'.format(
        s=min_slew_down, t=all_data[idx]['temperature'], v=all_data[idx]['vdd'], p=all_data[idx]['process']))

    # Print maximum slew
    max_slew_down = max([x['slew_down'] for x in all_data])
    max_slew_up   = max([x['slew_up']   for x in all_data])
    if max_slew_up > max_slew_down:
      idx = [x['slew_up'] for x in all_data].index(max_slew_up)
      print('Maximum slew = {s} V/ns (slew up, {t}*C, {v}V, "{p}" process)'.format(
        s=max_slew_up, t=all_data[idx]['temperature'], v=all_data[idx]['vdd'], p=all_data[idx]['process']))
    else:
      idx = [x['slew_down'] for x in all_data].index(max_slew_down)
      print('Maximum slew = {s} V/ns (slew down, {t}*C, {v}V, "{p}" process)'.format(
        s=max_slew_down, t=all_data[idx]['temperature'], v=all_data[idx]['vdd'], p=all_data[idx]['process']))
    
  print()

if __name__ == '__main__':
  main()