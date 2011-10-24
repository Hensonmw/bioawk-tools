#
# converts a GFF file to BED format
#

# splitting character is the tab
BEGIN {
    FS = OFS = "\t"
}

# skip  headers
/^#/ {
    next;
}

# transform the output
{
    print $1, $4-1, $5, $3, $6, $7 
}