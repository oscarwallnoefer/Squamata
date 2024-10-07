library(tidyverse)
library(reshape2)

completeness_matrix <- read.csv("completeness_matrix_nucox.csv")
completeness_long <- melt(completeness_matrix, id.vars = "Species")
completeness_long$value <- ifelse(completeness_long$value == "TRUE", "TRUE", "FALSE")

gene_order <- c("NDUFA1", "NDUFA2", "NDUFA3", "NDUFA4", "NDUFA5", "NDUFA6", "NDUFA7", 
                "NDUFA8", "NDUFA9", "NDUFA10", "NDUFA11", "NDUFA12", "NDUFA13", "NDUFAB1", 
                "NDUFB10", "NDUFB11", "NDUFB1", "NDUFB2", "NDUFB3", "NDUFB4", "NDUFB5", 
                "NDUFB6", "NDUFB7", "NDUFB8", "NDUFB9", "NDUFC1", "NDUFC2", "NDUFS1", 
                "NDUFS2", "NDUFS3", "NDUFS4", "NDUFS5", "NDUFS6", "NDUFS7", "NDUFS8", 
                "NDUFV1", "NDUFV2", "NDUFV3", "SDHA", "SDHB", "SDH3", "SDH4", "QCR2", 
                "QCR6", "QCR7", "QCR8", "QCR9", "QCR10", "CYC1", "UQCRFS1", "COX4", 
                "COX5A", "COX5B", "COX6A", "COX6B", "COX6C", "COX7A", "COX7B", "COX7C",  
                "COX10", "COX11", "COX15", "COX17", "ATP5A1", "ATP5B", "ATP5C1", "ATP5D", 
                "ATP5E", "ATP5F1", "ATP5G", "ATP5J", "ATP5L", "ATP5O")


ggplot(completeness_long, aes(x = factor(variable, levels = gene_order), y = Species, fill = value)) +
    geom_tile(color = "black", size = 0.5) +  
    scale_fill_manual(values = c("TRUE" = "white", "FALSE" = "red"), 
                      name = "Legend") +
    labs(x = "nucOXPHOS", y = "Species") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
          axis.text.y = element_text(face = "italic", size = 8),  
    panel.grid = element_blank()) 
