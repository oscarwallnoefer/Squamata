##################################################
################# Contact - Mito #################
##################################################

# Load tree and calculate root to tip distances. Then, scale
contact<-read.tree("contact.txt")
contact<-distRoot(contact,tips="all",method="patristic")
contact<-contact/sum(contact)

#################### NORMALIZE

# Create a list of variables for Block2 Iterations, that we will use to normalize contact distances
iteration_vars <- ls(pattern = "^Iteration[0-9]+_Block2$")

# loop to normalize "contact" 
for (iteration_var in iteration_vars) {
    iteration_number <- gsub("^Iteration([0-9]+)_Block2$", "\\1", iteration_var)
    
    block2_var <- paste0("Iteration", iteration_number, "_Block2")
    contact_var <- "contact"
    
    #NB: species must be sorted by names! See below 
    if (exists(block2_var) && exists(contact_var)) {
        block2_species <- sort(names(get(block2_var)))
        contact_species <- sort(names(get(contact_var)))
        
        if (all.equal(block2_species, contact_species)) {
            assign(paste0("Iteration", iteration_number, "_contact_norm"), get(contact_var)[contact_species] / get(block2_var)[block2_species])
        } else {
            cat("Error: Species Are Not In The Same Order In:", iteration_var, "\n")
        }
    } else {
        cat("Some Variables In", iteration_number, "Do Not Exist.\n")
    }
}

############################## CORRELATION

# List new IterationX_contact_norm
iteration_numbers <- unique(as.numeric(gsub("^Iteration([0-9]+)_contact_norm$", "\\1", ls())))

# Create new vector to memorize Rho
rho_values <- numeric()

# For each value of iteration_numbers:
for (iteration_number in iteration_numbers) {
    # create two variabile for the same Iteration 
    contact_norm_var <- paste0("Iteration", iteration_number, "_contact_norm")
    mito_norm_var <- paste0("Iteration", iteration_number, "_mito_norm")
    
    # Check if variables exist
    if (exists(contact_norm_var) && exists(mito_norm_var)) {
        # perform spearman correlation
        correlation_test <- cor.test(get(contact_norm_var), get(mito_norm_var), method = "spearman")
        
        # Estract rho
        rho_value <- correlation_test$estimate
        
        # Save
        rho_values <- c(rho_values, rho_value)
    } else {
        # If variables do not exist, print a message
      cat("Some variables for iteration", iteration_number, "do not exist.\n")
    }
}

# Save in txt file
write.table(rho_values, file = "rho_contact_mito.txt", row.names = FALSE, col.names = FALSE)

######################################### PLOT with other correlations

table_rho_contact_mito<- read.table("rho_contact_mito.txt")
summary(table_rho_contact_mito$V1)
ggplot() +
    geom_density(data = table_rho_Block12, aes(x = V3, fill = "NucOXPHOS-Orthologs"), alpha = 0.5) +
    geom_density(data = table_rho_block34, aes(x = V3, fill = "MtOXPHOS-Orthologs"), alpha = 0.5) +
    geom_density(data = table_rho_nucox_mito, aes(x = V1, fill = "NucOXPHOS-MtOXPHOS"), alpha = 0.9) +
    geom_density(data = table_rho_contact_mito, aes(x = V1, fill = "Contact NucOXPHOS-MtOXPHOS"), alpha = 0.9) +
    scale_x_continuous(breaks = seq(-1, 1, by = 0.2)) + 
    labs(x = "Spearman's Rho", y = "Density") +
    theme_minimal() +
    guides(fill = guide_legend(title = NULL)) + 
    theme(axis.text = element_text(size = 12),
          axis.title = element_text(size = 14))
