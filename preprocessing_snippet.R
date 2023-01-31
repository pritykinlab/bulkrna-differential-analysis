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
exons <- gencode[gencode$type == 'exon']
exons_genes <- disjoin(split(exons, factor(exons$gene_name, levels = genes)))