# A small utility to decode a corner string into it's fields for Make
# Example corner string: "1.5_27_tt" = 1.5V vdd, 27*C, and 'tt' process

from sys import argv
s = argv[1]
param = argv [2]

split=s.split('_', maxsplit=2)
if param=='v':
	print(split[1]);
elif param=='t':
	print(split[0]);
elif param=='p':
	print(split[2]);
else:
	exit(1);
