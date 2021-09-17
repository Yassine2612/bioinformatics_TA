
mOTUs Parameters
================

Output Parameters
^^^^^^^^^^^^^^^^^

There are number of optional parameters that can be provided to **profile** to modify the output format, but not the actual mOTUs algorithm.

.. code-block:: bash

      -I FILE         save the result of bwa in bam format (intermediate step) [None]
      -M FILE         save the mgc reads count (intermediate step) [None]
      -e              profile only reference species (ref_mOTUs)
      -c              print result as counts instead of relative abundances
      -p              print NCBI id
      -u              print the full name of the species
      -q              print the full rank taxonomy
      -B              print result in BIOM format
      -C STR          print result in CAMI format (BioBoxes format 0.9.1)
                      Values: [precision, recall, parenthesis]
      -k STR          taxonomic level [mOTU]
                      Values: [kingdom, phylum, class, order, family, genus, mOTU]

We can for instance modify our output to see counts, rather than relative abundances, and move our analysis to the family level, only allowing reference species:

.. code-block:: bash

   motus profile -f <forward reads> -r <reverse reads> -o <output file> -t 12 -e -c -k family

The output looks something like this:

.. code-block:: bash

   #consensus_taxonomy     M01.1-V1-stool-metaG
   Nitrososphaeraceae      0
   Oscillochloridaceae     0
   ...
   Micrococcaceae  0
   Erysipelotrichaceae     38
   Streptococcaceae        13
   candidatus Midichloriaceae      0
   ...
   candidatus Poribacteria fam. incertae sedis     0
   candidatus Saccharibacteria fam. incertae sedis 0
   -1      11415

Algorithm Parameters
^^^^^^^^^^^^^^^^^^^^

There are also a number of parameters that modify the operation of the mOTUs algorithm.

.. code-block:: bash

      -g INT          number of marker genes cutoff: 1=higher recall, 10=higher precision [3]
      -l INT          min. length of alignment for the reads (number of nucleotides) [75]
      -t INT          number of threads [1]
      -v INT          verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]
      -y STR          type of read counts [insert.scaled_counts]
                      Values: [base.coverage, insert.raw_counts, insert.scaled_counts]

The result with **highest sensitivity** is obtained with ``-g 1 -l 30 -y base.coverage``\ , allowing to detect low abundance bugs (at the cost of having more false positives).

The result with **highest precision** is obtained with ``-g 6 -l 75 -y insert.scaled_counts``\ , reducing the false positives to the minimum.

----

We will now produce two additional outputs for later comparison with the default output of **profile**. Run the same set of data as you chose initially, but with highest sensitivity, then highest precision parameters. Then merge these two with the default set of data to make one .motu file.
