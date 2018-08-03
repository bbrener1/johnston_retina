#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

source activate ../johnston_retina

bowtie2 -mp 9999,9999 -x human_index/hg38/genome -p 21 -U $3/$1 > $2/$1.sam
samtools view -bS $2/$1.sam > $2/$1.bam
samtools sort $2/$1.bam -o $2/$1.sorted.bam
stringtie -G gencode.v27.annotation.gtf -A $2/$1.abundance.tsv $2/$1.sorted.bam
bedtools genomecov -split -ibam $2/$1.sorted.bam -g human_index/hg38.chrom.sizes -bg > $2/$1.bedGraph
LC_COLLATE=C sort -k1,1 -k2,2n $2/$1.bedGraph > $2/$1.sorted.bedGraph
./bedGraphToBigWig $2/$1.sorted.bedGraph ./hg38.chrom.sizes $2/$1.bw
