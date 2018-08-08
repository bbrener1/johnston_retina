#!/usr/bin/env python

import sys

samples = open(sys.argv[1]).readlines()
days = open(sys.argv[2]).readlines()
paths = open(sys.argv[3]).readlines()

lw_positions = map(lambda x: x.split()[0],open(sys.argv[4]).readlines()))
mw_positions = map(lambda x: x.split()[0],open(sys.argv[4]).readlines()))

print lw_positions
print mw_positions

days = map(lambda x: int(x),days)
set_days = set(days)

for sample,day,path in zip(samples,days,paths):
    print str((sample,day,path))
    sample_pile = open(path)
