# johnston_retina

Under shell scripts, 

./bowtie_stringtie_quant.sh 
./hisat_string_quant.sh
./kallisto_quant.sh

All are slurm jobs that take the sample file name as argument 1, the output directory as argument 2, and the raw data directory as argument 3.

They are currently set up to do comparison testing as follows:

Bowtie compares the performance of stringtie quantification when high penalties for mismatch are used vs not

Hisat currently compares performance when multiply-aligned reads are filtered vs not filtered

Kallisto is currently comparing the performance of various kmer settings for indecies

batch_process_comparison is set up to put the output of all scripts under ../quantification/comparison

Certain quick data is available in .txt files under each directory.

The python scripts are mainly set up to process sleuth output and manicure it into good shape.

