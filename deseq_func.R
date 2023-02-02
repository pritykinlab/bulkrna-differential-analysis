# function to run deseq


# required libraries
library(SummarizedExperiment)
library(DESeq2)
library(glue)


# se is a SummarizedExperiment object
# col is the column of interest
# ... can contain 0 or more adjustors the adjustors
deseq_func <- function(se, col, ...) {
    
    # create string to hold adjustors
    adj = "~"
    
    # add the adjustors to the adjustors string
    for(i in list(...)) {
        adj <- paste(adj, glue("{i}+"), sep="")
    }
    
    # add the column of interest and the adjustors to the design
    design <- paste(adj, col, sep="")
    
    # convert design into a formula
    design = as.formula(design)
    
    # create deseq object
    dds <- DESeqDataSet(se, design = design)
    
    # estimate size factors
    dds <- estimateSizeFactors(dds)
    
    # use the normCounts() function to normalize the counts
    dds <- normCounts(dds)
    
    # get the assays of the gene counts
    assays(se)$counts_norm <- assays(dds)$counts_norm
    
    # normalize the deseq object
    normalized_counts <- counts(dds, normalized = TRUE)
    
    # return the normalized counts and a matrix of the normalized counts
    return(list("dds" = dds, "normalized_counts" = normalized_counts))
    
}


