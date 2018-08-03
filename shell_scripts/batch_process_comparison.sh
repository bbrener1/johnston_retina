#!/usr/bin/env bash

#SBATCH --array=1-42%10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500

# for i in $(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \;);
# do
# 	if [ ! -d ../quantification/hisat_stringtie/$i ]; then
#
# 		bash hisat_string_quant.sh $i ../quantification/comparison/hisat ~/data/bbrener1/johnston_retina/raw_data/;
#     bash kallisto_quant.sh $i ../quantification/comparison/kallisto ~/data/bbrener1/johnston_retina/raw_data/;
#     bash bowtie_stringtie_quant.sh $i ../quantification/comparison/bowtie ~/data/bbrener1/johnston_retina/raw_data/;
#
# 	fi
# done

i=$(find ~/data/bbrener1/johnston_retina/raw_data/*.fastq -exec basename {} \;) | head -n $SLURM_ARRAY_TASK_ID | tail -n 1)
do
	if [ ! -d ../quantification/hisat_stringtie/$i ]; then

		bash hisat_string_quant.sh $i ../quantification/comparison/hisat ~/data/bbrener1/johnston_retina/raw_data/;
    bash kallisto_quant.sh $i ../quantification/comparison/kallisto ~/data/bbrener1/johnston_retina/raw_data/;
    bash bowtie_stringtie_quant.sh $i ../quantification/comparison/bowtie ~/data/bbrener1/johnston_retina/raw_data/;

	fi
done
