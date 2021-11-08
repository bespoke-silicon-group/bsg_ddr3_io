from leg_sim_util import *

tmp = 'test_resistance.spice'

result = sim_params(tmp, outName='pres_sim_typ', temp=27, gateVoltage=1.8, process='tt');
print('Typical case:')
print('Min resistance = {r} ohms.'.format(r=round(result[0],1)))
print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
print()

# All sim cases
minr = 1000
maxr = 0
mincase = maxcase = [0, 0, '']
temps = [-40, 85]
Vgs = [1.98, 1.62]
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
for temp in temps:
  for vg in Vgs:
    for proc in procs:
      name = 'pres_sim_{t}_{v}_{p}'.format(t=temp, v=vg, p=proc);
      result = sim_params(tmp, outName=name, temp=temp, gateVoltage=vg, process=proc);
      if result[0] < minr:
        minr = result[0]
        mincase = [temp, vg, proc]
      if result[1] > maxr:
        maxr = result[1]
        maxcase = [temp, vg, proc]

print()
print('Global min resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=minr, t=mincase[0], v=mincase[1], p=mincase[2]))
print('Global max resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=maxr, t=maxcase[0], v=maxcase[1], p=maxcase[2]))
print()

print('Simulations of {tmp} complete!'.format(tmp=tmp))

if minr > LEG_MIN_RES:
  print('Test passed. Minimum resistance is in range.')
else:
  print('Test FAILED. Minimum resistance {ra} ohms is below the min case {re} ohms.'.format( \
    ra=minr, re=LEG_MIN_RES))