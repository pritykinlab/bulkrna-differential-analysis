
# genes heatmap code snippet

# normalize the deseq object
normalized_counts_most_variable_20 <- counts(dds, normalized = TRUE)

# get 20 most variable genes
normalized_counts_most_variable_20 <- normalized_counts_most_variable_20[order(rowVars(normalized_counts_most_variable_20), decreasing = TRUE), ][1:20, ]

# normalize data
normalized_counts_most_variable_20 <- log2(normalized_counts_most_variable_20 + 1)

# create dataframe for annotations
samples_list_20 <- colnames(normalized_counts_most_variable_20)
samples_list_df_20 <- metadata_cleaned[metadata_cleaned$filename==samples_list_20,]
samples_list_df_tmp_20 <- data.frame(samples_list_df_20[, c('Mouse_Genotype_Code', 'Gender', 'tissue')])
rownames(samples_list_df_tmp_20) <- samples_list_df_20$filename
samples_list_df_20 <- samples_list_df_tmp_20
colnames(samples_list_df_20) <- c("Mouse Genotype Code", "Gender", "Tissue")

# create list of annotation colors
ann_colors_20 <- list(Tissue = c(BAT = "indianred3", Cerebellum = "goldenrod2", GNP = "olivedrab", iWAT = "dodgerblue", Liver = "mediumorchid"),
                   "Mouse Genotype Code" = c(KO = "lightblue4", WT = "palegreen3"),
                   Gender = c(Male = "lightskyblue2", Female = "lightpink1"))

# draw heatmap
pheatmap(normalized_counts_most_variable_20, scale = "row", cluster_cols = TRUE, annotation_col = samples_list_df_20, annotation_colors = ann_colors_20, color = colorRampPalette(c("navy", "white", "red"))(100), main = "20 Most Variable Genes")

