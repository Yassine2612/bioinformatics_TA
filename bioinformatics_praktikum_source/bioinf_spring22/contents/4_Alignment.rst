Alignment
=========

General information
^^^^^^^^^^^^^^^^^^^

Main objective
--------------

...

Learning objectives
-------------------

* ...
* ...

Requirements
------------

Laptop with access to the ETHZ network, via VPN if necessary

BLAST
-----
MOVE TO 4
After we showed you how to search in NCBI we also want to introduce you one of the most important tools on NCBI the **B**\asic **L**\ocal **A**\lignment **S**\earch **T**\ool (**BLAST**).

Since you will probably use BLAST a few times throughout your ETH- and scientific career it is important that **BLAST** is not just a black-box to you, where you put something in and something comes out, but that you understand its basics so that you can probably handle the results.

BLAST is an algorithm designed to find regions of similarity between biological sequences. It compares nucleotide or protein sequences to sequence databases and calculates the statistical significance. BLAST is a so-called heuristic algorithm. Heuristic algorithms are designed to solve problems in faster and more efficient ways but they sacrifice optimality, accuracy, precision, or completeness for the gained speed. Since heuristic algorithms do not generate the best result 100% of the time, it is helpful to have some understanding about the Algorithm to properly evaluate the results.

A BLAST search begins with the input of your sequence you want to align. BLAST than filters out so-called **low complexity** regions (TTTTTTT, ACACACACAC, etc.). The remainder of the sequence is then fragmented into pieces (default setting is the length of 11 nucleotides, so the first piece goes from nucleotides 1-11, the second to 2-12 and so on) throughout the sequence.  BLAST then picks the pieces which are statistically unlikely to appear and searches for exact matches (no mismatches and gaps allowed) in the database. If BLAST finds such a piece, it starts to search for matches of the database-and search sequence in both directions. Mismatches are now allowed but still no gaps. If the matches are good, BLAST starts to connect the two sequences together (gaps are now allowed).

As you can see, BLAST relays on the believe that two related biological sequences have relatively long **exactly** matching sequence sections. With this assumption, BLAST can find results much faster. On the one hand, exactly matching sequences are easier to find than similarities and on the other hand you can reduce the search space. But if the sequence you are looking for does not have an exactly matching part, you are not going to find it.

To summarize, the speed of BLAST is dependent on the piece size selected. BLAST searches with long piece sizes (which need an exact match) are going to be faster than BLAST searches with small pieces sizes. But there is the danger that you miss good alignments, if the piece size is too long. It is therefore on you, the user, to set the parameters accordingly.

