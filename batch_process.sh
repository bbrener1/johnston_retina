#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=22
#SBATCH --mem-per-cpu=5G
#SBATCH -t 100
#SBATCH -o slurm_job_out2.txt

source activate ./johnston_retina

samples=$(cat $1)
days=$(cat $2)
sample_paths=$(cat $3)
index="gencode_transcript_index.kallisto"
bootstraps=100

outdir=$4

for i in $(seq 1 ${#ArrayName[@]});
do
	indir=sample_paths[$i]
	sample=samples[$i]
	echo $sample
	if [ ! -d $outdir/$sample ]; then
		mkdir $outdir/$sample
#		mkdir outdir/$sample/qc
#		time fastqc --outdir outdir/$sample/qc sample_paths[$i]

		kallisto quant -i $index -b $bootstraps -o $outdir/$sample/ -l 20  -s 10 --single -t 20 $(sample_paths[$i])
	fi
done

RScript ./sleuth_script.Rscript

mkdir $outdir/arrays/

python ./translate_gene_exp_bootstrapped.py ${#ArrayName[@]} $outdir/arrays/

python ./collapse_matries $outdir/arrays/day_header.txt $outdir/arrays/gene_expression_array.txt $outdir/arrays/transcript_expression_array.txt

# for i in $(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \; | tail -n 22);
