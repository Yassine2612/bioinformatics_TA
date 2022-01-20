Alignment
=========

General information
-------------------

Main objective
^^^^^^^^^^^^^^

In this lecture we will introduce the concept of sequence alignment. We will show you how to use BLAST via the web-based interface from the NCBI and via the command line.

Learning objectives
^^^^^^^^^^^^^^^^^^^

* Students understand the aim of sequence alignment
* Students can use BLAST via the NCBI's web interface
* Students can use BLAST on the command line and with a custom database
* Students are able to choose the correct variety of BLAST for the required task

Requirements
^^^^^^^^^^^^

Laptop with access to the ETHZ network, via VPN if necessary

Sequence alignment
------------------

The aim of sequence alignment is to determine how similar two sequences are, or perhaps more importantly to identify the sequences from a database that are most similar to a query sequence. There are two sorts of pairwise alignment you may encounter, although hybrid methods also exist:

* Global alignment attempts to align every residue (a nucleotide sequence base or a protein sequence amino acid) between the query and subject sequences
* Local alignment looks for regions of alignment between the query and subject sequences

We will not go into the details of scoring algorithms here, but if you are interested you might consider attending the Bioinformatics Concept Course. Instead we will describe the summary of that scoring algorithm that you most often see for any pairwise alignment:

* Length or Coverage: the length of an alignment in base pairs or the percentage of the query sequence covered by the alignment
* Identity: the percentage identity of the alignment, i.e.: how many base pairs are identical
* E-value: the likelihood of the alignment being seen by chance; this is dependent on the database size searched

Exactly which of these you consider most important depends on the use of the alignment but you should definitely consider them all when interpreting your results.

BLAST
-----

BLAST, or the **B**\asic **L**\ocal **A**\lignment **S**\earch **T**\ool (**BLAST**), is the most commonly used aligner and is maintained by the NCBI. Most researchers are familiar with the web-based interface found `here <https://blast.ncbi.nlm.nih.gov/Blast.cgi>`_.

.. thumbnail:: images/blast.png
    :align: center

The four main varieties of BLAST are neatly summarised on this frontpage.

* blastn: nucleotide blast for comparing DNA sequences (left)
* blastx: searching a protein database for a translated nucleotide query (middle top)
* tblastn: searching a translated nucleotide database for a protein query (middle bottom)
* blastp: protein blast for comparing protein sequences (right)

You should therefore choose your BLAST algorithm based on the nature, nucleotide or protein, of your query and your database.

Setup
^^^^^

At this point we will proceed to use Nucleotide BLAST (blastn). The setup page for a search looks like so:

.. thumbnail:: images/BLASTn.png
    :align: center

Let's briefly look at some of the parts of this page:

1. Enter Query Sequence (black)  
 1. This is the search box where you can put your query, either by pasting in a sequence or using one of the NCBI's sequence indexing systems: accession number or gi.
 2. Instead you can upload a fasta formatted file from your local  1.3. If you want to restrict the search to a subset of the query sequence you can give start and end coordinates here
 3. If you want to restrict the search to a subset of the query sequence you can give start and end coordinates here
 4. If you tick this box, the entire section 'Choose Search Set' below is replaced with a second query section that behaves as the first

2. Choose Search Set (red)
 1. This is where you can choose which NCBI database to search. Typically you will want to choose nr/nt to search Genbank protein/nucleotide sequences respectively, however you may want to restrict your search to RefSeq or another specific database.
 2. Here you can enter a specific organism or taxonomic name to restrict your search; it will helpfully auto-complete.
 3. If you want to use the NCBI Entrez system to restrict your search you can enter it here.

3. Program Selection (blue)
 1. The three options here are self-explanatory. You will typically want to use the default, megablast, but if that fails you may want to use a slower but broader search algorithm.

4. Below (pink)
 1. The big BLAST button will begin your search
 2. This is where you can modify the algorithm used in the search - for now you are ok to ignore this.

Results
^^^^^^^

The results page has a summary of the search performed at the top (left), with the option to further filter the results (right).

.. thumbnail:: images/blastres0.png
    :align: center

The first tab in the results section is Description. Here you can see the names of the hits, their scoring statistics as described above and a link to the GenBank entry for the sequence. You can sort hits by any of the data columns if you want to specifically find the longest or most identical hit, for instance, where the default is by e-value.

.. thumbnail:: images/blastres1.png
    :align: center

The second tab gives a graphical summary of the hits found. It depicts the quality of the alignment across the length of the query sequence with a colour code for alignment quality.

.. thumbnail:: images/blastres2.png

The third tab shows you the precise alignment found by the algorithm. The query and subject sequences are shown beside one another, with vertical pipe symbols "|" representing identity.

.. thumbnail:: images/blastres3.png

The fourth and final tab gives you a taxonomy of the organisms found in the hits and how many hits were found at each taxonomic level.

.. thumbnail:: images/blastres4.png

.. admonition:: Exercises
    :class: exercise

    * Perform a nucleotide BLAST search for sequence found in the file mystery_sequence_01.fasta
    * Based on the results, what do you think the sequence is?

BLAST on the command line
-------------------------

The various BLAST programs are also available for download to run yourself. The BLAST+ suite is installed on our R Workbench server and Euler. There are several reasons you might want to run BLAST offline:

* You may have a large number of searches you want to perform, which is clumsy via the web interface
* You have sensitive data you want to search for or with that you shouldn't submit online
* You want to perform BLAST searches as part of a larger program or software pipeline

Making a BLAST database
^^^^^^^^^^^^^^^^^^^^^^^

In order to run a search offline, you need a database to search. You can download one of the NCBI databases if you have the storage space, but hopefully your friendly local bioinformatician has already done that for you - and indeed we have made the RefSeq Prokaryotic Reference Genome database available here:

.. code-block:: bash

    /nfs/modules/databases/NCBI/ref_prok_rep_genomes/ref_prok_rep_genomes

It's also likely that you want to search a much smaller and specific set of sequences that you have already prepared in FASTA format. For this, there is the command *makeblastdb*:

.. code-block:: bash

    # Make a nucleotide sequence database
    makeblastdb -in dna_sequences_to_search.fasta -dbtype nucl

The *-in* argument should point to a fasta file that you want to create the database from, and the *-dbtype* must be either 'nucl' for nucleotide sequence or 'prot' for protein sequence. Other options allow you to use different types of input file, to mask sequences or parts of sequences, to index taxonomic information for the database and more. However you run it, *makeblastdb* produces some additional files if you check the directory containing the FASTA file that index the sequences ready for searching.

Running BLAST
^^^^^^^^^^^^^

The four BLAST algorithms highlighted on the front page of the NCBI BLAST homepage have identically-named command line equivalents. We will demonstrate here with *blastn*, and some of the arguments vary slightly for the other algorithms, but the most important thing is to choose the correct one based on the nature of your query and database (as described above).

If you check the help available for *blastn* with *-h* or *-help* you'll find a whole host of possible arguments, so let's see an example of the minimal command needed to run it:

.. code-block:: bash

    # Run blastn
    blastn -db /path/to/db -query sequence_to_look_for.fasta

This is a minimal example because we only give *-db* to choose a database and *-query* to indicate the fasta file containing our sequence to search for. It will produce an output directly to the command line that's similar to the Alignments tab of the web interface results - easy to read for you, but not very easy to process for a computer. There are alternative output modes, of which the most useful is number 6, a tab-separated columnar format:

.. code-block:: bash

    # Run blastn for nice output
    blastn -db /path/to/db -query sequence_to_look_for.fasta -out blastn_results.txt -outfmt 6

Here, *-out* gives the program a file to place the output in and *-outfmt* selects our output format. The columns, in order, are:

.. code-block::

    1.   qseqid      query or source (e.g., gene) sequence id
    2.   sseqid      subject  or target (e.g., reference genome) sequence id
    3.   pident      percentage of identical matches
    4.   length      alignment length (sequence overlap)
    5.   mismatch    number of mismatches
    6.   gapopen     number of gap openings
    7.   qstart      start of alignment in query
    8.   qend        end of alignment in query
    9.   sstart      start of alignment in subject
    10.  send        end of alignment in subject
    11.  evalue      expect value
    12.  bitscore    bit score

For more information on this output format, look `here <https://www.metagenomics.wiki/tools/blast/blastn-output-format-6>`_

If you are searching a very large database, *blastn* can take a very long time to run. There are a couple of ways to improve speed:

.. code-block:: bash

    # Use a faster but less sensitive algorithm
    -task megablast

    # Use more compute threads if available
    -num_threads 32

You can also run BLAST in pairwise mode if you want to align (or check for alignments between) two sequences, in which case there is no need to run *makeblastdb*:

.. code-block:: bash

    # Run a pairwise alignment
    blastn -query sequence1.fasta -subject sequence2.fasta

There are further options for *blastn* that modify the scoring algorithm, filter the query or database before searching and many more.

.. admonition:: Exercises
    :class: exercise

    * Run BLAST on the command line to determine what sequence mystery_sequence_02.fasta might be - be careful to choose the correct algorithm
    * It would be faster if we only searched the genome we think the sequence is from, so construct a database from this genome and repeat the search

.. admonition:: Homework
    :class: homework
