#!/usr/bin/env python

import sys
import numpy as np
import matplotlib.pyplot as plt


samples = map(lambda x: x.strip(),open(sys.argv[1]).readlines())
days = map(lambda x: x.strip(), open(sys.argv[2]).readlines())
paths = map(lambda x: x.strip() ,open(sys.argv[3]).readlines())

days = map(lambda x: int(x),days)
set_days = set(days)

sample_day_map = {x:y for (x,y) in zip(samples,days)}

sample_index_dictionary = {x:y for (x,y) in zip(samples,range(len(samples)))}

print sample_day_map

lw_positions = map(lambda x: x.split(),open(sys.argv[4]).readlines())
mw_positions = map(lambda x: x.split(),open(sys.argv[5]).readlines())

print lw_positions
print mw_positions

position_header = []
position_index_dictionary = {}
lw_mw_header = []

for i,position in enumerate(lw_positions + mw_positions):
    position_header.append(position[1])
    position_index_dictionary[(position[0],position[1])] = i
    lw_mw_header.append(position[0].split("|")[5])


quantification_array = np.zeros((len(position_index_dictionary),len(samples)))

print position_header
print position_index_dictionary
print lw_mw_header


for sample,day,path in zip(samples,days,paths):
    print str((sample,day,path))
    sample_pile = open(path)
    for line in sample_pile:
        print line.split()
        gene,position,reference,count,match_code,quality = line.split()
        quantification_array[position_index_dictionary[gene,position],sample_index_dictionary[sample]] = count

print quantification_array

print quantification_array.shape
print len(samples)
print len(sample_index_dictionary)

np.savetxt("quantities.txt",quantification_array)
np.savetxt("positions.txt", position_header,fmt="%s")
np.savetxt("lw_mw_header.txt", lw_mw_header,fmt="%s")
np.savetxt("sample_header.txt", np.array(samples),fmt="%s")
