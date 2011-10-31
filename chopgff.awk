#
# Generates one based intervals for starts/end for features starts/ends stored
# in a BED or GFF file
#
# usage:
#
# $ awk -f chopbed.awk data.bed > start.bed
#
# with parameters:
#
# $ awk -v format=gff -v anchor=end data.gff > ends.gff
#
#  (the opposite of the the slopBed tool does in bedtools package)
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

