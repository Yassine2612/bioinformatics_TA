Connect parts/Outlook
=====================


Main objective
^^^^^^^^^^^^^^

You will combine your general knowledge in biology and apply some of the practical skills you acquired during the past weeks. 

Resources
^^^^^^^^^

This section requires the use of the R Workbench according to your **surname**:

* A-J: `Server 01 <https://rstudio-teaching-01.ethz.ch/>`__
* K-R: `Server 02 <https://rstudio-teaching-02.ethz.ch/>`__
* S-Z: `Server 03 <https://rstudio-teaching-03.ethz.ch/>`__

In-class-project
^^^^^^^^^^^^^^^^
We will develop together a workplan on how to reconstruct the evolution of SARS-CoV2 since the sampling of the reference strain (Genbank accession ID: MN908947). You are the expert now!

Identify major steps of how to approach this. The more detailed (e.g., using pseudo-code), the better. 

``Required Background information``
Metadata table: ``/nfs/course/551-0132-00L/7_Connections/SARS-CoV2.metadata.curated.tsv``
`SARS-CoV2 nomenclature: <https://en.wikipedia.org/wiki/Variants_of_SARS-CoV-2>`__

   .. hidden-code-block:: bash
      IFS=$'\n'
      #Unique Nextstrain clades:
      cut -f19 SARS-CoV2.metadata.curated.tsv | grep -v Nextstrain | sort -u > nextstrain.clades.txt

      #Get accession numbers of unique Nextstrain clades:
      for x in $(cat nextstrain.clades.txt); do grep $x -m1 SARS-CoV2.metadata.curated.tsv ; done | cut -f4 | sort -u > accession.numbers.txt

      #Add accession number of reference strain (MN908947) #or closest non-human SARS-Cov2 (NC_045512)
      echo "MN908947" >> accession.numbers.txt

      #Get genomes as Genbank or FASTA files
      ml Bio
      for x in $(cat accession.numbers.txt); do bio fetch $x; done > sars_cov2.selected.gbk
      for x in $(cat accession.numbers.txt); do bio fetch $x | bio fasta; done > sars_cov2.selected.fa

      #Parse protein S from Genbank file using a biopython script
      python ./parse.S.py sars_cov2.selected.gbk > sars_cov2.selected.proteinS.faa

      #Alternative: identify protein S using prodigal and HMM
      ml prodigal
      prodigal -i sars_cov2.selected.fa -a sars_cov2.selected.faa
      ml HMMER
      hmmsearch --tblout sars_cov2.selected.out /nfs/course/551-0132-00L/5_Annotation/homework/S.hmm sars_cov2.selected.faa 
      cut -f1 -d" " sars_cov2.selected.out| grep -v "#" > sars_cov2.selected.prodigal.accessions.txt

      #Get FASTA
      ml BLAST+
      makeblastdb -in sars_cov2.selected.faa -dbtype prot -parse_seqids -out sars_cov2.selected
      blastdbcmd -db sars_cov2.selected -entry_batch sars_cov2.selected.prodigal.accessions.txt > sars_cov2.selected.prodigal.faa

      #Compute tree on command line
      ml MUSCLE
      ml FastTree
      ml ETE
      muscle -in sars_cov2.selected.prodigal.faa | fasttree
