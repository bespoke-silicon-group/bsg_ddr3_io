from leg_sim_util import *
from math import floor
tmp = 'n-leg.spice'

def cal2ctrl(n):
  result = [0, 0, 0, 0]
  # print(bin(n)[::-1][:-2])
  for b in range(len(bin(n))-2): result[b] = int(bin(n)[::-1][:-2][b] == '1')
  result.reverse()
  return result

def checkResReq(r_set):
  result = [0, 0, 0]
  if   r_set['r_lvt'] < 0.6*240:
    result[0] = -1
  elif r_set['r_lvt'] > 1.1*240:
    result[0] = 1
  if   r_set['r_mvt'] < 0.9*240:
    result[1] = -1
  elif r_set['r_mvt'] > 1.1*240:
    result[1] = 1
  if   r_set['r_hvt'] < 0.9*240:
    result[2] = -1
  elif r_set['r_hvt'] > 1.4*240:
    result[2] = 1  
  return result

def simCal(temp, vg, proc):
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
    result = sim_params(tmp, outName=name, temp=temp, gateVoltage=vg, 
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
      search_min = cal
    elif -1 in res: # Resistance was too low
      search_max = cal
    else: assert(False)
  assert(False, 'CALIBRATION FAILED!') 


# Typical 
#temp = 27
#vg   = 1.8
#proc = 'tt'

# Highest Resistance
#temp = 85
#vg   = 1.62
#proc = 'fs_mm'

# Lowest Resistance
#temp = -40
#vg   = 1.98
#proc = 'lh'

temps = [-40, 85]
Vgs = [1.98, 1.62]
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
with open('cal_log.txt', 'w') as outf:
  for temp in temps:
    for vg in Vgs:
      for proc in procs:
        output = simCal(temp, vg, proc)
        outf.write('{t}, {v}, {p}\t\t{cal}\t{res}\n'.format(
          t=temp, v=vg, p=proc, cal=output['cal'], res=output['res']))
        print()
        print()
print('ALL CALIBRATIONS PASSED!')

