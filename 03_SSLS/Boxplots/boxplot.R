library(ggplot2)
contact_genes <- c("ATP5F1", "ATP5G", "COX4", "COX5B", "COX6A", 
                   "COX6B", "COX7A", "COX7B", "COX7C", 
                   "NDUFA10", "NDUFA11", "NDUFA12", "NDUFA13", 
                   "NDUFA1", "NDUFA3", "NDUFA8", "NDUFA9", 
                   "NDUFAB1", "NDUFB10", "NDUFB11", "NDUFB2", 
                   "NDUFB3", "NDUFB4", "NDUFB5", "NDUFB6", 
                   "NDUFB7", "NDUFB8", "NDUFB9", "NDUFC2", 
                   "NDUFS2", "NDUFS5", "NDUFS7", "NDUFS8", 
                   "QCR6", "QCR7", "QCR8", "QCR9", "UQCRFS1", "CYC1")

valori_geni <- data.frame(Gene = character(), Valore = numeric(), Tipo = character(), stringsAsFactors = FALSE)

aggiungi_valori_geni <- function(gene) {
    if (gene %in% names(vettori_genes)) {
        valori <- vettori_genes[[gene]]
        valori_filtrati <- valori[valori > 0.5 | valori < -0.5]
        
        if (length(valori_filtrati) > 0) {
            tipo <- ifelse(gene %in% contact_genes, "Contatto", "Non Contatto")
            df_tmp <- data.frame(Gene = rep(gene, length(valori_filtrati)), 
                                 Valore = valori_filtrati, 
                                 Tipo = tipo)
            return(df_tmp)
        }
    }
    return(NULL)
}

for (gene in names(vettori_genes)) {
    df_tmp <- aggiungi_valori_geni(gene)
    if (!is.null(df_tmp)) {
        valori_geni <- rbind(valori_geni, df_tmp)
    }
}

ggplot(valori_geni, aes(x = Tipo, y = Valore, fill = Tipo)) +
    geom_boxplot(outlier.size = 1, outlier.colour = "red") +
    labs(title = "Boxplot dei valori dei geni di contatto e non di contatto",
         x = "Tipo di Gene",
         y = "Valore") +
    theme_minimal() +
    scale_fill_manual(values = c("Contatto" = "blue", "Non Contatto" = "grey"))
