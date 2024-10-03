############################
### Load Nucox Reference ###
############################

library(ape)
library(ade4)
library(adephylo)

nucox<-read.tree("nucox.treefile")
nucox<-distRoot(nucox,tips="all",method="patristic")
nucox<-nucox/sum(nucox)

#######################################################
########### Cycle for all file in my folder ###########
#######################################################

# Obtain the file list
file_list <- list.files(pattern = "\\.treefile$")

# Cicle each file in file list, load newick trees, calculate root-to-tip distances and scale branch lengths
for (file in file_list) {
  file_name <- gsub("\\.treefile$", "", file)
  assign(file_name, read.tree(file))
  assign(file_name, distRoot(get(file_name), tips = "all", method = "patristic"))
  assign(file_name, get(file_name) / sum(get(file_name)))
  cat("Root To Tip Completed For:", file, "\n")
}

#################################
######### Normalization #########
#################################

# Find all variables as "IterationX_Block1" and "IterationX_Block2"
iteration_vars <- ls(pattern = "^Iteration[0-9]+_Block[1-2]$")

# Iterate across variables. For each iteration, use Block2 to normalize Block1 and Nucox.
for (iteration_var in iteration_vars) {
  iteration_number <- gsub("^Iteration([0-9]+)_Block[1-2]$", "\\1", iteration_var)
  
  block1_var <- paste0("Iteration", iteration_number, "_Block1")
  block2_var <- paste0("Iteration", iteration_number, "_Block2")
  nucox_var <- "nucox"
  
  if (exists(block1_var) && exists(block2_var) && exists(nucox_var)) {
    block1_species <- sort(names(get(block1_var)))
    block2_species <- sort(names(get(block2_var)))
    nucox_species <- sort(names(get(nucox_var)))
    
    if (all.equal(block1_species, block2_species) && all.equal(block1_species, nucox_species)) {
      assign(paste0("Iteration", iteration_number, "_Block1_norm"), get(block1_var)[block1_species] / get(block2_var)[block2_species])
      assign(paste0("Iteration", iteration_number, "_nucox_norm"), get(nucox_var)[nucox_species] / get(block2_var)[block2_species])
    } else {
      cat("Error: Species Are Not In The Same Order In:", iteration_var, "\n")
    }
  } else {
    cat("Some Variables In", iteration_number, "Do Not Exist.\n")
  }
}

###############################
######## Spearman's Rho #######
###############################

file_path <- "correlation_results_Block12.txt"
sink(file_path)

processed_iterations <- c()

# For each iteration, obtain Rho from IterationX_Block1_norm and IterationX_nucox_norm
for (iteration_var in iteration_vars) {
  iteration_number <- gsub("^Iteration([0-9]+)_Block[1-2]$", "\\1", iteration_var)
  if (iteration_number %in% processed_iterations) {
    next  
  }
  
  block1_norm_var <- paste0("Iteration", iteration_number, "_Block1_norm")
  nucox_norm_var <- paste0("Iteration", iteration_number, "_nucox_norm")

  if (exists(block1_norm_var) && exists(nucox_norm_var)) {
    correlation_test <- cor.test(get(block1_norm_var), get(nucox_norm_var), method = "spearman")
    rho_value <- correlation_test$estimate
    
    # Create a data frame
    cat(iteration_var, "rho ", rho_value, "\n")
    
    processed_iterations <- c(processed_iterations, iteration_number)
  } else {
    cat("Some Variables For The Iteration", iteration_number, "Do Not Exist.\n")
  }
}

sink()

####################################
########### Density Plot ###########
####################################

table_rho_Block12 <- read.table("correlation_results_block12.txt")
ggplot(data = table_rho_Block12, aes(x = V3)) +
    geom_density(fill = "blue", alpha = 0.5) +
    labs(x = "Spearman's Rho", y = "Density") +
    theme_minimal()
