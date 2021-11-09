import subprocess
import os

LEG_EXPECTED_RES = 240
LEG_MIN_RES = 240*0.9
LEG_MAX_RES = 240*1.1

def sim_params(template_script, outName, temp, gateVoltage, process, plotName='', ctrl_sig=[]):
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
  s/SED_temp_SED/{temp}/g; \
  s/SED_process_SED/{proc}/g; \
  {ctrl} \
  ' {template} \
  >> out/scripts/{outName}.spice'''.format( \
  pname=plotName, vg=gateVoltage, temp=temp, proc=process, ctrl=ctrl_script, template=template_script, outName=outName))

  # Launch NGspice
  print('NGSPICE launched script "{outName}.spice"... '.format(outName=outName))
  os.system('''
    make launch-ngspice \
    args=out/scripts/{outName}.spice\\ -b\\ -o\\ out/logs/{outName}.log \
    >/dev/null 2>&1'''.format(\
    outName=outName))
  print('NGSPICE complete.')
  #print('^^^ IGNORE NGSPICE ERRORS, THEY ARE A LIE (USUALLY) ^^^')

  # Read data from output file
  data = []
  with open('out/data/{name}.txt'.format(name=plotName), 'r') as d_file:
    for line in d_file:
      data.append( float(line.split()[1]) )

  min_r = min(data)
  max_r = max(data)

  return [min_r, max_r]
