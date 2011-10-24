# 
# Converts samtools mpileup output to wiggle format.
#
# usage 
#
# $ samtools mpileup data.bam > data.pileup
# $ awk -f sam2wig.awk data.pileup > data.wig
#
# parameters:
#
# awk -v mincov=5 -f sam2wig.awk data.pileup > data.wig
# awk -v mincov=5 -v name=Genes -f sam2wig.awk data.pileup > data.wig
#
BEGIN {
	# minimun coverage
	if (!mincov) mincov=5;
	
	# set the name
	if (!name) name = "name"
	
	# set the description
	if (!desc) desc = "description"
	
	# generate the wiggle header
	printf("track type=wiggle_0 name=%s description=%s\n", name, desc)
	
	# this will maintain the last seen chromosome
	chrom="" 	
}

# process the body of the pileup file
{
	# switch chromosome
	if ($1 != chrom) {
		printf("variableStep chrom=%s\n", $1)
		chrom = $1
	}

	# check for minimum coverage
	if ($4 >= mincov) {
		printf("%s\t%s\n", $2, $4)
	}

}
