# samples heatmap code snippet

# normalize the deseq object
normalized_counts <- counts(dds, normalized = TRUE)

# get normalized counts correlation
normalized_counts_cor <- cor(normalized_counts, method = "spearman")

# create heatmap
pheatmap(normalized_counts_cor, color = colorRampPalette(c("navy", "white", "red"))(100))