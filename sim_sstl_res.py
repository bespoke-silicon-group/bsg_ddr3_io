from sys import argv
from leg_sim_util import *
from math import floor
from numpy import arange
from random import randrange
template = 'sstl_res_tb.spice'

ctrl_dict = {'pu':7*[{'en':0, 'cal':[0,1,1,1]}],
             'pd':7*[{'en':0, 'cal':[0,1,1,1]}]}

for i in range(7): ctrl_dict['pd'][i]['en'] = 1

result = sstl_res_sim(template, outName='sstl_sim_typ', temp=27, vddVoltage=1.8, 
      process='tt', ctrl_dict=ctrl_dict)
print('Result = {}'.format(result))
