#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

source activate ../johnston_retina


for i in $(ls ~/scratch/johnston_retina/quantification/hisat/*.sorted.bam);
do
	bedtools genomecov -split -ibam $i -g human_index/hg38.chrom.sizes -bg > $i.bedGraph
done
