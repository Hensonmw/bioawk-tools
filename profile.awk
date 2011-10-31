#
# Generates profiles from a windowBed output. A profile is a file that contains
# the counts of features that are at a certain distance from a reference point
#
# The midpoints are anchors for both features
#
# NOTE: this program assumes that both interval files passed
# to windowBed were GFF files!
#
# usage:
#
# $ windowBed -a reads.gff -b genestart.gff -w 1000 > output.txt
#
# $ awk -f profile.awk output.txt > profile.txt
#
# with parameters:
#
# $ awk -v window=100 -f profile.awk output.txt > profile.txt
#
BEGIN {
	
    # the width of the moving window for the average
    if (!window) window = 20;	
        
    # the range to compute the differences over
    if (!range) range = 1000
    
    # initialize profile to zero
    for (pos = -range; pos < range; pos++) {
        values[pos] = 0
    }
    
    # input and output field separators
    FS = OFS = "\t"
}

# within the body of the file we collect the values
{
    # start, end, midpoint for left side
    s1 = $4;  e1 = $5; m1 = int((s1 + e1)/2)
    
    # start, end, midpoint for the right side
    s2 = $13; e2 = $14; m2 = int((s2 + e2)/2)
    
    # compute the difference between midpoints
    pos = m1 - m2
    
    # increment the array at that position
    values[pos]++   
}

# print the summary at the end
END {
    
    # output the headers of the file
    print "pos", "value"
    
    # we use this value often so precompute the half window size
    half  = int(window / 2)
    
    # generate a value for each position in the range
    for (pos = -range; pos < range - window; pos++) {
        
        # average with a moving window 
        value = 0
        for (shift=0; shift < window; shift++) {
            
            # this is the current position
            curpos = pos + shift
            
            # sum up values at the current position with the rest
            value  = value + values[curpos]
            
        }
        
        # write only positions that have a value
        if (value>0) {
            # output the center of the window
            print pos + half, value
        }
        
    }
}
