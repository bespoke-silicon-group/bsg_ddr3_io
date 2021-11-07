import subprocess
import os

target_var = 'v(vddq)/i(vtest' # yes, I know missing ")"
#template_netlist = 'test_resistance.spice'
template_netlist = 'n-leg.spice'

def sim_params(outName, temp, gateVoltage, process, plotName=''):
  if plotName == '':
    plotName = outName

  # Remove old file if it exists
  try: 
    os.remove('./out/scripts/{outName}.spice'.format(outName=outName))
  except:
    pass # (in case the file does not exist)
  try: 
    os.remove('./out/logs/{outName}.log'.format(outName=outName))
  except:
    pass # (in case the file does not exist)

  # Call Main SED script to fill in params
  os.system('''sed '\
  s/SED_plotName_SED/{pname}/g; \
  s/SED_vg_SED/{vg}/g; \
  s/SED_temp_SED/{temp}/g; \
  s/SED_process_SED/{proc}/g; \
  ' {template} \
  >> out/scripts/{outName}.spice'''.format( \
  pname=plotName, vg=gateVoltage, temp=temp, proc=process, template=template_netlist, outName=outName))

  # Launch NGspice
  print('NGSPICE launched script "{outName}.spice"... '.format(outName=outName))
  os.system('''
    make launch-ngspice \
    args=out/scripts/{outName}.spice\\ -b\\ -o\\ out/logs/{outName}.log \
    >/dev/null 2>&1'''.format(\
    outName=outName))
  print('NGSPICE complete.')
  #print('^^^ IGNORE NGSPICE ERRORS, THEY ARE A LIE (USUALLY) ^^^')

  # Read data from log
  data = []
  with open('out/logs/{outName}.log'.format(outName=outName), 'r') as sim_log:
    # Parse until we reach the variable we want
    for line in sim_log:
      if target_var in line:
        break
    sim_log.readline();
    for l in range(32):
      line = sim_log.readline()
      #print('line {ind} is {str}'.format(ind=l, str=line))
      data.append( float(line.split()[2]) )

  min_r = min(data)
  max_r = max(data)

  return [min_r, max_r]



# MAIN #########################################################################

result = sim_params(outName='resSim_typ', temp=27, gateVoltage=1.8, process='tt');
print('Typical case:')
print('Min resistance = {r} ohms.'.format(r=round(result[0],1)))
print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
print()


result = sim_params(outName='resSim_low_lh', temp=-40, gateVoltage=1.98, process='lh_mm');
print('Lowest resistance "lh" case:')
print('Min resistance = {r} ohms. <====='.format(r=round(result[0],1)))
print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
print()

result = sim_params(outName='resSim_high_hl', temp=85, gateVoltage=1.62, process='hl');
print('Highest resistance "hl" case:')
print('Min resistance = {r} ohms.'.format(r=round(result[0],1)))
print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
print()

# result = sim_params(outName='resSim_low', temp=-40, gateVoltage=1.98, process='ll');
# print('Lowest resistance case:')
# print('Min resistance = {r} ohms.'.format(r=round(result[0],1)))
# print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
# print()

# result = sim_params(outName='resSim_high', temp=85, gateVoltage=1.62, process='hh');
# print('Highest resistance case:')
# print('Min resistance = {r} ohms.'.format(r=round(result[0],1)))
# print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
# print()

# result = sim_params(outName='resSim_lh', temp=85, gateVoltage=1.62, process='lh');
# print('Highest resistance "lh" case:')
# print('Min resistance = {r} ohms.'.format(r=round(result[0],1)))
# print('Max resistance = {r} ohms.'.format(r=round(result[1],1)))
# print()

# All sim cases
minr = 1000
maxr = 0
mincase = maxcase = [0, 0, '']
temps = [-40, 85]
Vgs = [1.98, 1.62]
procs = ['ff', 'ff_mm', 'fs', 'fs_mm', 'hh', 'hh_mm', 'hl', 'hl_mm', 'lh', 'lh_mm', 'll', 'll_mm', 'sf', 'sf_mm', 'ss', 'ss_mm', 'tt', 'tt_mm']
for temp in temps:
  for vg in Vgs:
    for proc in procs:
      name = 'sim_{t}_{v}_{p}'.format(t=temp, v=vg, p=proc);
      result = sim_params(outName=name, temp=temp, gateVoltage=vg, process=proc);
      if result[0] < minr:
        minr = result[0]
        mincase = [temp, vg, proc]
      if result[1] > maxr:
        maxr = result[1]
        maxcase = [temp, vg, proc]

print()
print('Global min resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=minr, t=mincase[0], v=mincase[1], p=mincase[2]))
print('Global max resistance = {r} ({t}C, {v}Vg, "{p}" proc).'.format(
  r=maxr, t=maxcase[0], v=maxcase[1], p=maxcase[2]))
print()

print('Simulations complete!')
