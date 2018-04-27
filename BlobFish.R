
#The differential expression analysis tools
suppressMessages(library("DESeq2"))

#Other functions for reading the salmon input
library("readr")
library("tximport")
library("optparse")
 
option_list = list(
  make_option(c("-f", "--folder"), type="character", default=NULL,help="input folder", metavar="character"),
  make_option(c("-s", "--sample"), type="character", default=NULL,help="sample sheet", metavar="character"),
  make_option(c("-t", "--tx"), type="character", default=NULL,help="tx2gene path", metavar="character"),
  make_option(c("-v", "--version"), default=FALSE, action = "store_true", help="Print version number")
); 
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);
dir=opt$folder

if ( is.null(opt$sample) ) {
	stop("--sample parameter must be provided. See script usage (--help)")
}
if ( is.null(opt$tx) ) {
        stop("--tx parameter must be provided. See script usage (--help)")
}
if ( is.null(opt$folder) ) {
        stop("--folder parameter must be provided. See script usage (--help)")
}

if ( isTRUE(opt$version) ) {
	message ("BlobFish version 0.1.0")
	quit()
}


samples <- read.table(file.path(opt$sample), header=TRUE)
rownames(samples) <- samples$run

files <- file.path(opt$folder , samples$run, "quant.sf")
names(files) <- samples$run

tx2gene <- read_csv(file.path(opt$tx))
txi <- tximport(files, type="salmon", tx2gene=tx2gene)

ddsTxi <- DESeqDataSetFromTximport(txi,colData = samples,design = ~ condition)
dds <- DESeq(ddsTxi)
res <- results(dds)

write.table(res,file="")
