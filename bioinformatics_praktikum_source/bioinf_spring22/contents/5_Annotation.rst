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

When we look at a DNA sequence, how do we know what it does? What features it encodes? Like most of science, we build on the work done before. The known function of a genetic element was determined at some point experimentally, and if we see that genetic element again, or something that looks like it, we suspect it might have the same function. Then, when we have seen enough examples of a particular element, we might figure out a pattern or set of rules to predict the existence of that element in a completely new sequence. Broadly, this is known as *function by homology* or *homology-based inference*.

There are various different annotation tasks you might want to perform on a novel sequence, for example:

* Gene or open reading frame prediction
* Searching for a gene with a particular function
* Promoter and protein binding site prediction
* The prediction of various non-messenger RNAs
* Prediction of CRISPR arrays
* Finding signal peptide features in coding sequences

In these exercises we will show you how to predict genes in prokaryotes, how to predict gene function by homology and how to search for particular functions.

Quick TOC
---------

Finding genes
Annotation by homology
The idea of weight matrices/statistical function prediction
Protein domains and PFAM

Uniprot
-------

The Universal Protein Resource (UniProt) is a database hosted by the European Bioinformatics Institute (EMBL-EBI), Swiss Institute of Bioinformatics (SIB) and  Protein Information Resource (PIR) for protein sequence, annotation and functions. Uniprot consists of three databases the UniProt Knowledgebase (UniProtKB), the UniProt Reference Clusters (UniRef), and the UniProt Archive (UniParc).

.. image:: images/overview.png


The UniProtKB consists of two sections, a manually annotated part and an automated annotated part which awaits manual annotation. Each entry provides functional information about a protein with as much annotation information as possible.

