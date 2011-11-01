profile
=======


Generates profiles from a windowBed output. A profile is a file that contains
the counts of features that are at a certain distance from a reference point

The midpoints are anchors for both features

NOTE: this program assumes that both interval files passed to windowBed were GFF files!

Usage::

    $ windowBed -a reads.gff -b genestart.gff -w 1000 > output.txt
    $ awk -f profile.awk output.txt > profile.txt

Or with paramters::

   $ awk -v window=100 -f profile.awk output.txt > profile.txt

An output relative to gene starts could be:

.. image:: https://github.com/ialbert/bioawk/raw/master/doc/read-density.png

