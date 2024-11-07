# Load libraries
library(ggplot2)
library(viridis)

# Function to calculate residuals for the given couple of nodes
calculate_residuals <- function(data) {
    # Linear model
    lm_model <- lm(V4 ~ V3, data = data)
    residuals <- resid(lm_model)
    # Add residual to df
    data$residuals <- residuals
    return(data)
}

# Path to files
folder_path <- "."

# Read files and run function above for each gene
file_list <- list.files(pattern = "^new_coordinate_.*$")
all_data <- data.frame()
for (file in file_list) {
    # Extract gene name
    gene_name <- gsub("^new_coordinate_(.*)\\..*$", "\\1", basename(file))
    # read file
    data <- read.table(file, skip = 1)
    colnames(data) <- c("V1", "V2", "V3", "V4")
    # run funnction
    gene_data <- calculate_residuals(data)
    gene_data$gene <- gene_name # clean gene name 
    
    # add data to main df 
    all_data <- rbind(all_data, gene_data)
}

# check gene names
all_data$gene <- gsub("^new_coordinate_", "", all_data$gene)

# Calculate quartiles
quantiles <- quantile(all_data$residuals, c(0.025, 0.975))

# Calcolate the residual range 
residual_range <- range(all_data$residuals)

# gene order
gene_order <- c("NDUFA1", "NDUFA2", "NDUFA3", "NDUFA4", "NDUFA5", "NDUFA6", "NDUFA7", "NDUFA8", "NDUFA9", "NDUFA10", "NDUFA11", "NDUFA12", "NDUFA13", "NDUFAB1", "NDUFB1", "NDUFB2", "NDUFB3", "NDUFB4", "NDUFB5", "NDUFB6", "NDUFB7", "NDUFB8", "NDUFB9", "NDUFB10", "NDUFB11", "NDUFC1", "NDUFC2", "NDUFS1", "NDUFS2", "NDUFS3", "NDUFS4", "NDUFS5", "NDUFS6", "NDUFS7", "NDUFS8", "NDUFV1", "NDUFV2", "NDUFV3", "SDH3", "SDH4", "SDHA", "SDHB", "QCR2", "QCR6", "QCR7", "QCR8", "QCR9", "QCR10", "UQCRFS1", "CYC1", "COX4", "COX5A", "COX5B", "COX6A", "COX6B", "COX6C", "COX7A", "COX7B", "COX7C", "COX10", "COX11", "COX15", "COX17", "ATP5A1", "ATP5B", "ATP5C1", "ATP5D", "ATP5E", "ATP5F1", "ATP5G", "ATP5J", "ATP5L", "ATP5O")

all_data$gene <- factor(all_data$gene, levels = gene_order)

# Order data
all_data <- all_data[order(all_data$gene), ]

# plot: each point represents the residual associated to a pair of branches
ggplot(all_data, aes(x = residuals, y = gene)) +
    geom_point(data = subset(all_data, !(V1 == "Node26" & V2 == "Node29")), aes(y = gene), pch = 19, cex = 3)  +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node29"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node29"), aes(y = gene), pch = 19, cex = 3, color = "red") +
    geom_point(data = subset(all_data, residuals > quantiles[1] & residuals < quantiles[2]), aes(y = gene), pch = 19, cex = 2, fill = "black", color = "darkgray") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node105"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node98"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node81"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node74"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node9"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node105"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node98"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node81"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node74"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node9"), aes(y = gene), pch = 19, cex = 3.5, color = "black") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node105"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node98"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node81"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node74"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node9"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node105"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node98"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node81"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node74"), aes(y = gene), pch = 19, cex = 3, color = "orange") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node9"), aes(y = gene), pch = 19, cex = 3, color = "orange") 
    scale_x_continuous(limits = residual_range) +
    labs(
        x = "Residuals",
        y ="",
    ) +
    theme_minimal() +
    theme(
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 9)
    )


################################################
### Highlight each pair between major groups ###
################################################

# Load libraries
library(ggplot2)
library(viridis)

########## as above

calculate_residuals <- function(data) {
    lm_model <- lm(V4 ~ V3, data = data)
    residuals <- resid(lm_model)
    data$residuals <- residuals
    return(data)
}
folder_path <- "."
file_list <- list.files(pattern = "^new_coordinate_.*$")

all_data <- data.frame()

for (file in file_list) {
    gene_name <- gsub("^new_coordinate_(.*)\\..*$", "\\1", basename(file))
    data <- read.table(file, skip = 1)
    colnames(data) <- c("V1", "V2", "V3", "V4")
    gene_data <- calculate_residuals(data)
    gene_data$gene <- gene_name 
    all_data <- rbind(all_data, gene_data)
}

all_data$gene <- gsub("^new_coordinate_", "", all_data$gene)

quantiles <- quantile(all_data$residuals, c(0.025, 0.975))
residual_range <- range(all_data$residuals)
gene_order <- c("NDUFA1", "NDUFA2", "NDUFA3", "NDUFA4", "NDUFA5", "NDUFA6", "NDUFA7", "NDUFA8", "NDUFA9", "NDUFA10", "NDUFA11", "NDUFA12", "NDUFA13", "NDUFAB1", "NDUFB1", "NDUFB2", "NDUFB3", "NDUFB4", "NDUFB5", "NDUFB6", "NDUFB7", "NDUFB8", "NDUFB9", "NDUFB10", "NDUFB11", "NDUFC1", "NDUFC2", "NDUFS1", "NDUFS2", "NDUFS3", "NDUFS4", "NDUFS5", "NDUFS6", "NDUFS7", "NDUFS8", "NDUFV1", "NDUFV2", "NDUFV3", "SDH3", "SDH4", "SDHA", "SDHB", "QCR2", "QCR6", "QCR7", "QCR8", "QCR9", "QCR10", "UQCRFS1", "CYC1", "COX4", "COX5A", "COX5B", "COX6A", "COX6B", "COX6C", "COX7A", "COX7B", "COX7C", "COX10", "COX11", "COX15", "COX17", "ATP5A1", "ATP5B", "ATP5C1", "ATP5D", "ATP5E", "ATP5F1", "ATP5G", "ATP5J", "ATP5L", "ATP5O")
all_data$gene <- factor(all_data$gene, levels = gene_order)
all_data <- all_data[order(all_data$gene), ]

##########
########## Use a specific color for each pair of main branches
ggplot(all_data, aes(x = residuals, y = gene)) +
    geom_point(data = subset(all_data, !(V1 == "Node26" & V2 == "Node29")), aes(y = gene), pch = 19, cex = 3)  +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node29"), aes(y = gene), pch = 19, cex = 3, color = "red") +
    geom_point(data = subset(all_data, residuals > quantiles[1] & residuals < quantiles[2]), aes(y = gene), pch = 19, cex = 2, fill = "black", color = "darkgray") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node105"), aes(y = gene), pch = 19, cex = 3, color = "lightblue") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node98"), aes(y = gene), pch = 19, cex = 3, color = "#009999") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node81"), aes(y = gene), pch = 19, cex = 3, color = "darkblue") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node74"), aes(y = gene), pch = 19, cex = 3, color = "#009933") +
    geom_point(data = subset(all_data, V1 == "Node26" & V2 == "Node9"), aes(y = gene), pch = 19, cex = 3, color = "darkgreen") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node105"), aes(y = gene), pch = 19, cex = 3, color = "darkorange") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node98"), aes(y = gene), pch = 19, cex = 3, color = "#ff99cc") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node81"), aes(y = gene), pch = 19, cex = 3, color = "#663300") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node74"), aes(y = gene), pch = 19, cex = 3, color = "#9900ff") +
    geom_point(data = subset(all_data, V1 == "Node29" & V2 == "Node9"), aes(y = gene), pch = 19, cex = 3, color = "#FFCC00") +
    
    scale_x_continuous(limits = residual_range) +
    labs(
        x = "Residuals",
        y ="",
    ) +
    theme_minimal() +
    theme(
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 9)
    )


