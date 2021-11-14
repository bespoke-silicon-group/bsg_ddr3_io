from leg_sim_util import sim_params

tmp = 'n-leg_tb.spice'
ctrl_sig = [1, 1, 1, 1]

print('Calibration input is: {a}'.format(a=ctrl_sig))

result = sim_params(tmp, outName='n-leg_sim_typ', temp=27, gateVoltage=1.8, 
  process='tt', ctrl_sig=ctrl_sig)
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
      name = 'n-leg_sim_{t}_{v}_{p}'.format(t=temp, v=vg, p=proc);
      result = sim_params(tmp, outName=name, temp=temp, gateVoltage=vg, 
        process=proc, ctrl_sig=ctrl_sig)

      if min(result.values()) < minr:
        minr = min(result.values())
        mincase = [temp, vg, proc]  
      if max(result.values()) > maxr:
        maxr = max(result.values())
        maxcase = [temp, vg, proc]

print()
print('Global min resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=round(minr, 1), t=mincase[0], v=mincase[1], p=mincase[2]))
print('Global max resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=round(maxr, 1), t=maxcase[0], v=maxcase[1], p=maxcase[2]))
print()

print('Simulations of {tmp} complete!'.format(tmp=tmp))
