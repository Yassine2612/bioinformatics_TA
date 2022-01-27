Annotation
==========

General information
^^^^^^^^^^^^^^^^^^^

Main objective
--------------

In this lecture we will introduce the concept of sequence annotation. We will look at how to predict genes from sequence, how to predict function by homology and the databases that we use to do this.

Learning objectives
-------------------

* Students are able to predict open reading frames (genes) from sequence in prokaryotes and understand the principle in eukaryotes
* Students understand the principle of predicting function by homology
* Students are able to use databases such as PFAM to search for functional components in a sequence

Requirements
------------

Laptop with access to the ETHZ network, via VPN if necessary

Introduction to annotation
--------------------------

When we look at a DNA sequence, how do we know what it does? What features it encodes? Like most of science, we build on the work done before. If the known function of a genetic element was determined at some point experimentally, and if we see that genetic element again, or something that looks like it, we might suspect that it has the same function. Then, when we have seen enough examples of a particular element, we might figure out a pattern or set of rules to predict the existence of that element in a completely new sequence. Broadly, this is known as *function by homology* or *homology-based inference*.

There are various different annotation tasks you might want to perform on a novel sequence, for example:

* Gene prediction
* Searching for a gene with a particular function
* Promoter and protein binding site prediction
* The prediction of various non-messenger RNAs
* The prediction of CRISPR arrays
* Finding signal peptide features in coding sequences

In these exercises we will show you how to predict genes in prokaryotes, how to predict gene function by homology and how to search for particular functions.

Gene prediction
---------------

Genes in prokaryotes are relatively simple in structure: they begin with a start codon, end with a stop codon and contain a ribosomal binding site (RBS) motif. The coding density across a genome is also relatively high - most sequence encodes a gene. When looking for a gene, there are six possible reading frames, or six possible ways to convert a nucleotide sequences into an amino acid sequence:

.. thumbnail:: images/orf.png
    :align: center

There are 3 frames on the top strand reading left to right, starting with the 1st, 2nd or 3rd base of the sequence in green, orange or magenta respectively. There are 3 additional frames on the complementary strand reading right to left, starting with the last, last but one or last but two base of the sequence in magenta, orange or green respectively. An open reading frame (ORF) is a region in one of these reading frames that begins at a start codon (M for Methionine) and then extends long enough that the region could be a gene before reaching a stop codon (* for any of the three possible stop codons). In this example a very small open reading frame exists, highlighted in grey.

Gene prediction algorithms look for these open reading frames and then use a model based on training data to determine which are likely genes, taking into account:

* The start codon distribution
* RBS motifs
* Gene lengths
* Overlap between genes (on the same and opposite strands)

Prodigal
^^^^^^^^

The most popular prokaryotic gene predictor is a software package called **prodigal**, available `here <https://github.com/hyattpd/Prodigal>`_. We have also made it available on our module system. Minimally, prodigal requires an input file in fasta format of at least 20kbp and will produce output directly to the command line, which our example command improves on by using the *-o* option to send the output to a file.

.. code-block:: bash

    # Minimal example of running prodigal
    prodigal -i my_genome.fasta -o my_genome.gbk

    # Running prodigal with useful outputs
    prodigal -i my_genome.fasta -o my_genome.gbk -d my_genes.fna -a my_genes.faa

In the second example we add the *-d* and *-a* options to output the nucleotide and amino acid sequences of the predicted genes to files. You can also modify the format of the main output file with *-f* and other options allow you to tailor the algorithm to your application, such as for a metagenome or just to train the algorithm parameters for use on another sequence.

.. admonition:: Exercise
    :class: exercises

    * Run prodigal on a genome

Gene prediction in eukaryotes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In eukaryotes, genes are more complicated features, notably with introns and exons that make the prokaryotic approach unworkable. The approach is instead to train a more sophisticated model on existing eukaryotic genes in a closely-related organism and use this model to predict genes in novel sequence. An example of software that does this is GlimmerHMM, available `here <https://ccb.jhu.edu/software/glimmerhmm/>`_. As we said at the start of Comparative Sequence Analysis, it is beyond the scope of this course to look at this further.

Gene function prediction
------------------------

Now we have identified potential protein sequences in our genome, we should try to find their functions using the principle of homology described in the introduction. There are many databases we could search to find similar sequences, but rather than just using the largest possible, we should consider the quality of evidence provided by each. For instance, RefSeq is a more carefully curated set of sequences than GenBank as a whole. Further, evidence of actual protein sequence and function is better than evidence of only transcript.

UniProt
^^^^^^^

A useful resource for protein sequence and function information is the database `UniProt <https://www.uniprot.org/>`_, a collaboration between the European Bioinformatics Institute (EMBL-EBI), the Swiss Institute of Bioinformatics (SIB) and the Protein Information Resource (PIR). Within this project exists Swiss-Prot, which is manually annotated and reviewed, and UniRef, which clusters proteins at certain threshold distances.

.. thumbnail:: images/overview.png
    :align: center

The website allows you to search by text, such as gene name or organism, or by sequence with BLAST. As a brief introduction, let's look at the `entry <https://www.uniprot.org/uniprot/P0AES4>`_ for a well known bacterial protein, DNA Gyrase subunit A or gyrA:

.. thumbnail:: images/uniprot_gyra.png

In this header you can see the gene name and organism it is from, as well as the annotation status, which gives you an idea of how much evidence there is for this particular annotation. There is also a summary of the functions of the protein with links to the scientific papers that support these statements. On the left is a table of contents for the rest of the page:

* Names & Taxonomy: lists standard names, any alternative or historical names, the organism and its taxonomy
* Subcellular location: shows you where in the cell the protein has been located, if evidence is available
* Pathology & Biotech: describes diseases and phenotypes associated with the protein and possible mutations of it, as well as drugs and chemicals it interacts with
* PTM/Processing: lists post-translational modifications and processing of the molecule
* Expression: information on the mRNA and protein levels in the cell or tissue
* Interaction: describes the quaternary structure of the protein and interaction with other proteins and complexes
* Structure: information on the tertiary and secondary structure of the protein that may include 3D structures from experiment or prediction
* Family & Domains: information on sequence similarities with other proteins and its domains (we will discuss this more in the next section)
* Sequence: the amino acid sequence of the protein as well as known variants and database listings
* Similar proteins: links to other proteins in the database based on percentage identity
* Cross-references: information from other databases (a summary of links in other sections)
* Entry information: metadata about the protein entry itself
* Miscellaneous: information that doesn't fit into any of the other sections

As you can see, a vast amount of information is available about a single protein and UniProt does a good job of collating it all for easy access.

PFAM
^^^^

In the "Family & Domains" section for Gyrase A, 

Quick TOC
---------

* Finding genes
* Annotation by homology
* The idea of weight matrices/statistical function prediction
* Protein domains and PFAM

Uniprot
-------

The Universal Protein Resource (UniProt) is a database hosted by the European Bioinformatics Institute (EMBL-EBI), Swiss Institute of Bioinformatics (SIB) and  Protein Information Resource (PIR) for protein sequence, annotation and functions. Uniprot consists of three databases the UniProt Knowledgebase (UniProtKB), the UniProt Reference Clusters (UniRef), and the UniProt Archive (UniParc).

.. image:: images/overview.png


The UniProtKB consists of two sections, a manually annotated part and an automated annotated part which awaits manual annotation. Each entry provides functional information about a protein with as much annotation information as possible.

