# BlobFish
BlobFish is a wrapper around the DEseq2 differential expression analysis tool. 
BlobFish is an R package that accepts Salmon output.

The wrapper is based on:

http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

# Run
There are two ways of running BlobFish, either throgh the R script, or through the pythos script which is a wrapper around the R script.

	Rscript BlobFish.R --sample <samplesheet.txt> --tx <transcript2gene.txt> > Table.csv

or use the python script:

	python BlobFish.py --allvsall --sample A A A B --tx <transcript2gene.txt> --path salmon_out_1 salmon_out_2 salmon_out_3 salmon_out_4 --dir <output>

Here, salmon_out is the output path of salmon.

The samplesheet is a text file containing at least two columns, the "run" column and "condition" column:

	run condition path
	run1 A salmon_out_path_1/quant.sf
	run2 A salmon_out_path_2/quant.sf
	run3 B salmon_out_path_3/quant.sf
	run4 B salmon_out_path_4/quant.sf
	run5 B salmon_out_path_5/quant.sf

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
