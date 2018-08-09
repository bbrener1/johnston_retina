#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

#source activate ../johnston_retina

# bowtie2 --mp 9999,9998 -x ../gencode_transcriptome/gencode_bowtie_index -p 21 -U $3/$1 > $2/$1.strict.sam
# bowtie2 -x ../gencode_transcriptome/gencode_bowtie_index -p 21 -U $3/$1 > $2/$1.sam
bowtie2 --mp 9999,9998 -x ../gencode_transcriptome/gencode_bowtie_index -p 21 --interleaved $3/$1 > $2/$1.strict.sam
bowtie2 -x ../gencode_transcriptome/gencode_bowtie_index -p 21 --interleaved $3/$1 > $2/$1.sam
samtools view -bS $2/$1.strict.sam > $2/$1.strict.bam
samtools view -bS $2/$1.sam > $2/$1.bam
samtools sort $2/$1.strict.bam -o $2/$1.strict.sorted.bam
samtools sort $2/$1.bam -o $2/$1.sorted.bam

bash ./transcriptome_pileup.sh $1 $2
