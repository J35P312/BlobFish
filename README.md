# BlobFish
Differential expression analysis using DEseq2 and Salmon

Under construction!

The pipeline  is based on:

http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

# Run

	Rscript BlobFish.R --sample <samplesheet.txt> --tx <transcript2gene.txt> --folder <salmon_file_folder>  > Table.csv


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
