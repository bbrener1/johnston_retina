#!/usr/bin/env bash

#SBATCH --array=1-42%10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500

# for i in $(find ../../raw_data/raw_data/*.fastq -type f -printf '%f\n' | head -n 44);
for i in $(find ../../raw_data/raw_data/*.fastq -exec basename {} \;);
# for i in $(find ../../raw_data/weri/*.fastq -exec basename {} \;);
# for i in $(find ../../raw_data/weri/*.fastq -exec basename {} \;);
# for i in $(find ../../quantification/basic/*sorted.bam -exec basename {} \;);
# for i in $(cat ../sample_spec/he_samples.txt);
do
  echo $i
  # bash hisat_string_quant.sh $i ../../quantification/comparison/hisat ../../raw_data/raw_data/;
  # bash kallisto_quant.sh $i ../../quantification/comparison/kallisto ../../raw_data/raw_data/;
  # sbatch bash bowtie_stringtie_quant.sh $i ../../quantification/stringtie ../../raw_data/raw_data/;
  bash bowtie_stringtie_transcriptome_quant.sh $i ../../quantification/basic_4/ ../../raw_data/raw_data/ &
  # bash pileup.sh $i ../../quantification/basic/ &
done


# i=$(find ../../raw_data/raw_data/*.fastq -printf '%f\n' | head -n $SLURM_ARRAY_TASK_ID | tail -n 1)
#
# bash hisat_string_quant.sh $i ../../quantification/comparison/hisat ../../raw_data/;
# # bash kallisto_quant.sh $i ../../quantification/comparison/kallisto ../../raw_data/;
# bash bowtie_stringtie_quant.sh $i ../../quantification/stringtie/ ../../raw_data/raw_data;
# # bash bowtie_stringtie_quant.sh $i ../../quantification/comparison/bowtie_transcriptome ../../raw_data/;

# 	if [ ! -d ../quantification/comparison/$i ]; then
# 	fi
