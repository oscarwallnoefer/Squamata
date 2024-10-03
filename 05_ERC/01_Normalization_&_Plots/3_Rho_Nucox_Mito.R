############################################
######## Rho Between Nucox And Mito ########
############################################

# Estrai i numeri di iterazione da tutte le variabili Iteration*_nucox_norm
iteration_numbers <- unique(as.numeric(gsub("^Iteration([0-9]+)_nucox_norm$", "\\1", ls())))

# Vettore per memorizzare i valori di rho
rho_values <- numeric()

# Itera attraverso tutti i numeri di iterazione
for (iteration_number in iteration_numbers) {
    # Costruisci i nomi delle variabili nucox_norm e mito_norm per l'iterazione corrente
    nucox_norm_var <- paste0("Iteration", iteration_number, "_nucox_norm")
    mito_norm_var <- paste0("Iteration", iteration_number, "_mito_norm")
    
    # Controlla se le variabili esistono
    if (exists(nucox_norm_var) && exists(mito_norm_var)) {
        # Calcola il test di correlazione di Spearman tra nucox_norm e mito_norm
        correlation_test <- cor.test(get(nucox_norm_var), get(mito_norm_var), method = "spearman")
        
        # Estrai il valore di rho
        rho_value <- correlation_test$estimate
        
        # Salva il valore di rho nel vettore
        rho_values <- c(rho_values, rho_value)
    } else {
        # Se una delle variabili non esiste, stampa un messaggio di avviso
        cat("Alcune variabili per l'iterazione", iteration_number, "non esistono.\n")
    }
}

# Salva il vettore rho_values in un file chiamato "rho_nucox_mito.txt"
write.table(rho_values, file = "rho_nucox_mito.txt", row.names = FALSE, col.names = FALSE)

####################################
################ Plot ##############
####################################
ggplot(data = table_rho_nucox_mito, aes(x = V1)) +
    geom_density(fill = "darkgreen", alpha = 0.5) +
    labs(x = "Valore di rho", y = "Densità", title = "Density plot dei valori di rho") +
    theme_minimal()

#############################
######### Three Plot ########
#############################

library(ggplot2)

# Sovrapposizione di density plot per tre variabili
ggplot() +
    geom_density(data = table_results_block12, aes(x = V3, color = "Block12"), fill = "darkblue", alpha = 0.5) +
    geom_density(data = table_results_block34, aes(x = V3, color = "Block34"), fill = "darkred", alpha = 0.5) +
    geom_density(data = table_nucox_mito, aes(x = V1, color = "Nucox_Mito"), fill = "darkgreen", alpha = 0.5) +
    labs(x = "Valore di rho", y = "Densità", title = "Density plot di tre variabili") +
    theme_minimal()
