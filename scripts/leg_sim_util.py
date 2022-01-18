import subprocess
import os
from math import isclose
from time import sleep

TEMPS = [-40, 125]
VDDS  = [1.575, 1.475]
PROCS = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']

def checkResReq(r_set, expected_res=240, negate=False):
  if negate: 
    for k in r_set: r_set[k] = -r_set[k]
  result = [0, 0, 0]
  if   r_set['r_lvt'] < 0.6*expected_res:
    result[0] = -1
  elif r_set['r_lvt'] > 1.1*expected_res:
    result[0] = 1
  if   r_set['r_mvt'] < 0.9*expected_res:
    result[1] = -1
  elif r_set['r_mvt'] > 1.1*expected_res:
    result[1] = 1
  if   r_set['r_hvt'] < 0.9*expected_res:
    result[2] = -1
  elif r_set['r_hvt'] > 1.4*expected_res:
    result[2] = 1  
  return result

def cal2ctrl(n):
  result = [0, 0, 0, 0]
  for b in range(len(bin(n))-2): result[b] = int(bin(n)[::-1][:-2][b] == '1')
  result.reverse()
  return result

def gen_spice_script(template, outName, replace_dict):
  try: os.mkdir('./out/{}'.format(outName))
  except: pass
  try: os.system('rm -rf ./out/{}/*'.format(outName))
  except: pass
  # Generate the SED replacement strings
  replace_script = ''
  for k in replace_dict:
    replace_script += 's/SED_{k}_SED/{v}/g; '.format(k=k, v=replace_dict[k])  
  os.system('''sed '{rep}' {template} >> out/{outName}/{outName}.spice'''.format(
    rep=replace_script, template=template, outName=outName))


def sim_leg_res(template_script, outName, temp, gateVoltage, process, vdd=1.5, plotName='', ctrl_sig=[]):
    if plotName == '':
      plotName = outName

    replace_dict = {}
    replace_dict['outName'] = plotName
    replace_dict['plotName'] = plotName
    replace_dict['vg']       = gateVoltage
    replace_dict['vdd']      = vdd
    replace_dict['temp']     = temp
    replace_dict['process']  = process
    for i in range(len(ctrl_sig)):
      s = '0'
      if ctrl_sig[i]: s = str(gateVoltage)
      replace_dict['vctrl{}'.format(i)] = s

    gen_spice_script(template_script, outName, replace_dict)

    # Launch NGspice
    try:
      print('NGSPICE launched script "{outName}.spice"... '.format(outName=outName))
      os.system('''
        make launch-ngspice \
        args=out/{outName}/{outName}.spice\\ -b\\ -o\\ out/{outName}/{outName}.log \
        >/dev/null 2>&1'''.format(\
        outName=outName))
      print('NGSPICE complete.')
      sleep(0.200) # 200 ms to leave time for interrupt
    except KeyboardInterrupt:
      print('\nSimulation halted')
      quit()    

    data = {}
    with open('out/{name}/{name}.txt'.format(name=outName), 'r') as d_file:
      for line in d_file:
        if isclose(float(line.split()[0]), 0.2*1.5):
          data['r_lvt'] = float(line.split()[1])
        if isclose(float(line.split()[0]), 0.5*1.5):
          data['r_mvt'] = float(line.split()[1])
        if isclose(float(line.split()[0]), 0.8*1.5):
          data['r_hvt'] = float(line.split()[1])

    return data


default_ctrl_dict = {'pu':7*[{'en':0, 'cal':[0,0,0,0]}],
                     'pd':7*[{'en':0, 'cal':[0,0,0,0]}]}

def sstl_res_sim(template_script, outName, is_pulldown, temp, vddVoltage, process, ctrl_dict, plotName=''):
  if plotName == '':
    plotName = outName
  
  replace_dict = {}
  replace_dict['plotName'] = plotName
  replace_dict['vdd']      = vddVoltage
  replace_dict['temp']     = temp
  replace_dict['process']  = process
  for i in range(7): # 7 pullup and pulldown legs
    s = '0'
    if ctrl_dict['pu'][i]['en']: s = str(vddVoltage)
    replace_dict['puctrl{}'.format(i)] = s    
    s = '0'
    if ctrl_dict['pd'][i]['en']: s = str(vddVoltage)
    replace_dict['pdctrl{}'.format(i)] = s
    for j in range(4): # 4 calibration fets for each leg
      s = '0'
      if ctrl_dict['pu'][i]['cal'][j]: s = str(vddVoltage)
      replace_dict['pucal{l}{n}'.format(l=i, n=j)] = s
      s = '0'
      if ctrl_dict['pd'][i]['cal'][j]: s = str(vddVoltage)
      replace_dict['pdcal{l}{n}'.format(l=i, n=j)] = s

  gen_spice_script(template_script, outName, replace_dict)

  # Launch NGspice
  try:
    print('NGSPICE launched script "{outName}.spice"... '.format(outName=outName))
    os.system('''
      make launch-ngspice \
      args=out/{outName}/{outName}.spice\\ -b\\ -o\\ out/{outName}/{outName}.log \
      >/dev/null 2>&1'''.format(\
      outName=outName))
    print('NGSPICE complete.')
    sleep(0.200) # 200 ms to leave time for interrupt
  except KeyboardInterrupt:
    print('\nSimulation halted')
    quit()

  data = {}
  with open('out/{name}/{name}.txt'.format(name=plotName), 'r') as d_file:
    for line in d_file:
      if isclose(float(line.split()[0]), 0.2*1.5):
        if not is_pulldown:
          data['r_hvt'] = 0.8*1.5 / float(line.split()[1])
        else:
          data['r_lvt'] = 0.2*1.5 / float(line.split()[1])
      if isclose(float(line.split()[0]), 0.5*1.5):
        data['r_mvt'] = 0.5*1.5 / float(line.split()[1])
      if isclose(float(line.split()[0]), 0.8*1.5):
        if not is_pulldown:
          data['r_lvt'] = 0.2*1.5 / float(line.split()[1])
        else:
          data['r_hvt'] = 0.8*1.5 / float(line.split()[1])

  return data
