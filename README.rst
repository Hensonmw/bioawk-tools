BioAwk
======

Awk based utility scripts for bioinformatics.

Consult the source of each script for documentation (usage, parameters etc).

.. tip: adding the source directory as the value of the AWKPATH variable allows you 
   to run each program file without having to list the full path to it

SAM
---

  * sam2wig.awk - converts the samtools pileup format to wiggle
  
Interval
--------

  * gff2bed.awk - converts GFF to BED format
  * bed2gff.awk - converts BED to GFF
  
Fasta
-----

  * splitfasta.awk - splits a fasta file into smaller files