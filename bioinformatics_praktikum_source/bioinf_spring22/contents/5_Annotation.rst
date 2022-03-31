Annotation
==========

General information
-------------------

Main objective
^^^^^^^^^^^^^^

In this lecture we will introduce the concept of sequence annotation. We will look at how to predict genes from sequence, how to predict function by homology and the databases that we use to do this.

Learning objectives
^^^^^^^^^^^^^^^^^^^

* Students are able to predict open reading frames (genes) from sequence in prokaryotes and understand the principle in eukaryotes
* Students understand the principle of predicting function by homology
* Students are able to use databases such as PFAM to search for functional components in a sequence

Resources
^^^^^^^^^

This section requires the use of the R Workbench according to your **surname**:

* A-J: `Server 01 <https://rstudio-teaching-01.ethz.ch/>`__
* K-R: `Server 02 <https://rstudio-teaching-02.ethz.ch/>`__
* S-Z: `Server 03 <https://rstudio-teaching-03.ethz.ch/>`__

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

There are 3 frames on the top strand reading left to right, starting with the 1st, 2nd or 3rd base of the sequence in green, orange or magenta respectively. There are 3 additional frames on the complementary strand reading right to left, starting with the last, last but one or last but two base of the sequence in magenta, orange or green respectively. An open reading frame (ORF) is a region in one of these reading frames that begins at a start codon (M for Methionine) and then extends long enough that the region could be a gene before reaching a stop codon (* for any of the three possible stop codons). In this example a very small open reading frame exists, highlighted in grey. As a reminder, this is the amino acid codon table for prokaryotes, remembering that U is the base in RNA for T in DNA:

.. thumbnail:: images/Aminoacids_table.png
    :align: center
    :width: 60%

Gene prediction algorithms look for these open reading frames and then use a model based on training data to determine which are likely genes, taking into account:

* The start codon distribution
* RBS motifs
* Gene lengths
* Overlap between genes (on the same and opposite strands)

Prodigal
^^^^^^^^

The most popular prokaryotic gene predictor is a software package called **prodigal**, available `here <https://github.com/hyattpd/Prodigal>`__. We have also made it available on our module system. Minimally, prodigal requires an input file in fasta format of at least 20kbp and will produce output directly to the command line, which our example command improves on by using the *-o* option to send the output to a file.

.. code-block:: bash

    # Minimal example of running prodigal
    prodigal -i my_genome.fasta -o my_genome.gbk

    # Running prodigal with useful outputs
    prodigal -i my_genome.fasta -o my_genome.gbk -d my_genes.fna -a my_genes.faa

In the second example we add the *-d* and *-a* options to output the nucleotide and amino acid sequences of the predicted genes to files. You can also modify the format of the main output file with *-f* and other options allow you to tailor the algorithm to your application, such as for a metagenome or just to train the algorithm parameters for use on another sequence.

.. admonition:: Exercise 5.1
    :class: exercise

    * Run prodigal on one of the genomes you have previously worked with, either in ``/nfs/course/551-0132-00L/1_Unix1/genomes/bacteria/`` or one you downloaded.
    * Using command line tools, count how many genes were annotated (you can use any of the output formats for this but some are easier than others).

    .. hidden-code-block:: bash

        # Load the module
        ml prodigal

        # Run the program (change the filenames for your genome)
        prodigal -i my_genome.fasta -o my_genome.gbk -d my_genes.fna -a my_genes.faa

        # Count the number of predicted genes
        grep -c "^>" my_genes.fna

Gene prediction in eukaryotes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In eukaryotes, genes are more complicated features, notably with introns and exons that make the prokaryotic approach unworkable. The approach is instead to train a more sophisticated model on existing eukaryotic genes in a closely-related organism and use this model to predict genes in novel sequence. An example of software that does this is GlimmerHMM, available `here <https://ccb.jhu.edu/software/glimmerhmm/>`__. As we said at the start of Comparative Sequence Analysis, it is beyond the scope of this course to look at this further.

Gene function prediction
------------------------

Now we have identified potential protein sequences in our genome, we should try to find their functions using the principle of homology described in the introduction. There are many databases we could search to find similar sequences, but rather than just using the largest possible, we should consider the quality of evidence provided by each. For instance, RefSeq is a more carefully curated set of sequences than GenBank as a whole. Further, evidence of actual protein sequence and function is better than evidence of only transcript. Many resources exist that aim to collect the best quality information about genes and proteins

UniProt
^^^^^^^

A useful resource for protein sequence and function information is the database `UniProt <https://www.uniprot.org/>`__, a collaboration between the European Bioinformatics Institute (EMBL-EBI), the Swiss Institute of Bioinformatics (SIB) and the Protein Information Resource (PIR). Within this project exists Swiss-Prot, which is manually annotated and reviewed, and UniRef, which clusters proteins at certain threshold distances.

.. thumbnail:: images/overview.png
    :align: center

The website allows you to search by text, such as gene name or organism, or by sequence with BLAST. As a brief introduction, let's look at the `entry <https://www.uniprot.org/uniprot/P0AES4>`__ for a well known bacterial protein, DNA Gyrase subunit A or gyrA:

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

When it comes to annotation, we can use UniProt as a database for alignment of our unknown genes. We could also use SwissProt as a narrower but more trustworthy database, since it is manually curated. If we wanted to use broader but more hypothetical information, we could consider looking at **protein domains**.

Pfam
^^^^

In the "Family & Domains" section for Gyrase A, one of the databases linked to is `Pfam <http://pfam.xfam.org/>`__, also run by the EMBL-EBI and indeed based on the data in UniProt. Pfam uses the principle of protein domains, functional regions that each protein has one or more of. A Pfam family consists of a small set of representative members, a multiple alignment of their sequences and a profile Hidden Markov Model (HMM) built from the MSA.

A Pfam HMM is a statistical model that encodes the likelihood of each amino acid at each position along with the likelihood of an insertion or deletion. You can take any sequence and score it with such an HMM to determine whether it is likely to be represented by the model or not, and therefore whether it is likely to be an example of that particular Pfam family.

.. thumbnail:: images/hmm.png
    :align: center

If we look at the Pfam entry for Gyrase A by following the link, we can see that it is composed of two different domains called *DNA topoisoIV* and *DNA gyraseA C*. Let's take a close look at the second of these domains:

.. thumbnail:: images/pfam_gyra.png
    :align: center

Pfam provides several useful pages of information accessible from the menu on the left:

* Summary: describes the domain and references literature to support this.
* Domain organisation: this shows the known layouts of proteins containing the domain.
* Clan: some domains belong to superfamilies of similar domains.
* Alignments: here you can get the sequences and MSAs of various sets of domains - for instance seed domains were used to construct the HMM - in various formats.
* HMM logo: one way to visualise the HMM is with a "logo" where amino acid codes are scaled according to their likelihood.
* Trees: displays the phylogenetic tree for the seed aligment.
* Curation & model: metadata about the Pfam family itself and a link to download the HMM itself.
* Species: a graphical representation of the presence of the Pfam family across species.
* Structures: similar to the UniProt "Structure" entry.
* Alphafold Structures: predicted structures made by the program AlphaFold.
* trRosetta Structures: predicted structures made by the program trRosetta.

To use Pfam effectively, there is a suite of software called HMMER that can be used to both produce and search HMM profiles.

HMMER
^^^^^

HMMER is available `here <http://hmmer.org/>`__, and we have made it available on the module system (``ml HMMER``). We will quickly show you how to build and search with an HMM.

To construct an HMM from an MSA, you should use the program **hmmbuild**:

.. code-block:: bash

    # Build an HMM - note the unusual order with the output file first
    hmmbuild my_hmm.hmm my_msa.fasta

    # Search sequence(s) with an HMM
    hmmsearch my_hmm.hmm my_sequences.fasta

So for annotation, we could take the Pfam family database and check our sequences against it for domains, and those can inform our functional annotation.

.. admonition:: Exercise 5.2
    :class: exercise

    * Annotate the sequence mystery_sequence03.fasta found in ``/nfs/course/551-0132-00L/5_Annotation`` using UniProt and Pfam web resources

    .. hidden-code-block:: bash

        Firstly you will need to download the file to your computer using the R Workbench interface or SCP command from your own machine.

        From the Uniprot website, you can perform a BLAST search of the sequence against the Uniprot database. It should match a variety of XerC proteins from E. coli and Shigella.

        From the Pfam website, you can perform a sequence search, but you will need to first convert the nucleotide sequence to protein sequence. You should find two domains in the protein, both integrases, though not exclusively phage-related as the sequence is from a bacteria.


Automated annotation
--------------------

When you have a whole genome to annotate, you want a program to do as much as possible for you automatically. There are several pipelines available such as the `NCBI Prokaryotic Genome Annotation Pipeline <https://www.ncbi.nlm.nih.gov/genome/annotation_prok/>`__, `PATRIC <https://patricbrc.org/>`__ and `RAST <https://rast.nmpdr.org/>`__. Here we will show you how to use the whole genome annotation program `Prokka <https://github.com/tseemann/prokka>`__, which is a pipeline that uses various feature prediction tools:

* Prodigal for genes
* RNAmmer  for rRNA
* Aragorn  for transfer RNA
* SignalP  for signal peptides
* Infernal for non-coding RNA

Further it searches different databases in a specific order for protein function annotation, ranking them in order of quality:

1. All bacterial proteins in UniProt that have real protein or transcript evidence and are not a fragment.
2. All proteins from finished bacterial genomes in RefSeq for a specified genus.
3. A series of hidden Markov model profile databases, including Pfam and TIGRFAMs.
4. If no matches can be found, label as ‘hypothetical protein’.

We have made Prokka available in our module system under the name ``prokka``. It has some recommended ways of running it, with increasing complexity:

.. code-block:: bash

    # Beginner
    # Vanilla (but with free toppings)
    prokka contigs.fa

    # Moderate
    # Choose the names of the output files
    prokka --outdir mydir --prefix mygenome contigs.fa

    # Specialist
    # Have curated genomes I want to use to annotate from
    prokka --proteins MG1655.gbk --outdir mutant --prefix K12_mut contigs.fa

    # Expert
    # It's not just for bacteria, people
    prokka --kingdom Archaea --outdir mydir --genus Pyrococcus --locustag PYCC

    # Wizard
    # Watch and learn
    prokka --outdir mydir --locustag EHEC --proteins NewToxins.faa --evalue 0.001 --gram neg --addgenes contigs.fa

Those are just examples of course, but you can see that there are many ways to customise the annotation, especially the output.

.. admonition:: Exercise 5.3
    :class: exercise

    * Run prokka on one of the genomes you have previously worked with, either in ``/nfs/course/551-0132-00L/1_Unix1/genomes/bacteria/`` or one you downloaded.
    * How does the annotation differ from the official genbank record? Are there more or fewer genes?

    .. hidden-code-block:: bash

        # Let's choose the name of the output files
        prokka --outdir prokka --prefix my_genome my_genome.fasta

        The annotation could differ in many ways, even the number of genes could be wrong. The genomes we have worked with so far are very well studied and many of their annotations are based on direct observations rather than computational inference.

Annotating other features
-------------------------

Other than genes, there are techniques and software for annotating an array of other features. Many of them use similar methods as we have discussed above - build a statistical model of a feature based on example sequences and use that model to find similar features. This is typical for promoters, binding sites and other sequence motifs.

Homework
--------

.. admonition:: Homework 5
    :class: homework

    | You will annotate and collect some information about SARS-CoV2. To complete the tasks, you need to review the use of commands and programs from previous weeks/courses, and look for additional information. For example, basic knowledge of [R] is expected; however, you can ask your peers for help on Slack and/or consult online resources. After completing the tasks, **you need to take a quiz as a requirement to complete this week's homework.** The quiz is posted on Moodle (`URL: <https://moodle-app2.let.ethz.ch/mod/quiz/view.php?id=734361>`__) under "Quizzes".

    **Tasks:**

    1. Based on the files that were provided to you in Homework 4, find out the length of the SARS-CoV2 genome and how its length compares to all known viruses in the RefSeq virus database.
       
       Here is an example approach. Of course, any other solution that helps answering the quiz question works, too.

      * Review the FASTA format and find out how to use the command grep to select non-matching lines. 
      * Review the use of pipes in UNIX.
      * The length of a string can be printed using the command: ``awk '{print length}'``.
      * Apply these steps to find out the length of SARS-CoV2.
      * Apply these steps to write the lengths of all viral genomes into a file. Import the file into [R] and calculate the mean and median lengths of all viral genomes.

    2. Run Prodigal on the reference sequence of SARS-CoV2 (``NC_045512.fa``) and check how many protein-coding genes are found.

    3. Run hmmsearch to find the genes encoding for the spike glycoprotein S and RNA-dependent RNA polymerase. You can find the HMM models (S.hmm and RdRp.hmm) in the directory ``/nfs/course/551-0132-00L/5_Annotation/homework``.

    **Extra material** (no quiz questions):

    Use the software "bio" to (i) download the genbank file for the reference sequence of the SARS-CoV2, and (ii) to further explore its genomic content.
     
    * How many coding sequences (CDS) are annotated? 
    * How many mature protein regions are annotated? 
    * There are more mature protein regions than CDS. What is the reason for this?

    Further reading:

    `SARS coronavirus 2 / Covid-19 genome expression <https://viralzone.expasy.org/9076>`__

    `The Architecture of SARS-CoV-2 Transcriptome <https://www.sciencedirect.com/science/article/pii/S0092867420304062?via%3Dihub>`__

.. admonition:: Feedback
    :class: homework

    Please consider giving us feedback on this week's lecture and OLM via `Moodle <https://moodle-app2.let.ethz.ch/mod/feedback/view.php?id=731764>`__.

.. container:: nextlink

    `Next: Phylogenetics <6_Phylogenetics.html>`__

