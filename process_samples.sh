# echo "" > samples.txt
# echo "" > paths.txt
#
# for i in $(find ../quantification/added_days/* -type d );
# do
# 	echo "$i/abundance.h5" >> paths.txt
# 	basename $i _R1_001.fastq >> samples.txt
# done
#
# cat samples.txt | grep -oP ".*-D?\K(\d+)" > days.txt
#
#
