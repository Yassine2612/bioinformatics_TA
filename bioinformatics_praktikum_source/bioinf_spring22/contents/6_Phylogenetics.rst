Phylogenetics
=============

General information
-------------------

Main objective
^^^^^^^^^^^^^^

Phylogenetic analyses have become central to understanding the evolutionary history, ecology and diversity of life on earth. In this lecture, we will introduce basic concepts of phylogenetic analyses based on DNA sequences. We will show you how to infer the evolutionary relationship of groups of organisms. To this end, we will collect phylogenetically informative sequences and teach you, step-by-step, how to reconstruct a phylogenetic tree via a web-based interface. 
.. We will then practice how to use software for phylogenetic tree reconstruction on the command line.

Learning objectives
^^^^^^^^^^^^^^^^^^^

* Students are able to collect DNA and protein sequences of interest and store them them in an adequate format.
* They can explain the different steps and know examples of software required to generate phylogenetic trees.
* Using phylogenetic trees, they can explain the hypothesised evolutionary relationship between organisms and genes. 

Resources
^^^^^^^^^

This section requires the use of the R Workbench according to your **surname**:

* A-J: `Server 01 <https://rstudio-teaching-01.ethz.ch/>`__
* K-R: `Server 02 <https://rstudio-teaching-02.ethz.ch/>`__
* S-Z: `Server 03 <https://rstudio-teaching-03.ethz.ch/>`__

Phylogenetic trees
------------------

The objectives for reconstructing phylogenetic trees can be manifold. Generally speaking, a phylogenetic tree is a hypothesis of how biological species or other entities (e.g., genes) are related through evolution. It is a branching diagram showing the inferred evolutionary relationships among these entities based on similarities in their genetic and/or physical characteristics.

For the interpretation of phylogenetic trees, it is important to understand the concept of homology as similarity due to shared ancestry. For example, the forelimbs of vertebrates are **homologous** structures. Although in different animals, they may vary in form and function (e.g., arms, forelegs, wings, front flippers), they have evolved from the same structure in the last common ancestor of tetrapods. However, the function of wings in insects, bats and birds is **analogous**, as it has evolved independently in widely divergent groups of animals.

By extension of the concept of homology to DNA and protein sequences, two sequences are homologous if they share ancestry. High similarity between two sequences provide strong evidence for their shared ancestry, but is my no means conclusive. Importantly, based on the definition of homology specified above, the similarity between sequences is merely an empirical observation. Whether or not these sequences are homologous requires interpretation, e.g. by reconstructing phylogenetic trees. As with wings, sequence similarity may occur as a result of convergent evolution, or with short sequences, by chance. 

Furthermore, homologous sequences can be **orthologous** or **paralogous** with respect to each other: "Where the homology is the result of gene duplication so that both copies have descended side by side during the history of an organism, (for example, alpha and beta hemoglobin) the genes should be called paralogous (para = in parallel). Where the homology is the result of speciation so that the history of the gene reflects the history of the species (for example alpha hemoglobin in man and mouse) the genes should be called
orthologous (ortho = exact)." -- `W. Fitch <https://doi.org/10.2307/2412448>`__. Homologous sequences that have been transfered between species are xenologs.

One of the most important implications for phylogenetics is that **only sets of orthologous sequences are expected to reflect the underlying evolution of species**, whereas a set of homologous genes (including orthologs, paralogs and xenologs) can be informative about the evolutionary relationship between species (gene duplication within/among species and horizontal gene transfer). Orthologous genes, as compared to paralogs, are also more likely to share the same function. 

Advanced reading:
Phylogenies - lecture notes (by Casey Dunn): `Phylogenetic Biology <http://dunnlab.org/phylogenetic_biology/phylogenies.html>`__.

Note that inferring orthology, building a species tree from a set of orthologous genes and assuming functional conservation among orthologous genes is not as straight forward as it seems. For more information, see for example: `Gabaldon and Koonin, 2013 <https://doi.org/10.1038/nrg3456>`__.


Generating a phylogenetic tree (via a web-server)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this section of the course, we will introduce you to `NGPhylogeny <https://ngphylogeny.fr>`__, a web-based platform that performs a phylogenetic analysis in a user-friendly way, that is without the need for the installation of several software programmes and the re-formatting of input and output files. The user can chose to run the analyses with a "one click" workflow using default tools and parameters, or create more advanced and customised workflows. The platform provides detailed information about the individual steps that are performed and the tools that are used to execute them:

0. Collection and formatting of sequence data   
1. Multiple sequence alignment (MSA)
2. MSA curation
3. Tree inference
4. Tree visualisation

.. thumbnail:: images/NGPhylogeny.png
    :align: center
    :width: 100%


0. Collection and formatting of sequence data
---------------------------------------------

The prerequisite for generating multiple sequence alignments (MSAs) is a collection of DNA/protein sequences. The user/researcher is responsible to collect the sequences of interest and to format them so they can be used as an input to MSA programmes. 

Here, we will use the protein sequences of hemoglobin genes from human, mouse and chicken as an input to NGPhylogeny. For illustration, we will run the "One-click workflow" with default settings.

1. Multiple sequence alignment (MSA)
------------------------------------

As a first step, the sequences will be aligned by `MAFFT <https://dx.doi.org/10.1093%2Fnar%2Fgkf436>`__ (see also `section 4 <https://sunagawalab.ethz.ch/share/teaching/bioinformatics_praktikum/bioinf_spring22/contents/4_Alignment.html#multiple-sequence-alignment-msa>`__). Alignments are usually visually depicted with sequences as rows and nucleotides (DNA) or amino acid residues (proteins) as columns. Mutation events over generations result in nucleotide changes and an amino acid change if a nucleotide change leads to a non-synonymous substitution of the affected codon. Insertion or deletion events are denoted as hyphens in one or more sequences in the alignment.

2. MSA curation
---------------

The quality of a MSA is important for the accuracy of phylogenetic inference. With increasing numbers and higher divergence of sequences (i.e., from evolutionarily more distant organisms), there is a good chance that an alignment will contain errors. Manual curation can become challenging, and furthermore, not every position in the alignment may be phylogenetically informative (N.B.: can you think of reasons why?). There are several bioinformatic tools dedicated to the curation of MSAs. By default, NGPhylogeny uses `BMGE <https://doi.org/10.1186/1471-2148-10-210>`__.

3. Tree inference
-----------------

The curated MSA serves as an input to construct and refine a phylogenetic tree, which can be considered a hypothesis of the evolutionary relationships between divergent species or genes represented in the genomes of divergent species. Several computational approaches exist that can be grouped into distance-matrix, maximum parsimony, maximum likelihood and Bayesian inference methods. The method differ in their assumptions, algorithms and types of models used. Distance matrix methods are faster and computationally less expensive. However, the other methods are considered to produce more accurate results. By default, NGPhylogeny uses `FastME <https://doi.org/10.1093/molbev/msv150>`__ as a distance-based programme to infer phylogenetic trees.

4. Tree visualisation
---------------------

The Newick format is one of the most widely used formats to represent phylogenetic trees in computer-readable form. Several software packages exist to visualize and manipulate trees in different ways. For example, a cladogram displays the branching structure of a tree without branch length scaling, while in a phylogram, the branch lengths are proportional to the inferred evolutionary change. A tree can be unrooted, which makes no assumptions about ancestry. Although it is possible to root a tree on any of its branches, usually, it is rooted at the most recent common ancestor of all species/genes (leaves) in the tree. The layout of trees can be a rectangular or circular cladogram, for example. 

.. admonition:: Exercise 6.1
    :class: exercise

    Please visit the website `https://ngphylogeny.fr <https://ngphylogeny.fr>`__, select "One click workflows" under "Phylogeny Analysis" and upload (or copy/paste) the file ``/nfs/course/551-0132-00L/6_Phylogenetics/hemoglobin_homologs.faa``, which contains homologous protein sequences of the globin gene family from vertebrates (human, mouse, chicken) and a non-vertebrate, the lancelet Branchiostoma floridae, as an outgroup. Once the workflow finishes, you can inspect the resulting tree directly in NGPhylogeny. 

    Save or copy the Newick-formatted tree data and upload it to `iTOL <https://itol.embl.de/upload.cgi>`__ (you can also export the Output Tree directly to iTOL), a powerful online tool for tree visualisation and annotation. Once the tree is displayed, click on any branch or leaf. A pop-up window will appear and under Editing/Tree structure, you can click on "Root the tree at midpoint". The same can be achieved by clicking on the "Advanced" tab on the "Control panel" and clicking on "Midpoint root" under "Other functions" at the bottom. The tree is now displayed so that the last common ancestor of all sequences is represented as the root. Given this tree, HbA=hemoglobin alpha chain, HbB=hemoglobin beta chain, Mb=Myoglobin and Gb=Globin answer the following questions:

    * Q1: For any combination of the genes in the tree, determine whether they are orthologs or paralogs (for example, Homo-sapiens-HbA1 and Gallus-gallus-HbA are [orthologs|paralogs]).

    .. hidden-code-block:: bash

       HbA to HbB, HbA to Mb and HbA to Mb, and Ha genes within the same species are paralogs.

       Mb genes from different species are orthologs.
       
       HbB genes from different species are orthologs.
       
       Without further analysis (e.g. testing gene neighborhood), it is not possible to determine if HbA1 or HbA2 genes in humans and mice are orthologous to the HbA gene in chicken.
       
       Similarly, it is not possible to determine which pairs of HbA genes in humans and mice are orthologous to each other.

    * Q2: Importance of orthology: if you had only collected the sequences: Homo-sapiens-HbA1, Gallus-gallus-HbA and Mus-musculus-HbB, what would you have inferred about the relationships between human, mice and chicken (which organisms are more closely related to each other)?

    .. hidden-code-block:: bash

       Due to incomplete sampling/data, humans would appear to be more closely related to chicken than to mice.

    * Q3: Homo sapiens and Mus musculus have two isoforms of HbA genes (HbA1 and HbA2). The branch length between the isoforms is zero. Formulate a hypothesis when this gene duplication ocurred. What kind of additional data would you collect to test your hypothesis?

    .. hidden-code-block:: bash

       Sharing the exact same protein sequence suggest a recent (i.e., on an evolutionary time scale) duplication event of the gene; however, sometime before the last common ancestor of humans and mice existed. Testing for the copy number of the HbA gene in more distantly related organisms (e.g., mammals, tetrapods, vertebrates) could provide additional evidence when the duplication of the HbA gene occurred.
           
    Further reading: 

    * `Evolution of the globin gene superfamily in vertebrates <https://doi.org/10.1093/molbev/msr207>`__ (note Figure 1).
    * `Evolutionary Innovations in Hemoglobin-Oxygen Transport <https://doi.org/10.1152/physiol.00060.2015>`__ (note Figures 1 and 3).

.. admonition:: Exercise 6.2
    :class: exercise

    Once a set of suitable orthologs has been identified, phylogenies can be inferred to address biological questions. In this exercise, you will explore the evolution of marine mammals.

    Please upload the protein sequences of the tumor supressor gene p53 from several mammals, including many mammals you will be familiar with, to NGPhylogeny according to exercise 6.1. The protein sequences in FASTA format can be found at: ``/nfs/course/551-0132-00L/6_Phylogenetics/p53.marine.mammals.faa``. A table that maps protein identifiers, common names and scientific names is provided here: ``/nfs/course/551-0132-00L/6_Phylogenetics/p53.meta.tsv``.

    The output tree can be exported to iTOL for visualization. Within iTOL, there is a useful feature to translate the protein identifiers into scientific species names. To do this, click on the "Advanced" tab on the control panel, click on "Assign taxonomy" and follow the instructions. Root the tree at its midpoint (Advanced->Other functions->Midpoint root).

    * Q1: Have mammals evolved to inhabit the marine environment once or on multiple occasions?

    .. hidden-code-block:: bash

       The phylogeny strongly suggests that mammals have evolved to inhabit the marine environment on multiple independent occasions. Cetaceans (whales, dolphins and porpoises) and sirenians (manatees and dugongs) emerged during the Eocene epoch through diversification from the Cetartiodactyla and Afrotheria, respectively. Pinnipeds (seals, sea lions and walruses) emerged approximately 20 million years later during the Miocene from within the Carnivora. 

    * Q2: Are whales more closely related to cows or to elephants?

    .. hidden-code-block:: bash

       Whales are more closely related to cows than to elephants.

    * Q3: Are walrusses more closely related to dogs or pigs?

    .. hidden-code-block:: bash

       Walrusses are closely related to seals and sea lions, which share more recent ancestry with dogs than with pigs.

    * Q4: Are manatees more closely related to elephants or dolphins?

    .. hidden-code-block:: bash

       Although manatees and dolphins live in the ocean, their ancestors have evolved to inhabit the marine environment independently. Manatees are more closely related to elephants than dolphins.

    Further reading:

    * `Convergent evolution of the genomes of marine mammals <https://www.nature.com/articles/ng.3198>`__ (note Figure 1).

Homework
--------

.. |br| raw:: html

   <br />

.. admonition:: Homework 6 
        :class: homework

        |br| The homework for this week consists of two parts and should prepare you for an extended discussion next week. In addition to improving your practical skills, the emphasis is on applying what you have learned to formulate and test biologically relevant hypotheses. You will use basic UNIX commands to re-format and parse data files that will allow you to get some insights into the selective pressure on some of the proteins encoded by the SARS-CoV-2 virus. 

	Please visit `this website <https://sunagawalab.ethz.ch/share/teaching/bioinformatics_praktikum/bioinf_spring22/contents/6_Phylogenetics_SARS-CoV2.html>`__, where you will find detailed information on tasks and what is expected to be submitted.

.. Advanced users will perform analyses to obtain an overview on the evolution of SARS-CoV2 viruses at different levels of phylogenetic resolution (genus, species, variants).

.. container:: nextlink

    `Next: SARS-CoV2 homework <6_Phylogenetics_SARS-CoV2.html>`__
