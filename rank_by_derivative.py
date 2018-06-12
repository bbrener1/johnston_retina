import numpy as np
import sys

header = np.loadtxt(sys.argv[1])
header = header.astype(dtype=int)
gene_id_array = np.loadtxt(sys.argv[2],dtype=str)
transcript_id_array = np.loadtxt(sys.argv[3],dtype=str)
gene_matrix = np.loadtxt(sys.argv[4])
transcript_matrix = np.loadtxt(sys.argv[5])

gene_derivative = np.zeros((gene_matrix.shape[0],gene_matrix.shape[1]-1))
transcript_derivative = np.zeros((transcript_matrix.shape[0],transcript_matrix.shape[1]-1))

for i in range(gene_matrix.shape[1]-1):

    gene_change = (gene_matrix[:,i+1] - gene_matrix[:,i] + .01) / (gene_matrix[:,i] + .01)
    gene_derivative[:,i] = gene_change
    transcript_change = (transcript_matrix[:,i+1] - transcript_matrix[:,i] + .01) / (transcript_matrix[:,i] + .01)
    transcript_derivative[:,i] = transcript_change

    gene_sorting_indecies = np.argsort(gene_change)
    sorted_gene_ids = gene_id_array[gene_sorting_indecies]
    sorted_gene_changes = gene_change[gene_sorting_indecies]
    sorted_genes_before = gene_matrix[:,i][gene_sorting_indecies]
    sorted_genes_after = gene_matrix[:,i+1][gene_sorting_indecies]

    day_gene_change = open("%i_gene_fold_change.txt" % header[i],mode='w')

    transcript_sorting_indecies = np.argsort(transcript_change)
    sorted_transcript_ids = transcript_id_array[transcript_sorting_indecies]
    sorted_transcript_changes = transcript_change[transcript_sorting_indecies]
    sorted_transcripts_before = transcript_matrix[:,i][transcript_sorting_indecies]
    sorted_transcripts_after = transcript_matrix[:,i+1][transcript_sorting_indecies]

    day_transcript_change = open("%i_transcript_fold_change.txt" % header[i],mode='w')

    for i in range(len(gene_sorting_indecies)):
        day_gene_change.write(("\t".join(map(lambda x: str(x),[sorted_gene_ids[i],sorted_genes_before[i],sorted_genes_after[i],sorted_gene_changes[i]])) + "\n"))


    for i in range(len(transcript_sorting_indecies)):
        day_transcript_change.write("\t".join(map(lambda x: str(x),[sorted_transcript_ids[i],sorted_transcripts_before[i],sorted_transcripts_after[i],sorted_transcript_changes[i]])) + "\n")

    

np.savetxt("gene_derivatives.txt",gene_derivative)
np.savetxt("transcript_derivatives",transcript_derivative)

