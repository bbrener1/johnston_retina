#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out.txt

source activate ./johnston_retina


for i in $(find ./raw_data/*.fastq -exec basename {} \;);
do
#	mkdir ./quantification/$i
#	mkdir ./quantification/$i/qc
#	time fastqc --outdir ./quantification/$i/qc ./raw_data/$i

	kallisto quant -i gencode_transcript_index.kallisto -b 20 -o ./quantification/hd5b/$i -l 200 -s 10 --single -t 20 ./raw_data/$i
done
