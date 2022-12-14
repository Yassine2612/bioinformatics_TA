Sunagawa Lab Block Course Fall 2021: 551-1119-00L  Microbial Community Genomics
===============================================================================

General information
-------------------


* Course dates: 09.11.2021 - 01.12.2021

  * Week 1: Tue 1:30PM - 5PM, Wed - Fri 8:30AM - 5PM
  * Week 2: Tue 1:30PM - 5PM, Wed - Fri 8:30AM - 5PM
  * Week 3: Tue 1:30PM - 5PM, Wed - Fri 8:30AM - 5PM
  * Week 4: Tue 1:30PM - 5PM, Wed - Wed 8:30AM - 5PM

* Exam: 30.11.2021, 13:30 - 15:30
* Presentation: 01.12.2021, 13:30 - 16:00

* Tutors:

  * Melanie melanie.lang@ethz.ch
  * Guillem guillems@ethz.ch
  * Hans hansr@ethz.ch

Useful resources
----------------

* RStudio server site: https://rstudio-teaching.ethz.ch/
* ZOOM room: https://ethz.zoom.us/j/62465809040

Student Projects
----------------

* Project 1 (Mads & Elina): **Patient gut microbiome and patient response to intensive chemotherapy in AML**
* Project 2 (Gioia & Lena): **Patient gut microbiome and patient risk of developing neutropenic enterocolitis as a consequence of intensive chemotherapy in AML**
* Project 3 (Dennis & Léa): **Potential of AML patient gut microbiome to interact with chemotherapeutic drugs used during intensive induction chemotherapy**
* Project 4 (unassigned): Functional redundancy in AML patient gut microbiome
* Project 5 (unassigned): Bacterial population structure in AML patients
* Project 6 (Marius & Manuel): **Investigate the uncharted diversity of the gut microbiome in AML patients**

Find more details in the :download:`Project presentation <documentation/01_14_student_projects.pdf>`

Data availability
-----------------

The following data is available for the development of the projects:

In general, DNA extracted from fecal samples collected from AML patients undergoing intensive chemotherapy have been sequenced using

- 16S amplicon sequencing
- metagenomic shotgun sequencing

All computed data can be found at ``/nfs/course/551-1119-00L_masterdata/projects`` with the following folder structure:

- ``16S``

  - ``aml_metab_ASV_BC_HS21.txt``: ASV table containing all samples that have been sequenced using 16S amplicon sequencing
  - ``aml_metab_tax_BC_HS21.txt``: Taxonomy table containing the sequences of individual ASVs and their taxonomic annotation as derived using mTAGs

- ``metaG``:

  - ``gene_catalog``:

    - ``AML_115_METAG_cdhit9590.functional_profile_insertcounts.lengthnorm.cellab.withKEGG.profile.gz``: Functional profile of the gene catalog. Per cell abundance of each KO.
    - ``AML_115_METAG_cdhit9590.functional_profile_insertcounts.profile.gz``: Functional profile of the gene catalog. Number of reads of each KO. **This table is not normalized and is only intended to be used for rarefaction and downstream alpha diversity analyses**.
    - ``AML_115_METAG_cdhit9590.gene_profile_insertcounts.lengthnorm.cellab.withKEGG.profile.gz``: Gene profile of the gene catalog. Per cell abundance of each gene x 1000

  - ``MAGs``:

    - ``gtdbtk.ar122.summary.tsv``: Taxonomic information on the MAGs out of GTDB (Archaea)
    - ``gtdbtk.bac120.summary.tsv``: Taxonomic information on the MAGs out of GTDB (Bacteria)

  - ``mOTUs``:

    - ``aml_metag_motus_BC_HS21.txt``: Microbial abundance profiles for all samples sequenced using shotgun metagenomic sequencing as derived using mOTUs

- ``auxiliary_data``:

  - ``clinical_data``:

    - ``AML_metadata_BC_HS21.txt``: File containing all available clinical metadata from patients enrolled within the AML study as of per OCT2021
    - ``AML_Antiinfectives.txt``: File containing the usage scheme of all antiinfective drugs given to patients enrolled within the AML study as per AUG2021
    - ``AML_AntineoplasticAgents.txt``: File containing the usage scheme of all antineoplastic drugs given to patients enrolled within the AML study as per AUG2021

  - ``DGIdb_KEGG``:

    - ``interactions_withKO.tsv``: Interaction table from DGIdb with the KO annotation for all genes.


Agenda
------

Week 1
^^^^^^

=====  =====  ==============  =================================================
W1.1   09.11  13:30 - 15:00   :download:`Introductory lecture <documentation/01_01_Intro.pdf>`
W1.2   09.11  15:30 - 17:00   :doc:`Setup infrastructure <documentation/01_02_setup>`
W1.3   10.11  08:30 - 10:00   :download:`Lecture on omics techniques & data <documentation/01_03_OMICS_lecture.pdf>`
W1.4   10.11  10:30 - 12:00   :doc:`Introduction to R <documentation/01_04_Introductio_to_R>`
W1.5   10.11  13:30 - 15:00   :download:`Lecture on metagenome-assembled genomes (MAGs) <documentation/01_05_Intor_MAGs.pdf>`
W1.6   10.11  15:30 - 17:00   :doc:`Data transformation with R: tidyverse <documentation/01_06_tidyverse>`
W1.7   11.11  08:30 - 10:00   :doc:`Data visualization with R: ggplot2 <documentation/01_07_ggplot2>`
W1.8   11.11  10:30 - 12:00   :download:`16S rRNA gene amplicon pipeline (lecture) <documentation/01_08_DADA2_lecture.pdf>`
W1.9   11.11  13:30 - 15:00   :doc:`16S rRNA gene amplicon pipeline (tutorial) <documentation/01_09_dada2_pipeline>`
W1.10  11.11  15:30 - 17:00   :download:`Describing microbial community structure (Concept Course lecture) <documentation/01_10_CC_Bioinformatics.Metagenomics1.pdf>` and :download:`Introduction to alpha and beta-diversity <documentation/01_10_Diversity_Intro.pdf>`
W1.11  12.11  08:30 - 10:00   :doc:`Describing microbial community structure (Concept Course tutorial) <documentation/01_11_Diversity_tutorial>`
W1.12  12.11  10:30 - 12:00   :download:`Data wrangling (hands-on session) <documentation/01_12_data_wrangling.pdf>`
W1.13  12.11  13:30 - 15:00   :doc:`Data wrangling solutions <documentation/01_12_data_wrangling>`
W1.14  12.11  15:30 - 17:00   :download:`Wrap-up and plan W2 <documentation/01_14_student_projects.pdf>`
=====  =====  ==============  =================================================

Week 2
^^^^^^

=====  =====  ==============  =================================================
W2.1   16.11  13:30 - 15:00   Plan group projects
W2.2   16.11  15:30 - 17:00   Group projects
W2.3   17.11  08:30 - 10:00   :download:`Lecture on best practices for data/project/software management <documentation/02_03_good_practices.pdf>`
W2.4   17.11  10:30 - 12:00   Group projects
W2.5   17.11  13:30 - 15:00   Group projects
W2.6   17.11  15:30 - 17:00   Group projects
W2.7   18.11  08:30 - 10:00   Group projects
W2.8   18.11  10:30 - 12:00   Group projects
W2.9   18.11  13:30 - 15:00   Group projects
W2.10  18.11  15:30 - 17:00   Group projects
W2.11  19.11  08:30 - 10:00   Group projects
W2.12  19.11  10:30 - 12:00   Group projects
W2.13  19.11  13:30 - 15:00   Present progress by each group & Discussion
W2.14  19.11  15:30 - 17:00   Wrap-up and plan W3
=====  =====  ==============  =================================================

Week 3
^^^^^^

=====  =====  ==============  =================================================
W3.1   23.11  13:30 - 15:00   :download:`Lecture on report writing <documentation/03_01_ReportWriting_Guidelines.pdf>` (check also the :download:`report example <documentation/03_01_Report_example.pdf>`)
W3.2   23.11  15:30 - 17:00   :download:`ANOVA and DESeq2 <documentation/03_01_ANOVA_DESeq2.pdf>`
W3.3   24.11  08:30 - 10:00   Group projects
W3.4   24.11  10:30 - 12:00   Group projects
W3.5   24.11  13:30 - 15:00   Group projects
W3.6   24.11  15:30 - 17:00   Group projects
W3.7   25.11  08:30 - 10:00   Group projects
W3.8   25.11  10:30 - 12:00   Group projects
W3.9   25.11  13:30 - 15:00   Group projects
W3.10  25.11  15:30 - 17:00   Present progress by each group & Discussion
W3.11  26.11  08:30 - 10:00   Group meeting
W3.12  26.11  10:30 - 12:00   Freeze results of group projects
W3.13  26.11  13:30 - 15:00   Freeze results of group projects
W3.14  26.11  15:30 - 17:00   Wrap-up and plan W4
=====  =====  ==============  =================================================

Week 4
^^^^^^

====  =====  =============  ==================================================
W4.1  30.11  13:30 - 15:30  **Exam**
W4.2  30.11  16:00 - 17:00  Prepare presentation
W4.3  01.12  08:30 - 10:00  Prepare presentation
W4.4  01.12  10:30 - 12:00  Prepare presentation
W4.5  01.12  13:30 - 16:00  **Presentations**
W4.6  01.12  16:30 - 17:00  BlockCourse wrap-up
====  =====  =============  ==================================================
