#!/usr/bin/env python

import sys
import numpy as np
import matplotlib.pyplot as plt


samples = map(lambda x: x.strip(),open(sys.argv[1]).readlines())
paths = (lambda x: x.strip(),open(sys.argv[2]).readlines())
srr_gsm_key = map(lambda x: x.strip(), open(sys.argv[3]).readlines())
gsm_key = map(lambda x: x.strip() ,open(sys.argv[4]).readlines())

prefix = sys.argv[6]

srr_gsm_key = {x.split()[0]:x.split()[1] for x in srr_gsm_key}

gsm_key = {x.split()[0]:(x.split()[1],int(x.split()[2])) for x in gsm_key}

sample_day_map = {x:gsm_key[x][1] for x in samples}

sample_index_dictionary = {x:y for (x,y) in zip(samples,range(len(samples)))}

days = map(lambda x: sample_day_map[x], samples)

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

np.savetxt(prefix + "quantities.txt",quantification_array)
np.savetxt(prefix + "positions.txt", position_header,fmt="%s")
np.savetxt(prefix + "lw_mw_header.txt", lw_mw_header,fmt="%s")
np.savetxt(prefix + "sample_header.txt", np.array(map(lambda x: gsm_key[srr_gsm_key[x]][0], samples)),fmt="%s")

day_sort = np.argsort(np.array(days))

np.savetxt(prefix + "quantities_sorted.txt", quantification_array.T[day_sort].T)
np.savetxt(prefix + "sample_header_sorted.txt", np.array(map(lambda x: gsm_key[srr_gsm_key[x]][0], samples))[day_sort],fmt="%s")
np.savetxt(prefix + "day_header_sorted.txt", np.array(days)[day_sort],fmt="%s")
