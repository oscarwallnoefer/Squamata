# Completeness Matrix

Need the list of species name (called "species_list.txt). 

ex. 
  
    Python_bivittatus
    Morelia_viridis
    Naja_naja

Output: `completeness_matrix.csv`

R:

  #load libraries
  library(tidyverse)
  library(reshape2)
  
  #open csv file
  completeness_matrix <- read.csv("completeness_matrix.csv")
  
  #edit matrix
  completeness_long <- melt(completeness_matrix, id.vars = "Specie")
  
  #rules
  completeness_long$value <- ifelse(completeness_long$value == "TRUE", "TRUE", "FALSE")
  
  #define gene order
  gene_order <- c("NADH1", "NADH2", "NADH3", "NADH4", "NADH4L", "NADH5", "NADH6", 
                  "CYTB", "COX1", "COX2", "COX3", "ATP6", "ATP8")
  
  #plot
  ggplot(completeness_long, aes(x = factor(variable, levels = gene_order), y = Specie, fill = value)) +
      geom_tile(color = "black", size = 0.5) +
      scale_fill_manual(values = c("TRUE" = "white", "FALSE" = "red"), 
                        name = "Legend") +
      labs(x = "mtOXPHOS", y = "Species") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            axis.text.y = element_text(face = "italic", size = 8),
            panel.grid = element_blank()) 







