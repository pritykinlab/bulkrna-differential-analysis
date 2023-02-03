# preprocessing code snippet


# required packages
library(SummarizedExperiment)


# create function to normalize counts in deseq object
# assume rowRanges is a non-empty GRangesList and size factors were already computed (ex: using estimateSizeFactors())
normCounts <- function(se) {
  gene_length <- sum(width(rowRanges(se)))
  counts_norm <- apply(counts(se, normalized = TRUE), 2, 
                       function(x) {
                         1e3 * x / gene_length
                       })
  assays(se)$counts_norm <- counts_norm
  return(se)
}


# prepare collection of all exons for genes in gencode 
# only want exons, not introns, because introns are not expressed
genes <- levels(as.factor(gencode$gene_name))

# use only 1 of the following lines of code (to select either all exons or only protein coding exons, respectively)

# all exons
exons <- gencode[gencode$type == 'exon']

# only protein coding genes
exons <- gencode[(gencode$gene_type == 'protein_coding') & (gencode$type == 'exon')]


exons_genes <- disjoin(split(exons, factor(exons$gene_name, levels = genes)))