import sys
import matplotlib
matplotlib.use('Agg')
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt
import scipy.cluster.hierarchy as hrc

genes_of_interest = np.loadtxt(sys.argv[1],dtype=str)
day_header = np.loadtxt(sys.argv[2])
day_header = day_header.astype(dtype=int)
gene_id_array = np.loadtxt(sys.argv[3],dtype=str)
gene_expression = np.loadtxt(sys.argv[4])
name = sys.argv[5]

day_header = np.delete(day_header,8)
gene_expression = np.delete(gene_expression,8,1)

genes_of_interest = set(map(lambda x: x.upper(),list(genes_of_interest)))

gene_index_array = np.zeros(gene_id_array.shape,dtype=bool)

for i,gene in enumerate(gene_id_array):
    if gene in genes_of_interest:
        gene_index_array[i] = True

important_subarray = gene_expression[gene_index_array]
important_genes = gene_id_array[gene_index_array]

plt.figure("zscored_map")
sns_obj = sns.clustermap(important_subarray,col_cluster=False,z_score=0,cmap='bwr',xticklabels=day_header)
ticks = sns_obj.ax_heatmap.yaxis.get_ticklabels()
sns_obj.ax_heatmap.yaxis.set_ticklabels(np.arange(len(ticks))*(len(important_genes)/len(ticks)))
new_gene_ids = gene_id_array[gene_index_array][sns_obj.dendrogram_row.reordered_ind]

sns_obj.savefig("%s_clustered_genes.png" % name)

np.savetxt("%s_clustered_genes.txt" % name,important_subarray[sns_obj.dendrogram_row.reordered_ind])
np.savetxt("%s_clustered_gene_ids.txt" % name,new_gene_ids,fmt="%s")
