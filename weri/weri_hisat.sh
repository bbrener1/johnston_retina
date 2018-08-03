#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

source activate ./johnston_retina


for i in $(find ~/data/bbrener1/johnston_retina/weri_raw/*.fastq -exec basename {} \;);
do

	if [ ! -d ../quantification/weri/hisat/$i ]; then
		mkdir ../quantification/weri/hisat/$i
		# mkdir ./quantification/hisat/$i/qc
		# time fastqc --outdir ./quantification/hisat/$i/qc ./raw_data/$i

		hisat2 -q --dta -x human_index/hg38/genome -p 21 -U ~/data/bbrener1/johnston_retina/weri_raw/$i | grep -P "\@|NH:i:1" > ../quantification/weri/hisat/$i.sam
		samtools view -bS ../quantification/weri/hisat/$i.sam > ../quantification/weri/hisat/$i.bam
		samtools sort ../quantification/weri/hisat/$i.bam -o ../quantification/weri/hisat/$i.sorted.bam
		bedtools genomecov -split -ibam ../quantification/weri/hisat/$i.sorted.bam -g human_index/hg38.chrom.sizes -bg > ../quantification/weri/hisat/$i.bedGraph
	fi
done
