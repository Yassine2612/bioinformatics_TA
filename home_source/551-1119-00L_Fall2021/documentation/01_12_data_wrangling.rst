Solutions to the data wrangling session
=======================================

Find below an example script on how to address the questions from the previous session. Keep in mind that the paths to the files would need to be modified.

.. code-block:: r


    library(tidyverse)

    ### READ IN ASV TABLES FROM TWO RUNS
    # 16S data batch01
    dat.otu01 <- read.table("/Volumes/biol_micro_sunagawa/Projects/EAN/PHRT_EAN/data/processed/metaB/batch01_APR21/AML_PHRT.data.table", header = T, sep = "\t")
    dat.otu01.t <- t(dat.otu01)

    tax01 <- dat.otu01[,1:2]

    dat.otu01 <- dat.otu01%>%
      tibble::column_to_rownames("seq")%>%
      select(-tax)

    # 16S data batch02
    dat.otu02 <- read.table("/Volumes/biol_micro_sunagawa/Projects/EAN/PHRT_EAN/data/processed/metaB/batch02_NOV21/AML_PHRT_NOV2021.data.table", header = T, sep = "\t")
    tax02 <- dat.otu02[,1:2]

    dat.otu02 <- dat.otu02%>%
      tibble::column_to_rownames("seq")%>%
      select(-tax)


    ### MERGE SEQUENCE TABLES
    library(dada2)
    dat.otu.merged <- t(mergeSequenceTables(t(dat.otu01), t(dat.otu02)))
    dim(dat.otu.merged) # 12158   168

    # Remove all Novogene-samples
    # base-r version
    colnames(dat.otu.merged)
    indices <- grep("NOVOGENE", colnames(dat.otu.merged))
    dat.otu.merged.sushi <- dat.otu.merged[,-indices]
    colnames(dat.otu.merged.sushi)
    dim(dat.otu.merged.sushi) # 12158   116

    # tidyverse version
    dat.otu.merged %>%
      rownames_to_column("seq") %>%
      select(!contains("NOVOGENE")) %>%
      as.data.frame() %>%
      column_to_rownames("seq") %>%
      as.matrix()

    # remove ASVs that now have 0 abundance in any sample
    dat.otu.merged.sushi <- dat.otu.merged.sushi[rowSums(dat.otu.merged.sushi)!=0,]
    dim(dat.otu.merged.sushi)  # 3344   116

    ## read-in clinical data (processed)
    aml.dat.long <- read.table("/Volumes/biol_micro_sunagawa/Projects/EAN/PHRT_EAN/data/processed/Analysis/clinical_data_long_20210803.txt", sep = "\t", header = T)

    samp.names.clean <- str_sub(colnames(dat.otu.merged.sushi), 5, -13)

    intersect(samp.names.clean, aml.dat.long$Sample_Name) # sequenced samples
    setdiff(aml.dat.long$Sample_Name, samp.names.clean) # samples not yet sequenced

    # sort out miss-matches between sample names in metadata and sample names in ASV table
    setdiff(samp.names.clean, aml.dat.long$Sample_Name)
    # sample P004S4_B in ASV table: Two aliquots have been taken for P004S4 (A and B). A was taken by mistake, so B is the correct sample. So the sample P004S4_B in the ASV table can be re-labelled to P004S4

    grep("P004S4", colnames(dat.otu.merged.sushi))
    colnames(dat.otu.merged.sushi)[20] <- "AML_P004S4_SUSHI_METAB"

    # sample P012S5_1 in ASV table: the raw sample processing list has a note saying "tube was labelled P010S5"
    grep("P010S5", aml.dat.long$Sample_Name) # 59
    grep("P010S5", colnames(dat.otu.merged.sushi)) # does not exist
    # --> rename P012S5_1 to P010S5
    grep("P012S5_1", colnames(dat.otu.merged.sushi)) # 36
    colnames(dat.otu.merged.sushi)[36] <- "AML_P010S5_SUSHI_METAB"

    # P018S5 and P018S5_1 both have a note in raw sample processing list saying that the poo tube in the freezer box was labelled P013S5. Have to check if the composition of either of them resembles more P018 or P013 before deciding which one is which.
    grep("P013S5", aml.dat.long$Sample_Name)
    grep("P013S5", colnames(dat.otu.merged.sushi))

    grep("P018S5", aml.dat.long$Sample_Name)

    ## fix column names of ASV table
    colnames(dat.otu.merged.sushi) <- str_sub(colnames(dat.otu.merged.sushi), 5, -13)

    length(colnames(dat.otu.merged.sushi)) # 116
    metadata.asv.intersect <- intersect(colnames(dat.otu.merged.sushi), aml.dat.long$Sample_Name) # 97

    # final ASV table
    aml.metab.asv <- dat.otu.merged.sushi[,colnames(dat.otu.merged.sushi)%in%metadata.asv.intersect]
    dim(aml.metab.asv) # 3344   97
    write.table(aml.metab.asv, "aml.metab.asv.txt", sep = "\t")

    # final metadata table for metaB
    aml.metab.meta <- aml.dat.long[aml.dat.long$Sample_Name%in%metadata.asv.intersect,]
    write.table(aml.metab.meta, "aml.metab.meta.txt", sep = "\t")

    # summary on data availability - metaB
    length(table(aml.metab.meta$PatientID))
    mean(table(aml.metab.meta$PatientID, aml.metab.meta$Time.point))
    table(aml.metab.meta$Time.point)
