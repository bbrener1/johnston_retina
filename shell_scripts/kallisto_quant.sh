#!/usr/bin/env bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=5G
#SBATCH -t 500
#SBATCH -o slurm_job_out2.txt

source activate ../johnston_retina

if [ ! -d $2/$1.kallisto ]; then
  mkdir $2/$1.kallisto;
fi
rm -r $2/$1.kallisto/*
mkdir $2/$1.kallisto/35;
mkdir $2/$1.kallisto/25;
mkdir $2/$1.kallisto/15;

kallisto quant -i ../gencode_kallisto_index/35mer_index.kallisto -b 100 -o $2/$1.kallisto/35 -l 200 -s 10 --single -t 23 $3/$1
kallisto quant -i ../gencode_kallisto_index/25mer_index.kallisto -b 100 -o $2/$1.kallisto/25 -l 200 -s 10 --single -t 23 $3/$1
kallisto quant -i ../gencode_kallisto_index/15mer_index.kallisto -b 100 -o $2/$1.kallisto/15 -l 200 -s 10 --single -t 23 $3/$1

kallisto pseudo -i ../gencode_kallisto_index/35mer_index.kallisto -o $2/$1.kallisto/35 -l 200 -s 10 --single -t 23 $3/$1
kallisto pseudo -i ../gencode_kallisto_index/25mer_index.kallisto -o $2/$1.kallisto/25 -l 200 -s 10 --single -t 23 $3/$1
kallisto pseudo -i ../gencode_kallisto_index/15mer_index.kallisto -o $2/$1.kallisto/15 -l 200 -s 10 --single -t 23 $3/$1

echo "35mer" > $2/$1.kallisto/cmp_abundance.txt
cat $2/$1.kallisto/35/abundance.tsv | grep OPN1LW >> $2/$1.kallisto/cmp_abundance.txt
cat $2/$1.kallisto/35/abundance.tsv | grep OPN1MW >> $2/$1.kallisto/cmp_abundance.txt
echo "25mer" >> $2/$1.kallisto/cmp_abundance.txt
cat $2/$1.kallisto/25/abundance.tsv | grep OPN1LW >> $2/$1.kallisto/cmp_abundance.txt
cat $2/$1.kallisto/25/abundance.tsv | grep OPN1MW >> $2/$1.kallisto/cmp_abundance.txt
echo "15mer" >> $2/$1.kallisto/cmp_abundance.txt
cat $2/$1.kallisto/15/abundance.tsv | grep OPN1LW >> $2/$1.kallisto/cmp_abundance.txt
cat $2/$1.kallisto/15/abundance.tsv | grep OPN1MW >> $2/$1.kallisto/cmp_abundance.txt

echo "35mer" > $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199094 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199095 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199096 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199098 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199099 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199100 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199102 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199103 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199104 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/35/pseudoalignments.tsv | grep 199106 >> >> $2/$1.kallisto/ec_quick_look.txt

echo "25mer" >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199094 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199095 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199096 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199098 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199099 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199100 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199102 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199103 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199104 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/25/pseudoalignments.tsv | grep 199106 >> >> $2/$1.kallisto/ec_quick_look.txt

echo "15mer" >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199094 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199095 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199096 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199098 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199099 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199100 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199102 >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199103 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199104 >> >> $2/$1.kallisto/ec_quick_look.txt
cat $2/$1.kallisto/15/pseudoalignments.tsv | grep 199106 >> >> $2/$1.kallisto/ec_quick_look.txt
