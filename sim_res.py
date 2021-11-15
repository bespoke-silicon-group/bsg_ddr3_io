from sys import argv
from leg_sim_util import *

# Decide template script and output name based on user choice of 'pulldown' or 'pullup'
if len(argv)>1 and argv[1]=='pulldown':
  tmp       = 'test_pd_res.spice'
  name_temp = 'pd_pres_sim'
elif len(argv)>1 and argv[1]=='pullup':
  tmp       = 'test_pu_res.spice'
  name_temp = 'pu_pres_sim'
else:
  print('Missing argument. "pulldown" or "pullup"')
  print('Usage: {fname} pulldown/pullup'.format(fname=argv[0]))
  quit()

result = sim_params(tmp, outName='pres_sim_typ', temp=27, gateVoltage=1.8, process='tt');
print('Typical case:')
print('Min resistance = {r} ohms.'.format(r=round(min(result.values()),1)))
print('Max resistance = {r} ohms.'.format(r=round(max(result.values()),1)))
print()

# All sim cases
minr = 1000
maxr = 0
mincase = maxcase = [0, 0, '']
temps = [-40, 125]
Vgs = [1.98, 1.62]
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
for temp in temps:
  for vg in Vgs:
    for proc in procs:
      name = '{n}_{t}_{v}_{p}'.format(n=name_temp, t=temp, v=vg, p=proc); # TODO Add name here!
      result = sim_params(tmp, outName=name, temp=temp, gateVoltage=vg, process=proc);
      if min(result.values()) < minr:
        minr = min(result.values())
        mincase = [temp, vg, proc]  
      if max(result.values()) > maxr:
        maxr = max(result.values())
        maxcase = [temp, vg, proc]
      if -1 in checkResReq(result):
        print('Test FAILED resistance out of range! {r}'.format(r=result))
        quit()

print()
print('Global min resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=round(minr, 1), t=mincase[0], v=mincase[1], p=mincase[2]))
print('Global max resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=round(maxr, 1), t=maxcase[0], v=maxcase[1], p=maxcase[2]))
print()

print('Simulations of {tmp} complete!'.format(tmp=tmp))

