import numpy as np
import sys

header = np.loadtxt(sys.argv[1])
gene_matrix = np.loadtxt(sys.argv[2])
transcript_matrix = np.loadtxt(sys.argv[3])

days = list(set(header))
days.sort()

collapsed_genes = np.zeros((gene_matrix.shape[0],len(days)))
collapsed_gene_stds = np.zeros((gene_matrix.shape[0],len(days)))
collapsed_transcripts = np.zeros((transcript_matrix.shape[0],len(days)))
collapsed_transcript_stds = np.zeros((transcript_matrix.shape[0],len(days)))

for i,day in enumerate(days):
    indecies = np.zeros(gene_matrix.shape[1],dtype=bool)
    for j,marker in enumerate(header):
        if marker == day:
            indecies[j] = True
    print indecies
    gene_day_column = np.mean(gene_matrix.T[indecies].T,axis=1)
    gene_day_std = np.std(gene_matrix.T[indecies].T,axis=1)
    transcript_day_column = np.mean(transcript_matrix.T[indecies].T,axis=1)
    transcript_day_std = np.std(transcript_matrix.T[indecies].T,axis=1)
    collapsed_genes[:,i] = gene_day_column
    collapsed_gene_stds[:,i] = gene_day_std
    collapsed_transcripts[:,i] = transcript_day_column
    collapsed_transcripts[:,i] = transcript_day_std

np.savetxt("collapsed_header.txt", np.array(days,dtype=int))
np.savetxt("collapsed_gene_expression.txt", collapsed_genes)
np.savetxt("collapsed_transcript_expression.txt",collapsed_transcripts)
np.savetxt("collapsed_gene_expression_stds.txt",collapsed_gene_stds)
np.savetxt("collapsed_transcript_expression_stds.txt",collapsed_transcript_stds)
