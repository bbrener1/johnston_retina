#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500

source activate ../johnston_retina

samtools mpileup -l ../unique_loci.txt -f ../hisat_index/GRCh38.primary_assembly $2/$1.sam > $2/$1.pile
