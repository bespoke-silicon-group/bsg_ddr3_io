from sys import argv
from leg_sim_util import *
from math import floor
from numpy import arange
from random import randrange
tmp = 'n-leg_tb.spice'

def cal2ctrl(n):
  result = [0, 0, 0, 0]
  for b in range(len(bin(n))-2): result[b] = int(bin(n)[::-1][:-2][b] == '1')
  result.reverse()
  return result

def simCal(template, temp, vg, v1v5, proc):
  name = 'cal_sim_{t}_{v}_{p}'.format(t=temp, v=vg, p=proc)
  search_max = 15
  search_min = 0
  while True: # until break!
    if search_min > search_max:
      print('Calibration not possible!')
      break
    cal = floor((search_max+search_min)/2)
    ctrl_sig = cal2ctrl(cal)
    print('Trying cal = {c}: {a}'.format(c=cal, a=ctrl_sig))
    result = sim_params(template, outName=name, temp=temp, gateVoltage=vg, v1v5=v1v5,
      process=proc, ctrl_sig=ctrl_sig)
    res = checkResReq(result)
    if not(any(res)): # If all in range, we found calibration!
      print('Calibration found: {c}'.format(c=ctrl_sig))
      print('Resistances = {r}'.format(r=result))
      return {'cal':ctrl_sig, 'res':result}
    elif 1 in res and -1 in res: # If some out of range on either end, calibration is impossible!
      print('Calibration impossible with resistances: {r}'.format(r=result))
      break
    elif 1 in res: # Resistance was too high
      search_min = cal+1
    elif -1 in res: # Resistance was too low
      search_max = cal-1
    else: assert(False)
  assert(False, 'CALIBRATION FAILED!') 





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

temps = [-40, 125]
# Edge cases of control FET gate voltage (1.8V +/-10%), and VDD (1.5V +/-5%)
voltages = [[1.98, 1.575], [1.62, 1.475]]
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
with open('cal_log.txt', 'w') as outf:
  for temp in temps:
    for v in voltages:
      for proc in procs:
        output = simCal(tmp, temp, v[0], v[1], proc)
        outf.write('{t}, {v}, {p}\t\t{cal}\t{res}\n'.format(
          t=temp, v=v[0], p=proc, cal=output['cal'], res=output['res']))
        print()
        print()
print('ALL CORNER CALIBRATION CASES PASSED!')

temps = list(range(-40, 125, 5))
Vgs = list(arange(1.62, 1.98, 0.04))
V1v5s = list(arange(1.475, 1.575, 0.025))
with open('cal_log.txt', 'a') as outf:
  for i in range(200):
    temp = temps[randrange(len(temps))]
    vg   = round(  Vgs[randrange(len(  Vgs))], 3)
    v1v5 = round(V1v5s[randrange(len(V1v5s))], 3)
    proc = procs[randrange(len(procs))]
    output = simCal(tmp, temp, vg, v1v5, proc)
    outf.write('{t}, {v}, {p}\t\t{cal}\t{res}\n'.format(
      t=temp, v=vg, p=proc, cal=output['cal'], res=output['res']))
    print()
    print()
print('ALL M-C CASES PASSED!')

