# BlobFish
BlobFish is a wrapper around the DEseq2 differential expression analysis tool. 
BlobFish is an R package that accepts Salmon output.

The wrapper is based on:

http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

# Run

	Rscript BlobFish.R --sample <samplesheet.txt> --tx <transcript2gene.txt> --folder <salmon_file_folder>  > Table.csv

The samplesheet is a text file containing at least two columns, the "run" column and "condition" column:

run condition
run1 A
run2 A
run3 B
run4 B
run5 B

Where the run column is the name of the run, and condition tells which group/condition each run belongs to.
The transcript2gene file is a text file describing the gene name of each transcript:

TXNAME,GENEID
TX1,geneA
TX2,geneB
TX3,geneB

# Dependencies

	DESeq2
	readr
	tximport
	optparse

# Install

Use miniconda:

	conda install -c bioconda bioconductor-deseq2	
	conda install -c bioconda r-readr
	conda install -c bioconda r-optparse
	conda install -c bioconda bioconductor-tximport

Once these packages are installed, you can run the Deseq2 analysis using BlobFish
