import numpy as np
import matplotlib as plt
import sys

target_dictionary = {}
sample_dictionary = {}
samples = int(sys.argv[2])
targets = []
gene_dictionary = {}
genes = []

day_sample_mapping = {}

input_file = open(sys.argv[1])

output_directory = sys.argv[3]

for i,line in enumerate(input_file):
    if i == 0:
        continue
    (num, target, sample, counts, tpm, eff_len, length, day) = line.split()

    if sample not in sample_dictionary:
        sample_dictionary[sample] = len(sample_dictionary)
        day_sample_mapping[sample] = int(day)

    if target not in target_dictionary:
        target_dictionary[target] = len(targets)
        targets.append([0]*samples)

    gene = target.split("|")[5]
    if gene not in gene_dictionary:
        gene_dictionary[gene] = len(genes)
        genes.append([0]*samples)

    genes[gene_dictionary[gene]][sample_dictionary[sample]] += float(tpm)

    targets[target_dictionary[target]][sample_dictionary[sample]] += float(tpm)


day_header = [0]*len(day_sample_mapping)
sample_header = [""]*len(day_sample_mapping)
for sample in sample_dictionary:
    day_header[sample_dictionary[sample]] = day_sample_mapping[sample]
    sample_header[sample_dictionary[sample]] = sample
day_indecies = np.argsort(day_header)
# print day_header
# print day_indecies
day_header = np.array(day_header)
day_header = day_header[day_indecies]
# print day_header
sample_header = np.array(sample_header)
sample_header = sample_header[day_indecies]
np.savetxt(prefix+"day_header.txt",day_header,fmt="%s")
np.savetxt(prefix+"sample_header.txt",sample_header,fmt="%s")

transcript_expression_array = np.array(targets).T[day_indecies].T
np.savetxt(prefix+"transcript_expression_array.txt", transcript_expression_array)

transcript_id_list = [""]*len(target_dictionary)
for transcript in target_dictionary:
    transcript_id_list[target_dictionary[transcript]] = transcript
np.savetxt(prefix+"transcript_id_array.txt",np.array(transcript_id_list),fmt="%s")

gene_expression_array = np.array(genes).T[day_indecies].T
np.savetxt(prefix+"gene_expression_array.txt",gene_expression_array)

gene_id_list = [""]*len(gene_dictionary)
for gene in gene_dictionary:
    gene_id_list[gene_dictionary[gene]] = gene
np.savetxt(prefix+"gene_id_array.txt",np.array(gene_id_list),fmt="%s")
