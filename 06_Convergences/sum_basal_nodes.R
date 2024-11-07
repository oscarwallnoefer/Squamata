#Specify the list of basal nodes (major groups)
specific_nodes <- c("Node105", "Node98", "Node81", "Node74", "Node26", "Node29", "Node9")

# get the list with all files beginning with "new_coordinate"
file_list <- list.files(pattern="^new_coordinate_.*$", full.names = TRUE)

# Create a list to memorize filtered data
filtered_data_list <- list()

# 1. From each file, extraction all combination of couples of nodes from #specific_nodes 
for(file_name in file_list) {
    # Leggi i dati dal file
    data <- read.table(file_name, skip=1)
    
    # Rename colums
    colnames(data) <- c("Node1", "Node2", "TotalSubstitutions", "ConvergentSubstitutions")
    
    # Select only rows where both nodes are in the "specific_nodes" variable
    selected_data <- data[data$Node1 %in% specific_nodes & data$Node2 %in% specific_nodes, ]
    
    # Add them to the list
    filtered_data_list[[file_name]] <- selected_data
}

# 2. Save each output on different files
for(file_name in names(filtered_data_list)) {
    write.table(filtered_data_list[[file_name]], paste0(file_name, "_filtered"), sep="\t", quote=FALSE, row.names=FALSE)
}

# 3. Combine them
combined_data <- do.call(rbind, filtered_data_list)

# Write the final file "basal_nodes.txt"
write.table(combined_data, "basal_nodes", sep="\t", quote=FALSE, row.names=FALSE)

##########################################################################
##########################################################################

# Read data from basal_nodes.txt
data <- read.table("basal_nodes", header = TRUE)
library(dplyr)

# group couple of nodes and sum values
result <- data %>%
    group_by(Node1, Node2) %>%
    summarise(TotalSubstitutions = sum(TotalSubstitutions),
              ConvergentSubstitutions = sum(ConvergentSubstitutions))
print(result)
write.table(result, "output_sum_identical_nodes.txt", sep = "\t", row.names = FALSE)













