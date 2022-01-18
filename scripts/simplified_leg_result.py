from sys import argv
from leg_sim_util import *
import argparse
import json
import os, re

def main():
  out_dirs = os.listdir('./out/')
  r_pu = re.compile('^simple_pu_leg_*')
  r_pd = re.compile('^simple_pd_leg_*')
  pu_dirs = list(filter(r_pu.search, out_dirs))
  pd_dirs = list(filter(r_pd.search, out_dirs))

  pu_all_data = []
  for pu_name in pu_dirs:
    with open('./out/'+pu_name+'/out.json', 'r') as f: pu_data = json.loads(f.read())
    pu_all_data.append(pu_data)
  
  pd_all_data = []
  for pd_name in pd_dirs:
    with open('./out/'+pd_name+'/out.json', 'r') as f: pd_data = json.loads(f.read())
    pd_all_data.append(pd_data)

  # generate output json and place in 'out/results/'
  try: os.mkdir('./out/results')
  except: pass
  fout_name = 'out/results/simplified_pd_resistance.json'
  with open(fout_name, 'w') as f: f.write(json.dumps(pd_all_data, indent=2))
  fout_name = 'out/results/simplified_pu_resistance.json'
  with open(fout_name, 'w') as f: f.write(json.dumps(pu_all_data, indent=2))

  # Print summary output
  print()
  print('### Simplified PULLDOWN leg resistance summary ##################')

  r = min([x['resistances']['r_lvt'] for x in pd_all_data])
  idx = [x['resistances']['r_lvt'] for x in pd_all_data].index(r)
  print('Min low resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pd_all_data[idx]['temperature'], v=pd_all_data[idx]['vdd'], p=pd_all_data[idx]['process']))
  
  r = min([x['resistances']['r_mvt'] for x in pd_all_data])
  idx = [x['resistances']['r_mvt'] for x in pd_all_data].index(r)
  print('Min mid resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pd_all_data[idx]['temperature'], v=pd_all_data[idx]['vdd'], p=pd_all_data[idx]['process']))
  
  r = min([x['resistances']['r_hvt'] for x in pd_all_data])
  idx = [x['resistances']['r_hvt'] for x in pd_all_data].index(r)
  print('Min high resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pd_all_data[idx]['temperature'], v=pd_all_data[idx]['vdd'], p=pd_all_data[idx]['process']))

  r = max([x['resistances']['r_lvt'] for x in pd_all_data])
  idx = [x['resistances']['r_lvt'] for x in pd_all_data].index(r)
  print('Max low resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pd_all_data[idx]['temperature'], v=pd_all_data[idx]['vdd'], p=pd_all_data[idx]['process']))
  
  r = max([x['resistances']['r_mvt'] for x in pd_all_data])
  idx = [x['resistances']['r_mvt'] for x in pd_all_data].index(r)
  print('Max mid resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pd_all_data[idx]['temperature'], v=pd_all_data[idx]['vdd'], p=pd_all_data[idx]['process']))
  
  r = max([x['resistances']['r_hvt'] for x in pd_all_data])
  idx = [x['resistances']['r_hvt'] for x in pd_all_data].index(r)
  print('Max high resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pd_all_data[idx]['temperature'], v=pd_all_data[idx]['vdd'], p=pd_all_data[idx]['process']))
  print('#################################################################')
  print()
  print('### Simplified PULLUP leg resistance summary ####################')
  r = min([x['resistances']['r_lvt'] for x in pu_all_data])
  idx = [x['resistances']['r_lvt'] for x in pu_all_data].index(r)
  print('Min low resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pu_all_data[idx]['temperature'], v=pu_all_data[idx]['vdd'], p=pu_all_data[idx]['process']))
  
  r = min([x['resistances']['r_mvt'] for x in pu_all_data])
  idx = [x['resistances']['r_mvt'] for x in pu_all_data].index(r)
  print('Min mid resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pu_all_data[idx]['temperature'], v=pu_all_data[idx]['vdd'], p=pu_all_data[idx]['process']))
  
  r = min([x['resistances']['r_hvt'] for x in pu_all_data])
  idx = [x['resistances']['r_hvt'] for x in pu_all_data].index(r)
  print('Min high resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pu_all_data[idx]['temperature'], v=pu_all_data[idx]['vdd'], p=pu_all_data[idx]['process']))

  r = max([x['resistances']['r_lvt'] for x in pu_all_data])
  idx = [x['resistances']['r_lvt'] for x in pu_all_data].index(r)
  print('Max low resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pu_all_data[idx]['temperature'], v=pu_all_data[idx]['vdd'], p=pu_all_data[idx]['process']))
  
  r = max([x['resistances']['r_mvt'] for x in pu_all_data])
  idx = [x['resistances']['r_mvt'] for x in pu_all_data].index(r)
  print('Max mid resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pu_all_data[idx]['temperature'], v=pu_all_data[idx]['vdd'], p=pu_all_data[idx]['process']))
  
  r = max([x['resistances']['r_hvt'] for x in pu_all_data])
  idx = [x['resistances']['r_hvt'] for x in pu_all_data].index(r)
  print('Max high resistance = {r} ohms (temperature={t} *C, Vdd={v} Volts, process={p})'.format(
    r=round(r,1), t=pu_all_data[idx]['temperature'], v=pu_all_data[idx]['vdd'], p=pu_all_data[idx]['process']))
  print('#################################################################')

if __name__ == '__main__':
  main()