###########################
###### Density Plots ######
###########################

### Install viridis
install.packages("viridis")
library(viridis)

### Plot three curves in the same plot
ggplot() +
    geom_density(data = table_rho_Block12, aes(x = V3, fill = "NucOXPHOS-Orthologs"), alpha = 0.5) +
    geom_density(data = table_rho_Block34, aes(x = V3, fill = "MtOXPHOS-Orthologs"), alpha = 0.5) +
    geom_density(data = table_rho_contact_nucOXPHOS_mt, aes(x = V1, fill = "Contact NucOXPHOS-MtOXPHOS"), alpha = 0.9) +
    geom_density(data = table_rho_nucOXPHOS_mt, aes(x = V1, fill = "NucOXPHOS-MtOXPHOS"), alpha = 0.9) +
    scale_fill_viridis(discrete = TRUE, alpha = 1, begin = 0.0, end = 1, option = "D", direction = -1) +
    scale_x_continuous(breaks = seq(-1, 1, by = 0.2)) + 
    labs(x = "Spearman's Rho", y = "Density") +
    theme_minimal() +
    guides(fill = guide_legend(title = NULL)) + 
    theme(axis.text = element_text(size = 12),
          axis.title = element_text(size = 14))
