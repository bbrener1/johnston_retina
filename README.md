# johnston_retina

SEQUENCE OF COMMANDS:

(certain boilerplate omitted) 

bash batch_run9.sh

bash process_samples.sh

Rscript sleuth_script.Rscript

python translate_gene_expression_bootstrapped.py gene_expression.tsv 37

python collapse_matrices.py day_header.txt gene_expression_array.txt transcript_expression_array.txt 

bash hisat_batch1.sh

bash hisat_sort_batch.sh

