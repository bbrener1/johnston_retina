#!/usr/bin/env bash


for i in $(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \;);
do
	if [ ! -d ../quantification/hisat_stringtie/$i ]; then

		sbatch hisat_string_quant.sh $i ../quantification/comparison/hisat ~/data/bbrener1/johnston_retina/raw_data/
    sbatch kallisto_quant.sh $i ../quantification/comparison/kallisto ~/data/bbrener1/johnston_retina/raw_data/
    sbatch bowtie_stringtie_quant.sh $i ../quantification/comparison/bowtie ~/data/bbrener1/johnston_retina/raw_data/

	fi
done
