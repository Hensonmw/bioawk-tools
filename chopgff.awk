#
# Generates one based intervals for starts/end for features starts/ends stored
# in a BED or GFF file
#
# The opposite of the the slopBed tool does in bedtools package.
#
# usage:
#
# $ awk -f chopgff.awk data.gff > start.gff
#
# with parameters:
#
# $ awk -v format=bed -v anchor=end -f chopgff.awk data.bed > ends.bed
#
BEGIN {
	# the format of the file bed or gff
	if (!format) format="gff";
	
	# the location of the anchor point
	if (!anchor) anchor = "start";	
           
        FS = OFS = "\t"
}

# matches comments and GFF headers
/^#/ {
    print $0
    next
}

{
    if (format=="bed") {
        
        if (anchor=="start") {
            $3 = $2 + 1
        } else {
            $2 = $3 - 1
        }
        print $1, $2, $3, $4, $5, $6
        
    } else {
        
        if (anchor=="start") {
            $5 = $4
        } else {
            $4 = $5
        }
        
        print $1, $2, $3, $4, $5, $6, $7, $8, $9
    }
    
}

