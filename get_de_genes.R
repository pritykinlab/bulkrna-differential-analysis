# function to extract significant differentially expressed genes


# required packages
library(DESeq2)


# dds is a deseq object
# col is the column of interest
# cont1 is the first contrast element
# cont2 is the second contrast element
get_de_genes <- function(dds, col, cont1, cont2) {
    
    # extract de genes
    dds <- DESeq(dds)
    
    # get results from deseq
    res <- results(dds, contrast = c(col, cont1, cont2))
    
    # sort the results by padj
    res <- res[order(res$padj), ]
    
    # save the results to a file
    write.csv(as.data.frame(res), file = "res1.csv")
    
    return(list("dds" = dds, "res" = res))
}

