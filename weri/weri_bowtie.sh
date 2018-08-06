#!/usr/bin/env bash

#SBATCH --array=1-42%10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500

for i in $(find ../../raw_data/weri/*.fastq -exec basename {} \;);
do
  bash ../shell_scripts/bowtie_stringtie_transcriptome_quant.sh $i ../../quantification/weri/bowtie ../../raw_data/weri/;
  bash ../shell_scripts/transcriptome_pileup.sh $i ../../quantification/weri/bowtie_transcriptome/;
done

# i=$(find ~/data/bbrener1/johnston_retina/weri_raw/*.fastq -printf '%f\n' | head -n $SLURM_ARRAY_TASK_ID | tail -n 1)
#
# bash ../shell_scripts/bowtie_stringtie_transcriptome_quant.sh $i ../../quantification/weri/bowtie ~/data/bbrener1/johnston_retina/weri_raw/;
# bash ../shell_scripts/transcriptome_pileup.sh $i ../../quantification/comparison/bowtie;
