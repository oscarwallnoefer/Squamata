library(ggplot2)

nomi_geni <- c("NDUFA1", "NDUFA2", "NDUFA3", "NDUFA4", "NDUFA5", "NDUFA6", "NDUFA7", "NDUFA8", "NDUFA9", 
               "NDUFA10", "NDUFA11", "NDUFA12", "NDUFA13", "NDUFAB1", "NDUFB1", "NDUFB2", "NDUFB3", 
               "NDUFB4", "NDUFB5", "NDUFB6", "NDUFB7", "NDUFB8", "NDUFB9", "NDUFB10", "NDUFB11", 
               "NDUFC1", "NDUFC2", "NDUFS1", "NDUFS2", "NDUFS3", "NDUFS4", "NDUFS5", "NDUFS6", 
               "NDUFS7", "NDUFS8", "NDUFV1", "NDUFV2", "NDUFV3", "SDHA", "SDHB", "SDH3", "SDH4", 
               "QCR2", "QCR6", "QCR7", "QCR8", "QCR9", "QCR10", "UQCRFS1", "CYC1", "COX4", "COX5A", 
               "COX5B", "COX6A", "COX6B", "COX6C", "COX7A", "COX7B", "COX7C", "COX10", 
               "COX11", "COX15", "COX17", "ATP5A1", "ATP5B", "ATP5C1", "ATP5D", 
               "ATP5E", "ATP5F1", "ATP5G", "ATP5J", "ATP5L", "ATP5O")

valori_geni$Gene <- factor(valori_geni$Gene, levels = nomi_geni)

ggplot(valori_geni, aes(x = Gene, y = Valore, fill = Tipo)) +
    geom_boxplot(outlier.shape = NA, color = "white") + 
    scale_fill_manual(values = c("Contatto" = "coral3", "Non Contatto" = "blue")) +  
    labs(title = "Boxplot per ogni Gene",
         x = "Gene",
         y = "Valore") +
    theme_minimal() +
    theme(legend.position = "right",  
         axis.text.x = element_text(angle = 45, hjust = 1))
