from sys import argv
from leg_sim_util import *
import argparse
import json
import os, re

def main():

  out_dirs = os.listdir('./out/')

  output_templates = ['pd_7', 'pu_7', 'pd_6', 'pu_6']
  for ot in output_templates:
    # Filter output directories
    r = re.compile('^sstl_{t}_cal_sim_*'.format(t=ot))
    dirs = list(filter(r.search, out_dirs))

    # Combine into single JSON
    all_data = []
    num_cases_passed = 0
    for name in dirs:
      with open('./out/'+name+'/out.json', 'r') as f: data = json.loads(f.read())
      all_data.append(data)
      if data['calibration_success'] == True: num_cases_passed += 1
    
    # Write output
    try: os.mkdir('./out/results')
    except: pass
    fout_name = 'out/results/sstl_{t}_resistance.json'.format(t=ot)
    with open(fout_name, 'w') as f: f.write(json.dumps(all_data, indent=2))

    # Print summary    
    print()
    print('Configuration "{tem}": {p}/{tot} calibration cases passed'.format(
      tem=ot, p=num_cases_passed, tot=len(dirs)))

  print()
  

if __name__ == '__main__':
  main()
