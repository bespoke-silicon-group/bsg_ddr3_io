import subprocess
import os
from math import isclose
from time import sleep

LEG_EXPECTED_RES = 240
LEG_MIN_RES = 240*0.9
LEG_MAX_RES = 240*1.1

def checkResReq(r_set):
  result = [0, 0, 0]
  if   r_set['r_lvt'] < 0.6*LEG_EXPECTED_RES:
    result[0] = -1
  elif r_set['r_lvt'] > 1.1*LEG_EXPECTED_RES:
    result[0] = 1
  if   r_set['r_mvt'] < 0.9*LEG_EXPECTED_RES:
    result[1] = -1
  elif r_set['r_mvt'] > 1.1*LEG_EXPECTED_RES:
    result[1] = 1
  if   r_set['r_hvt'] < 0.9*LEG_EXPECTED_RES:
    result[2] = -1
  elif r_set['r_hvt'] > 1.4*LEG_EXPECTED_RES:
    result[2] = 1  
  return result


def sim_params(template_script, outName, temp, gateVoltage, process, v1v5=1.5, plotName='', ctrl_sig=[]):
  if plotName == '':
    plotName = outName

  # Add output directories
  try: os.mkdir('./out') 
  except: pass
  try: os.mkdir('./out/scripts')
  except: pass
  try: os.mkdir('./out/logs')
  except: pass
  try: os.mkdir('./out/data')
  except: pass
  try: os.mkdir('./out/plots')
  except: pass
  # Remove old file if it exists
  try: os.remove('./out/scripts/{outName}.spice'.format(outName=outName))
  except: pass # (in case the file does not exist)
  try: os.remove('./out/logs/{outName}.log'.format(outName=outName))
  except: pass # (in case the file does not exist)

  ctrl_script=''
  for i in range(len(ctrl_sig)):
    s = '0'
    if ctrl_sig[i]: s = str(gateVoltage)
    ctrl_script += 's/SED_vctrl{n}_SED/{s}/g; '.format(n=i, s=s)

  # Call Main SED script to fill in params
  os.system('''sed '\
  s/SED_plotName_SED/{pname}/g; \
  s/SED_vg_SED/{vg}/g; \
  s/SED_v1v5_SED/{v1v5}/g; \
  s/SED_temp_SED/{temp}/g; \
  s/SED_process_SED/{proc}/g; \
  {ctrl} \
  ' {template} \
  >> out/scripts/{outName}.spice'''.format( \
  pname=plotName, vg=gateVoltage, v1v5=v1v5, temp=temp, proc=process, ctrl=ctrl_script, template=template_script, outName=outName))

  # Launch NGspice
  try:
    print('NGSPICE launched script "{outName}.spice"... '.format(outName=outName))
    os.system('''
      make launch-ngspice \
      args=out/scripts/{outName}.spice\\ -b\\ -o\\ out/logs/{outName}.log \
      >/dev/null 2>&1'''.format(\
      outName=outName))
    print('NGSPICE complete.')
    sleep(0.200) # 200 ms to leave time for interrupt
  except KeyboardInterrupt:
    print('\nSimulation halted')
    quit()
  
  #print('^^^ IGNORE NGSPICE ERRORS, THEY ARE A LIE (USUALLY) ^^^')

  data = {}
  with open('out/data/{name}.txt'.format(name=plotName), 'r') as d_file:
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

def sstl_res_sim(template_script, outName, temp, vddVoltage, process, ctrl_dict, plotName=''):
  if plotName == '':
    plotName = outName

  # Add output directories
  try: os.mkdir('./out') 
  except: pass
  try: os.mkdir('./out/scripts')
  except: pass
  try: os.mkdir('./out/logs')
  except: pass
  try: os.mkdir('./out/data')
  except: pass
  try: os.mkdir('./out/plots')
  except: pass
  # Remove old file if it exists
  try: os.remove('./out/scripts/{outName}.spice'.format(outName=outName))
  except: pass # (in case the file does not exist)
  try: os.remove('./out/logs/{outName}.log'.format(outName=outName))
  except: pass # (in case the file does not exist)

  ctrl_script=''
  for i in range(7): # 7 pullup and pulldown legs
    s = '0'
    if ctrl_dict['pu'][i]['en']: s = str(vddVoltage)
    ctrl_script += 's/SED_puctrl{n}_SED/{s}/g; '.format(n=i, s=s)
    s = '0'
    if ctrl_dict['pd'][i]['en']: s = str(vddVoltage)
    ctrl_script += 's/SED_pdctrl{n}_SED/{s}/g; '.format(n=i, s=s)
    for j in range(4): # 4 calibration fets for each leg
      s = '0'
      if ctrl_dict['pu'][i]['cal'][j]: s = str(vddVoltage)
      ctrl_script += 's/SED_pucal{l}{n}_SED/{s}/g; '.format(l=i, n=j, s=s)
      s = '0'
      if ctrl_dict['pd'][i]['cal'][j]: s = str(vddVoltage)
      ctrl_script += 's/SED_pdcal{l}{n}_SED/{s}/g; '.format(l=i, n=j, s=s)

  # Call Main SED script to fill in params
  os.system('''sed '\
  s/SED_plotName_SED/{pname}/g; \
  s/SED_vdd_SED/{vdd}/g; \
  s/SED_temp_SED/{temp}/g; \
  s/SED_process_SED/{proc}/g; \
  {ctrl} \
  ' {template} \
  >> out/scripts/{outName}.spice'''.format( \
  pname=plotName, vdd=vddVoltage, temp=temp, proc=process, ctrl=ctrl_script, template=template_script, outName=outName))

  # Launch NGspice
  try:
    print('NGSPICE launched script "{outName}.spice"... '.format(outName=outName))
    os.system('''
      make launch-ngspice \
      args=out/scripts/{outName}.spice\\ -b\\ -o\\ out/logs/{outName}.log \
      >/dev/null 2>&1'''.format(\
      outName=outName))
    print('NGSPICE complete.')
    sleep(0.200) # 200 ms to leave time for interrupt
  except KeyboardInterrupt:
    print('\nSimulation halted')
    quit()
  
  #print('^^^ IGNORE NGSPICE ERRORS, THEY ARE A LIE (USUALLY) ^^^')

  data = {}
  with open('out/data/{name}.txt'.format(name=plotName), 'r') as d_file:
    for line in d_file:
      if isclose(float(line.split()[0]), 0.2*1.5):
        data['r_lvt'] = float(line.split()[1])
      if isclose(float(line.split()[0]), 0.5*1.5):
        data['r_mvt'] = float(line.split()[1])
      if isclose(float(line.split()[0]), 0.8*1.5):
        data['r_hvt'] = float(line.split()[1])

  return data