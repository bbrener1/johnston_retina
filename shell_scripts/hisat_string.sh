#!/usr/bin/env bash


for i in $(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \;);
do
	if [ ! -d ../quantification/hisat_stringtie/$i ]; then
		mkdir ../quantification/hisat_stringtie/$i
		# mkdir ./quantification/hisat/$i/qc
		# time fastqc --outdir ./quantification/hisat/$i/qc ./raw_data/$i

		sbatch hisat_string_quant.sh $i ../quantification/hisat_stringtie ~/data/bbrener1/johnston_retina/raw_data/

	fi
done
