from sys import argv
from leg_sim_util import sim_params

# Decide template script and output name based on user choice of 'pulldown' or 'pullup'
if len(argv)>1 and argv[1]=='pulldown':
  tmp       = 'n-leg_tb.spice'
  name_temp = 'n-leg_sim'
elif len(argv)>1 and argv[1]=='pullup':
  tmp       = 'p-leg_tb.spice'
  name_temp = 'p-leg_sim'
else:
  print('Missing argument. "pulldown" or "pullup"')
  print('Usage: {fname} pulldown/pullup <CAL_OPTION>'.format(fname=argv[0]))
  quit()

# Optionally, set the calibration control value from arguments
ctrl_sig = [1, 1, 1, 1]
if len(argv) > 2:
  ctrl_sig = [int(c) for c in argv[2].split(',')]

print('Calibration input is: {a}'.format(a=ctrl_sig))

result = sim_params(tmp, outName='{n}_typ'.format(n=name_temp), temp=27, gateVoltage=1.8, 
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
# Edge cases of control FET gate voltage (1.8V +/-10%), and VDD (1.5V +/-5%)
voltages = [[1.98, 1.575], [1.62, 1.475]]
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
for temp in temps:
  for v in voltages:
    for proc in procs:
      name = '{n}_{t}_{v}_{p}'.format(n=name_temp, t=temp, v=v[0], p=proc);
      result = sim_params(tmp, outName=name, temp=temp, gateVoltage=v[0], v1v5=v[1], 
        process=proc, ctrl_sig=ctrl_sig)

      if min(result.values()) < minr:
        minr = min(result.values())
        mincase = [temp, v[0], proc]  
      if max(result.values()) > maxr:
        maxr = max(result.values())
        maxcase = [temp, v[0], proc]

print()
print('Global min resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=round(minr, 1), t=mincase[0], v=mincase[1], p=mincase[2]))
print('Global max resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=round(maxr, 1), t=maxcase[0], v=maxcase[1], p=maxcase[2]))
print()

print('Simulations of {tmp} complete!'.format(tmp=tmp))
