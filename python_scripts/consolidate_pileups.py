#!/usr/bin/env python

import sys

samples = open(sys.argv[1]).readlines()
days = open(sys.argv[2]).readlines()
paths = open(sys.argv[3]).readlines()

for sample,day,path in zip(samples,days,paths):
    print str(sample,day,path)
