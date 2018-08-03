#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500

source activate ../johnston_retina

hisat2 -q --dta -x human_index/hg38/genome -p 21 -U $3/$1 > $2/$1.sam
cat $2/$1.sam | grep -P "\@|NH:i:1" > $2/$1.filtered.sam
samtools view -bS $2/$1.sam > $2/$1.bam
samtools view -bS $2/$1.filtered.sam > $2/$1.filtered.bam
samtools sort $2/$1.bam -o $2/$1.sorted.bam
samtools sort $2/$1.filtered.bam -o $2/$1.filtered.sorted.bam
stringtie -G gencode.v27.annotation.gtf -A $2/$1.abundance.tsv $2/$1.sorted.bam
stringtie -G gencode.v27.annotation.gtf -A $2/$1.filtered.abundance.tsv $2/$1.filtered.sorted.bam

echo "Unfiltered:" > $2/$1.filter_compare.txt
cat $2/$1.abundance.tsv | grep OPN1LW >> $2/$1.filter_compare.txt
cat $2/$1.abundance.tsv | grep OPN1MW >> $2/$1.filter_compare.txt
echo "Filtered:" >> $2/$1.filter_compare.txt
cat $2/$1.filtered.abundance.tsv | grep OPN1LW >> $2/$1.filter_compare.txt
cat $2/$1.filtered.abundance.tsv | grep OPN1MW >> $2/$1.filter_compare.txt

# bedtools genomecov -split -ibam $2/$1.sorted.bam -g human_index/hg38.chrom.sizes -bg > $2/$1.bedGraph
