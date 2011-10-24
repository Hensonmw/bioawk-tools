#
# Splits a FASTA files into more files with fewer sequences per file
# 
# usage:
#
# awk -f splitfasta.awk data.fasta
#
# using parameters:
#
# awk -v N=10000 -f splitfasta.awk data.fasta
# awk -v N=10000 -v prefix=myseg -f splitfasta.awk data.fasta
# awk -v N=10000 -v prefix=myseg -v suffix=fasta -f splitfasta.awk data.fasta
#
# adapted from: http://biostar.stackexchange.com/questions/13298/how-to-split-one-big-sequence-file-into-multiple-files-with-less-than-1000-sequen
#  
BEGIN {
	# the number of sequences per file
	if (!N) N=10000;
	
	# file prefix
	if (!prefix) prefix = "seq";	
	
	# file suffix
	if (!suffix) suffix = "fa";
	# this keeps track of the sequences
	count = 0
}

# act on fasta header
/^>/ {
	if (count % N == 0) {
		if (output) close(output)
		output = sprintf("%s%07d.%s", prefix, count, suffix)		
	}
	print > output
	count ++
	next
}

# write the fasta body into the file
{
	print >> output
}