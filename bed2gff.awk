#
# converts a BED file to GFF format
#
# usage:
#
# $ awk -f bed2gff.awk input.bed > output.gff
#

BEGIN {
    # splitting character is the tab
    FS = OFS = "\t"
    if (!source) source = "."
    
    print "##gff-version 3"
}

{
    print $1, source, $4, $2 + 1, $3, $5, $6, ".", "."
}
