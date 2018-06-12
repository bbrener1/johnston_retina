import sys
import matplotlib
matplotlib.use('Agg')
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt
import scipy.cluster.hierarchy as hrc

go_genes = open(sys.argv[1]).readlines()
lrt_tests = open(sys.argv[2])
limit = int(sys.argv[3])
name = sys.argv[4]

gene_set = set(map(lambda x: x.strip().upper(),go_genes))

print gene_set

filtered_lines = []
filtered_genes = []


for i,line in enumerate(lrt_tests):
    if i == 0:
        continue
    if i > limit:
        break
    target_id = line.split()[1]
    if target_id.split("|")[5].upper() in gene_set:
        filtered_lines.append(line)
        filtered_genes.append(target_id.split("|")[5])

np.savetxt("%s_filtered_tests.txt" % name, np.array(filtered_lines),fmt="%s")
np.savetxt("%s_filtered_genes.txt" % name, np.array(filtered_genes),fmt="%s")

