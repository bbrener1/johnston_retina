#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

module load bwa
source activate ./johnston_retina


for i in $(find ~/data/bbrener1/johnston_retina/weri_raw/*.fastq -exec basename {} \;);
do

	if [ ! -d ../quantification/weri/bwa/$i ]; then
		mkdir ../quantification/weri/bwa/$i
		# mkdir ./quantification/hisat/$i/qc
		# time fastqc --outdir ./quantification/hisat/$i/qc ./raw_data/$i

		bwa aln -n 0 -t 21 chrX.fa ~/data/bbrener1/johnston_retina/weri_raw/$i > ../quantification/weri/bwa/$i.sai
		bwa samse chrX.fa ../quantification/weri/bwa/$i.sai ~/data/bbrener1/johnston_retina/weri_raw/$i | samtools view -hF 0x04 | grep -v XA> ../quantification/weri/bwa/$i.sam
		samtools view -bS ../quantification/weri/bwa/$i.sam > ../quantification/weri/bwa/$i.bam
		samtools sort ../quantification/weri/bwa/$i.bam -o ../quantification/weri/bwa/$i.sorted.bam
		bedtools genomecov -split -ibam ../quantification/weri/bwa/$i.sorted.bam -g human_index/hg38.chrom.sizes -bg > ../quantification/weri/bwa/$i.bedGraph
	fi
done

# | grep -P "\@|chrX\t15[3,4][0-9]{6}"

