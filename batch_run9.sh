#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=22
#SBATCH --mem-per-cpu=5G
#SBATCH -t 100
#SBATCH -o slurm_job_out2.txt

source activate ./johnston_retina


for i in $(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \; | tail -n 22);
do
	
	if [ ! -d ../quantification/added_days/$i ]; then
		mkdir ../quantification/added_days/$i
#		mkdir ./quantification/$i/qc
#		time fastqc --outdir ./quantification/$i/qc ./raw_data/$i

		kallisto quant -i gencode_transcript_index.kallisto -b 100 -o ../quantification/added_days/$i -l 200 -s 10 --single -t 20 ~/data/bbrener1/johnston_retina/raw_data/$i
	fi
done
