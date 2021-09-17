
Data (5 min)
============

For this course we will use public datasets from `Heintz-Buschart, A. et al. Integrated multi-omics of the human gut microbiome in a case study of familial type 1 diabetes <https://www.nature.com/articles/nmicrobiol2016180>`_.

This study comprises in total 89 sequencing datasets of which 53 come from metagenomic and 36 come from metatranscriptomic sequencing. We will use the samples for which there're paired metatranscriptomic and metagenomic samples.

Forward and reverse read files for all samples can be found here: ``/nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/data``.

.. code-block:: bash

   ls /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/data

     M01.1-V1-stool-metaG
     M01.2-V3-stool-metaG
     M01.4-V2-stool-metaT
     M02.1-V3-stool-metaT
     ...

   ls /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/data/M01.1-V1-stool-metaG/*

     M01.1-V1-stool-metaG/M01.1-V1-stool-metaG.1.fq.gz # forward read file
     M01.1-V1-stool-metaG/M01.1-V1-stool-metaG.2.fq.gz # reverse read file

You will perform the first steps of analysis (QC and mOTUsv2) on **two** datasets that is linked to your own folder (e.g. ``/nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35`` for the user with username ``biolcourse-35``\ ).

The user ``biolcourse-35`` has 4 files in the folder:

.. code-block:: bash


   ls /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35

     M04.6-V2-stool-metaG.1.fq.gz # forward metag read file
     M04.6-V2-stool-metaG.2.fq.gz # reverse metag read file
     M04.6-V2-stool-metaT.1.fq.gz # forward metat read file
     M04.6-V2-stool-metaT.2.fq.gz # reverse metat read file

Everyone will have a different sample to work on. That is why we refer to read files the following:

.. code-block::


   for user biolcourse-35

   <forward metag raw reads> --> /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/M04.6-V2-stool-metaG.1.fq.gz
   <reverse metag raw reads> --> /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/M04.6-V2-stool-metaG.2.fq.gz
   <forward metat raw reads> --> /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/M04.6-V2-stool-metaT.1.fq.gz
   <reverse metat raw reads> --> /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/M04.6-V2-stool-metaT.2.fq.gz

Quality Control (15 min)
========================

The sequence files that you download from your sequencing center usually come with only basic quality control performed. E.g. The sequencing center knows when a run failed and will not deliver those results. Consequently the quality control of raw sequencing data is your first task before starting any downstream analysis. 

There is a large number of tools that perform Read QC. But most tools try to perform three crucial steps:


#. **Remove Adapters** - Before sequencing you add adapters to the inserts in order for it to bind to the flowcell. The sequencer sometines reads into those adapters --> Need to remove beginning/end of the sequence that contains adapter sequences.
#. **Contamination** - Your metagenomic sample contains host DNA (e.g. Human) or artifical spike-ins (e.g. Phi X) which is then being sequenced --> Remove full sequences that come from host contamination.
#. **Base Quality** - The most common error in Illumina sequencing is the introduction of wrong bases (mutations not indels) into the resulting sequence. This problem is especially prominent towards the end of the sequences. --> Remove the low quality tail of sequences based on quality scores. 

We will run a pipeline that combines all three steps and creates qc'ed read files that we can use as input for mOTUsv2.

*There're many options on how to tweak the performance of the QC step. We use a similar pipeline in our lab and we're confident that it produces solid results. For your own data you will need to look into the pipeline and find parameters that suit your analysis best.*

**Don't execute the following commands. We provide a script that runs the commands for your on the cluster.**

Adapter removal
---------------

.. code-block:: bash

   bbduk.sh -Xmx6G usejni=t threads=10 overwrite=t qin=33 in1=<forward metag/metat raw reads> 
   in2=<reverse metag/metat raw reads> ref=/nfs/nas22.ethz.ch/fs2201/biol_isg_course_1/Workshop_Bern/bin/bbmap/resources/adapters.fa \
   ktrim=r k=23 mink=11 hdist=1 out1=<forward metag/metat noAdapter reads>  \
   out2=<reverse metag/metat noAdapter reads> pigz=t bgzip=f &> adapterRemoval.log

Contamination removal (Phi X)
-----------------------------

.. code-block:: bash

   bbduk.sh -Xmx6G usejni=t threads=2 overwrite=t qin=33 in1=<forward metag/metat noAdapter reads> \
   in2=<reverse noAdapter reads> out1=<forward metag/metat noAdapter_noPhiX reads> \
   out2=<reverse metag/metat noAdapter_noPhiX reads> ref=/nfs/nas22.ethz.ch/fs2201/biol_isg_course_1/Workshop_Bern/bin/bbmap/resources/phix174_ill.ref.fa.gz \
   k=31 hdist=1 pigz=t bgzip=f &> phixRemoval.log

Low Quality Bases removal
-------------------------

.. code-block:: bash

   bbduk.sh -Xmx6G usejni=t threads=10 overwrite=t qin=33 in1=<forward metag/metat noAdapter_noPhiX reads> \
   in2=<reverse metag/metat noAdapter_noPhiX reads>  out1=<forward metag/metat reads>  \
   out2=<reverse metag/metatreads> minlength=45 qtrim=r maq=20 maxns=1 overwrite=t trimq=30 pigz=t bgzip=f &> qc.log

Execution of Quality Control
============================

Creating 6 commands (3*metag and 3*metat) and executing them one after another would take too much time. We have prepared a command that will execute the QC for you.

You find the command in:

.. code-block:: bash

   # replace biolcourse-35 with your personal account number
   less /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/qc.sh

The command can be executed using:

.. code-block:: bash

   # replace biolcourse-35 with your personal account number
   /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/qc.sh

The execution will take a couple minutes and will generate the following files:

.. code-block:: bash


   cd /nfs/nas22/fs2201/biol_isg_course_1/Workshop_Bern/biolcourse-35/
   ls
     M04.6-V2-stool-metaG.qc.1.fq.gz --> <forward metag read file> (Input for mOTUsv2)
     M04.6-V2-stool-metaG.qc.2.fq.gz --> <reverse metag read file> (Input for mOTUsv2)
     M04.6-V2-stool-metaT.qc.1.fq.gz --> <forward metat read file> (Input for mOTUsv2)
     M04.6-V2-stool-metaT.qc.2.fq.gz --> <reverse metat read file> (Input for mOTUsv2)
     adapterRemoval.log              --> stats on adapter removal
     phixRemoval.log                 --> stats on phix removal
     qc.log                          --> stats on low quality base removal

.. code-block:: bash


   cat adapterRemoval.log
     ...
     Input:                          40429612 reads              3528670429 bases.
     KTrimmed:                          25871 reads (0.06%)          299666 bases (0.01%)
     Total Removed:                         8 reads (0.00%)          299666 bases (0.01%)
     Result:                         40429604 reads (100.00%)    3528370763 bases (99.99%)
     ...

   cat phixRemoval.log
     ...
     Input:                    40429604 reads              3528370763 bases.
     Contaminants:                    0 reads (0.00%)             0 bases (0.00%)
     Total Removed:                   0 reads (0.00%)             0 bases (0.00%)
     Result:                   40429604 reads (100.00%)    3528370763 bases (100.00%)
     ...

   cat qc.log
     ...
     Input:                    40429604 reads              3528370763 bases.
     QTrimmed:                 10584630 reads (26.18%)      141547297 bases (4.01%)
     Low quality discards:      1692080 reads (4.19%)      98482891 bases (2.79%)
     Total Removed:             3001294 reads (7.42%)     240030188 bases (6.80%)
     Result:                   37428310 reads (92.58%)     3288340575 bases (93.20%)
     ...
