# pca plot code snippet


# required packages
library(DESeq2)
library(ggplot2)


# transform data to use in plot
vsd <- vst(dds, blind = FALSE)

# create PCA plot
pcaData <- plotPCA(vsd, intgroup = c("Weeks_Post_Deletion", "Gender", "Mouse_Genotype_Code", "tissue"), returnData = TRUE)

# view the pca data
pcaData

# get percent variance from PCA plot
percentVar <- round(100 * attr(pcaData, "percentVar"), digits = 2)

# format plot
ggplot(pcaData, aes(x = PC1, y = PC2, color = tissue, shape = Mouse_Genotype_Code)) +
  geom_point() +
  labs(x = paste0("PC1: ", percentVar[1], "% variance"), 
       y = paste0("PC2: ", percentVar[2], "% variance"), 
       color = "Tissue", 
       shape = "Mouse Genotype Code") +
  scale_color_manual(values = c("indianred3", "goldenrod2", "olivedrab", "dodgerblue", "mediumorchid")) +
  guides(color = guide_legend(order = 1), shape = guide_legend(order = 2)) +
  ggtitle("PCA - All data")
