import subprocess
import os

def sim_params(template_script, outName, temp, gateVoltage, process, plotName=''):
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

  # Call Main SED script to fill in params
  os.system('''sed '\
  s/SED_plotName_SED/{pname}/g; \
  s/SED_vg_SED/{vg}/g; \
  s/SED_temp_SED/{temp}/g; \
  s/SED_process_SED/{proc}/g; \
  ' {template} \
  >> out/scripts/{outName}.spice'''.format( \
  pname=plotName, vg=gateVoltage, temp=temp, proc=process, template=template_script, outName=outName))

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