#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=22
#SBATCH --mem-per-cpu=5G
#SBATCH -t 100
#SBATCH -o slurm_job_out2.txt

source activate ./johnston_retina

for i in $(ls ~/data/bbrener1/johnston_retina/weri_raw/);
do
	echo $i
	mkdir ../quantification/weri/$i
	kallisto quant -i gencode_transcript_index.kallisto -b 100 -o ../quantification/weri/$i -l 200  -s 10 --single -t 20 ~/data/bbrener1/johnston_retina/weri_raw/$i;
done

