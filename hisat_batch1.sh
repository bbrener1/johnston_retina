#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

source activate ./johnston_retina


for i in $(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \;);
do

	if [ ! -d ../quantification/hisat/$i ]; then
#		mkdir ../quantification/hisat/
#		mkdir ./quantification/hisat/$i/qc
#		time fastqc --outdir ./quantification/hisat/$i/qc ./raw_data/$i

#		hisat2 -q -x human_index/hg38/genome -p 21 -U ~/data/bbrener1/johnston_retina/raw_data/$i > ../quantification/hisat/$i.sam
#		samtools view -bS ../quantification/hisat/$i.sam > ../quantification/hisat/$i.bam
#		samtools sort ../quantification/hisat/$i.bam -o ../quantification/hisat/$i.sorted.bam
		bedtools genomecov -split -ibam ../quantification/hisat/$i.sorted.bam -g human_index/hg38.chrom.sizes -bg > ../quantification/hisat/$i.bedGraph 
	fi
done
