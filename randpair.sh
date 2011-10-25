#
# Selects random pairs from two fastq files
#
# usage:
#
# $ randpair 50 file1.fq file2.fq
#
# selects 50 pairs from file1.fq and file2.fq and writes them to file1.fq.1 and file2.fq.2
#
# by Pierre Lindenbaum in http://biostar.stackexchange.com/questions/6567/selecting-random-pairs-from-fastq
# 
count=$1
name1=$2
name2=$3

paste $name1 $name2 |\
awk '{ printf("%s",$0); n++; if(n%4==0) { printf("\n");} else { printf("\t\t");} }' |\
shuf |\
head -${count} |\
sed 's/\t\t/\n/g' |\
awk -v name1=${name1}.1 -v name2=${name2}.2 '{ print $1 > name1; print $2 > name2 }'
