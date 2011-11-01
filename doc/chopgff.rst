chopgff
========

Generates a one base long interval around either the start or the end of
each feature in the GFF or BED file. The start/end locations are strand aware and
represent the 5' and 3' location of the single stranded DNA represented
by the feature.

Think of it as the opposite of the strand aware `slopBed` tool does in `bedtools` package

Usage (default is to anchor at start 5' coordinates)::

    $ awk -f chopgff.awk data.gff > start.gff

Or with parameters (3' end)::

    $ awk -v format=bed -v anchor=end -f chopgff.awk data.bed > ends.bed

