#The differential expression analysis tools
library("DESeq2", lib.loc="~/miniconda2/lib/R/library")

#Other functions for reading the salmon input
library("readr",lib.loc="~/miniconda2/lib/R/library")
library("tximport",lib.loc="~/miniconda2/lib/R/library")

#source("https://bioconductor.org/biocLite.R")
#biocLite("tximportData")
library("tximportData")

dir <- system.file("extdata", package="tximportData")
samples <- read.table(file.path(dir,"samples.txt"), header=TRUE)
samples$condition <- factor(rep(c("A","B"),each=3))
rownames(samples) <- samples$run
samples[,c("pop","center","run","condition")]

files <- file.path(dir,"salmon", samples$run, "quant.sf")
names(files) <- samples$run
tx2gene <- read_csv(file.path(dir, "tx2gene.csv"))

txi <- tximport(files, type="salmon", tx2gene=tx2gene)

ddsTxi <- DESeqDataSetFromTximport(txi,
                                   colData = samples,
                                   design = ~ condition)
dds <- DESeq(ddsTxi)
res <- results(dds)
