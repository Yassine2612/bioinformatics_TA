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
* Students can perform a multiple sequence alignment

Resources
^^^^^^^^^

This section requires the use of the R Workbench according to your **surname**:

* A-J: `Server 01 <https://rstudio-teaching-01.ethz.ch/>`__
* K-R: `Server 02 <https://rstudio-teaching-02.ethz.ch/>`__
* S-Z: `Server 03 <https://rstudio-teaching-03.ethz.ch/>`__

Comparative Sequence Analysis
-----------------------------

In this section of the course, we will show you how to analyse an unknown sequence. For simplicity, we will focus on the procedure you would follow for the genes in a novel bacterial genome. The techniques we use are generally applicable to other organisms and other features, but more difficult or computationally intensive. We will briefly discuss other applications beyond bacterial genes in the relevant sections.

The common element in all these techniques is sequence comparison. Determining the similarities and differences between two or more sequences allows us to infer the features and functions of the sequence (**annotation**) and its relationship to other sequences (**phylogeny**). However in order to compare sequences we must understand **alignment**.

Sequence alignment
------------------

One way to compare two sequences is through alignment - arranging them against one another to identify areas of similarity. There are two general approaches we could take:

* Global alignment attempts to align every residue (a nucleotide sequence base or a protein sequence amino acid) between the two sequences
* Local alignment looks for regions of alignment between the two sequences and ignores the rest

We then need an algorithm that will arrange and score different possible alignments.

BLAST
^^^^^

BLAST, or the **B**\asic **L**\ocal **A**\lignment **S**\earch **T**\ool (**BLAST**), is the most commonly used alignment tool, which you may be able to tell from its acronym, performs local alignment. The details of the algorithm are beyond the scope of this course, but understanding the scoring system is important.

BLAST scores an alignment residue by residue based on whether it is a **match**, **mismatch**, or a **gap** (which might exist due to the insertion or deletion of 1 or more residues in one sequence).

.. code-block::

    mismatch
    |
    ATGACTAGCTGCTATATCAGCTAC
     || ||||||||     |||||||  <-- every | indicates a match
    GTG-CTAGCTGC-----CAGCTAC
       |          |
       gap        extended gap


The score for a match or mismatch depends on exactly which residues are being compared. For DNA this is simple, an identical penalty for any mismatch. For amino acids this is more complex, where residues with similar properties (say, hydrophobicity or polarity) are penalised less than those that are very different. A **scoring matrix** is employed to determine the final match or mismatch score and here we show the BLAST DNA scoring matrix and a commonly used amino acid matrix, BLOSUM62:

+--+--+--+--+--+
|  |A |C |G |T |
+--+--+--+--+--+
|A |+5|-4|-4|-4|
+--+--+--+--+--+
|C |-4|+5|-4|-4|
+--+--+--+--+--+
|G |-4|-4|+5|-4|
+--+--+--+--+--+
|T |-4|-4|-4|+5|
+--+--+--+--+--+

.. thumbnail:: images/BLOSUM62.png
    :align: center
    :width: 50%

Gaps are scored in two ways. Firstly, there is a penalty for **opening a gap**, and if there is more than one in a row then a **gap extension penalty** is applied, typically less than the penalty for opening it in the first place. In BLAST, these penalties depend on the exact algorithm used.

So the final score for a given alignment is the sum across all residues of the matches, mismatches, gap openings and gap extensions.

Using BLAST online
^^^^^^^^^^^^^^^^^^

Most researchers are familiar with the web-based interface for BLAST found `here <https://blast.ncbi.nlm.nih.gov/Blast.cgi>`__.

.. thumbnail:: images/blast.png
    :align: center

The four main varieties of BLAST are neatly summarised on this frontpage.

* blastn: nucleotide blast for comparing DNA sequences (left)
* blastx: searching a protein database for a translated nucleotide query (middle top)
* tblastn: searching a translated nucleotide database for a protein query (middle bottom)
* blastp: protein blast for comparing protein sequences (right)

You should therefore choose your BLAST algorithm based on the nature, nucleotide or protein, of your query and your database. There are also further versions available for more specialised applications.

Pairwise alignment
------------------

We will first select Nucleotide BLAST (blastn) to perform a pairwise alignment of two nucleotide sequences that we have put in the files ??/pairwise1.fasta and ??/pairwise2.fasta.

The setup page for blastn looks as follows - you should click on the checkbox highlighted to enable pairwise alignment:

.. thumbnail:: images/blastn2.png
    :align: center

This will change the page to look as follows:

.. thumbnail:: images/blast2.png
    :align: center

In each of the sections *Enter Query Sequence* and *Enter Subject Sequence* you can either paste the relevant sequence into the text box or choose a file to upload, which should be in fasta format. For each sequence you can also specify a subrange from the sequence by giving start and end coordinates. You can also give your alignment a *Job Title*. The *Program Selection* section allows you to select which specific blastn algorithm you want to use.

.. admonition:: Exercise 4.1
    :class: exercise

    * Perform a pairwise alignment of the sequences in the files ??/pairwise1.fasta and ??/pairwise2.fasta. For this example, you don't need to enter any subrange coordinates or change the algorithm from the default (megablast). It is up to you whether you want to copy and paste the sequences or upload the fasta files.

Alignment results
^^^^^^^^^^^^^^^^^

The results page has a summary of the search performed at the top (left), with the option to further filter the results (right).

.. thumbnail:: images/pwblastres0.png
    :align: center

The first tab in the results section is Description. Here you can see the statistics for each alignment found between the two sequences:

.. thumbnail:: images/pwblastres1.png
    :align: center

* Max Score: the highest score from the alignments found
* Total Score: the sum of scores for all alignments found
* Query Cover: the percentage of the query sequence for which any alignment was found
* E value: the likelihood of the alignment being seen by chance (not that this is dependent on the database size searched)
* Per. Ident: the percentage identity of the alignment, i.e.: how many base pairs are identical
* Acc. Len: the length of the subject sequence
* Accession: the name of the subject sequence (or an arbitrary name)

In this example, there is only one alignment in the results and so some of this information is not interesting. What we can see is that the alignment covers 99% of our query sequence and is approximately 87% identical. We cannot really say if this alignment is significant or not because we have only compared our query to one subject, and this was contrived to give a successful alignment. Nonetheless we can inspect the alignment more carefully in the other tabs.

The second tab gives a graphical summary of the alignment, depicting the quality across the length of the query sequence with a colour code:

.. thumbnail:: images/pwblastres2.png
    :align: center

The third tab shows you the precise alignment summarised in the first tab. The query and subject sequences are shown beside one another, with vertical pipe symbols "|" representing identity and dashes "-" for gaps in either sequence.

.. thumbnail:: images/pwblastres3.png
    :align: center

The fourth and final tab is specific to pairwise alignment and shows a dot plot of the alignment or alignments between the pair of sequences.

.. thumbnail:: images/pwblastres4.png

Searching by alignment
----------------------

BLAST is used far more often for **searching** by alignment, that is, finding sequences in a database that align to a query. If we return to the BLAST homepage and again select Nucleotide BLAST (blastn), and then make sure that the "Align two or more sequences" is **unchecked**, we should see the standard search interface:

.. thumbnail:: images/blastn.png

Let's look at the different sections on this page:

* Enter Query Sequence: this section is the same as for pairwise alignment.

* Choose Search Set: here you can specify search parameters.

  * Database: this is where you select an NCBI database to search; typically nr/nt to search Genbank protein/nucleotide sequences but you may want to use RefSeq or another specific database.
  * Organism: you can enter the name of an organism or taxonomic level to restrict your search, for instance *Escherichia* or *fungi*.
  * Exclude: checkboxes to exclude RNA and protein sequences generated by NCBI's automated pipeline (the Models), or uncultured sequences (those reconstructed from metagenomic samples).
  * Limit to: you can restrict your search to only type material, which are the exemplary species, see `this paper <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4383940/>`__ for more information.
  * Entrez Query: you can also use custom search terms from the Entrez system to restrict your search.

* Program Selection: you can select the specific algorithm you want to use here; the default is usually sufficient but you can use a slower but more sensitive algorithm if needed.

* BLAST: this button will begin the search.

* Algorithm parameters: here you can specify the exact parameters BLAST will use in alignment during the search; in general you won't need to modify those used by the three Program Selection options.

Search results
^^^^^^^^^^^^^^

The results page has a summary of the search performed at the top (left), with the option to further filter the results (right).

.. thumbnail:: images/blastres0.png
    :align: center

The first tab in the results section is Description. The statistics reported are the same as for pairwise alignment. You can sort hits by any of the data columns if you want to specifically find the longest or most identical hit, for instance, where the default is by e-value.

.. thumbnail:: images/blastres1.png
    :align: center

The second tab gives a graphical summary of the hits found. It depicts the quality of the alignment across the length of the query sequence with a colour code for alignment quality.

.. thumbnail:: images/blastres2.png

The third tab shows you the precise alignment found by the algorithm. The query and subject sequences are shown beside one another, with vertical pipe symbols "|" representing identity.

.. thumbnail:: images/blastres3.png

The fourth and final tab gives you a taxonomy of the organisms found in the hits and how many hits were found at each taxonomic level.

.. thumbnail:: images/blastres4.png

.. admonition:: Exercise 4.2
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

Firstly, you can perform pairwise alignment just as with the online interface by specifying a query and subject sequence, as in this minimal example:

.. code-block:: bash

    # Pairwise alignment with blastn
    blastn -query ??/pairwise1.fasta -subject ??/pairwise2.fasta

Secondly, you can of course search by alignment by providing a database to look through, as in this minimal example:

.. code-block:: bash

    # Run blastn
    blastn -db /path/to/db -query sequence_to_look_for.fasta

You can recreate any of the options available via the online interface with the right set of command line options. A full listing will be shown by running *blastn -h* or *blastn -help*.

Without any additional options, the two examples above output directly to the command line. You can direct the output to a file with the *-out filename* option. The output is also quite extensive, and although it is human-readable, it isn't easy to process for a computer. There are ways to modify the output with the option *-outfmt n* where *n* is a number, and perhaps the most useful is *-outfmt 6*, which produces a tab-separated table summarising the hits found.

.. code-block:: bash

    # Run blastn for nice output
    blastn -db /path/to/db -query sequence_to_look_for.fasta -out blastn_results.txt -outfmt 6

The output columns, in order, are:

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

For more information on this output format, look `here <https://www.metagenomics.wiki/tools/blast/blastn-output-format-6>`__

If you are searching a very large database, *blastn* can take a very long time to run. There are a couple of ways to improve speed:

.. code-block:: bash

    # Use a faster but less sensitive algorithm
    -task megablast

    # Use more compute threads if available
    -num_threads 32

.. admonition:: Exercise 4.3
    :class: exercise

    * Run BLAST on the command line to determine what sequence mystery_sequence_02.fasta might be - be careful to choose the correct algorithm

Multiple sequence alignment (MSA)
---------------------------------

As we will cover in later sections, there are situations in which you want to compare and align multiple sequences all at once. This is a much harder problem to solve than pairwise alignment, in fact producing a truly optimal alignment is not feasible within a reasonable computational time, and there are various approaches that can be taken depending on what is already known about the relationships between the sequences. We will look at two approaches that make few assumptions about the sequences to be aligned, and which are used by a lot of MSA software.

Progressive alignment
^^^^^^^^^^^^^^^^^^^^^

This approach builds a final MSA by combining pairwise alignments, starting with the two closest sequences and working towards the most distantly related. The problem with this method is that part of the alignment that is optimal when it is introduced early in the process might not be so good later when other sequences join the MSA.

One popular implementation of this method is **MAFFT**, available `here <https://mafft.cbrc.jp/alignment/software/>`__. We have also made the software available on our server and will show you the basics of how to use it here. At minimum, MAFFT requires an input file with multiple sequences in fasta format and unusually always outputs to the command line, so we must redirect it.

.. code-block:: bash

    # Run MAFFT
    mafft my_sequences.fasta > my_msa.fasta

The output format is by default fasta but can be set to *clustal* format, explained below. Other options relate to the speed or accuracy of the aligner - you can read more in the MAFFT manual if interested.

Another popular implementation of this method is **Clustal**, the current version of which is called **Clustal Omega** and is supported by the EMBL-EBI, hosted `here <https://www.ebi.ac.uk/Tools/msa/clustalo/>`__. We have also made the software available on our server and will show you the basics of how to use it here. At minimum, Clustal Omega requires an input file containing multiple sequences, accepting both multi-fasta and existing alignment formats.

.. code-block:: bash

    # Run Clustal Omega
    clustalo -i my_sequences.fasta -o my_msa.fasta

The output is by default, also in fasta format, but now each sequence has gaps inserted at the right points so that the nth position in each sequence is aligned. Once again, there are many command options available, many of which won't make any sense to you at the moment, but some are immediately useful. For instance, *--outfmt* allows you to select a different output format - there is no dominant format for MSA, and programs that use them as input may or may not support any specific format you choose. Clustal has a format itself which is useful for browsing a multiple alignment as it includes a line of characters indicating whether or not a column in the alignment is identical or not. The width of this format can be adjusted with *--wrap*.

.. admonition:: Exercise
    :class: exercise

    * Align example file, try different output formats

Iterative alignment
^^^^^^^^^^^^^^^^^^^

Iterative methods differ from progressive alignment by going back to sequences previously introduced to the MSA and realigning them. Exactly how often and how to do these realignments varies between software packages. These methods also cannot guarantee an optimal alignment, and the trade-off versus progressive methods is that the realignments obviously take additional computational time.

A popular iterative-based method is **MUSCLE**, available `here <http://www.drive5.com/muscle/>`__. We have also made this software available on our server and will show you the basics of how to use it here. At minimum, MUSCLE also only requires an input fasta file containing multiple sequences - other formats are not accepted.

.. code-block:: bash

    # Run MUSCLE
    muscle -in my_sequences.fasta -o my_msa.fasta

The output is by default, also in fasta format, and only a few other formats are supported. Beyond that, the options determine how long the algorithm will run for - more iterations may improve the alignment but will take longer, and each incremental improvement takes longer and longer to achieve.

.. admonition:: Exercises
    :class: exercise

    * Perform a multiple sequence alignment on all of the sequences used so far in this part of the course (list)

.. admonition:: Homework
    :class: homework

    * Can come up with an exercise based on getting gyrA and parC sequences from reference genomes (possibly building on the last homework) then performing a multiple alignment

.. container:: nextlink

    `Next: Annotation <5_Annotation.html>`__

