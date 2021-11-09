from leg_sim_util import *
from math import floor
tmp = 'n-leg.spice'

def cal2ctrl(n):
	result = [0, 0, 0, 0]
	# print(bin(n)[::-1][:-2])
	for b in range(len(bin(n))-2): result[b] = int(bin(n)[::-1][:-2][b] == '1')
	result.reverse()
	return result


temp = 27
vg   = 1.8
proc = 'tt'

name = 'cal_sim_{t}_{v}_{p}'.format(t=temp, v=vg, p=proc)
search_max = 15
search_min = 0
while True: # until break!
  cal = floor((search_max-search_min)/2)
  ctrl_sig = cal2ctrl(cal)
  print('Trying cal = {c}: {a}'.format(c=cal, a=ctrl_sig))
  result = sim_params(tmp, outName=name, temp=temp, gateVoltage=vg, 
    process=proc, ctrl_sig=ctrl_sig)

  print(result)
  break