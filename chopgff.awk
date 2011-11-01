# chopgff
# 
# Generates a one base long interval around either the start or the end of
# each feature in the GFF or BED file. The start/end locations are strand aware and
# represent the 5' and 3' location of the single stranded DNA represented
# by the feature.
#
# Think of it as the opposite of the strand aware `slopBed` tool does in `bedtools` package
#
# Usage (default is to anchor at start 5' coordinates)::
#
#    $ awk -f chopgff.awk data.gff > start.gff
#
# Or with parameters (3' end)::
#
#    $ awk -v format=bed -v anchor=end -f chopgff.awk data.bed > ends.bed
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
        
        # BED format
        if ($6 == "+") {
            # forward strand
            if (anchor=="start") {
                $3 = $2 + 1
            } else {
                $2 = $3 - 1
            }
        } else {
            # reverse strand
            if (anchor=="start") {
                $2 = $3 - 1
            } else {
                $3 = $2 + 1
            }
        }

        print $1, $2, $3, $4, $5, $6
        
    } else {
        
        # GFF format
        if ($7 == "+" ) {
            # forward strand
            if (anchor=="start") {
                $5 = $4
            } else {
                $4 = $5
            }
    
        } else {
            # reverse strand
            if (anchor=="start") {
                $4 = $5
            } else {
                $5 = $4
            }
        }
        print $1, $2, $3, $4, $5, $6, $7, $8, $9
    }
    
}

