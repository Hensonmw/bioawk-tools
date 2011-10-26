#
# Reads a sam file and computes the number of overlapping sequence starts 
# across strands if the position on the forward strand is shifted by an amount.
# 
# For a chip-seq experiment this number will be maximized when the shift is 
# equal with the sequenced DNA fragment. Note that this is just an estimate
# but it is a good start.
#
# usage:
#
# $ awk -f chipfrag.awk sorted.sam 
#
# or with paramters:
#
# $ awk -v shift=100 -v max=100000 -f chipfrag.awk sorted.sam
#
# Outputs the shift, the effective shift including the last read lenght and number of matching reads
#
#
# The script should run on a sam file that contains mostly locations
# where binding is expected to occur 
#
BEGIN { 
	FS = OFS = "\t"

	# get maxsize as a power of 10
	if(!pow) pow = 5 
	
	# maximum number of records to process
	# keeps everything in memory!
	if(!max) max = 10^pow;

	# the shift that is to be applied
	if (!shift) shift = 0
}

{
	pos = $4 + shift
	if ( and($2, 16) == 0 ) { 
		# positive strand
		fwd[pos]++
	} else { 
		# negative strand
		rev[$4]++
		
		# give it more opportunities to match
		# when in close by
		rev[$4+1]++
		rev[$4-1]++
	} 

	if (NR > max) {
		exit
	}
}

END {
	# sum up the matching positions
	sum = 0
	for (key in fwd) {
		sum = sum + rev[key]
	}
	# prints the shift, the real shift factoring in 
	# the read lenght (assumes all reads have the same lenght)
	# and the sum of element
	print shift, shift + length($10), sum
}
