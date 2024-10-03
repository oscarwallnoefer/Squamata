############################
#### Mito-Ortho (Busco) ####
############################

library(ape)
library(ade4)
library(adephylo)

mito<-read.tree("mito.treefile")
mito<-distRoot(mito,tips="all",method="patristic")
mito<-mito/sum(mito)

#######################################################
########### Cycle for all file in my folder ###########
#######################################################

# Ottieni la lista dei file nella cartella che terminano con ".treefile"
file_list <- list.files(pattern = "\\.treefile$")

# Ciclo su ogni file nella lista
for (file in file_list) {
  # Estrai il nome del file senza l'estensione
  file_name <- gsub("\\.treefile$", "", file)
  
  # Leggi l'albero da file
  assign(file_name, read.tree(file))
  
  # Calcola la distanza dalla radice
  assign(file_name, distRoot(get(file_name), tips = "all", method = "patristic"))
  
  # Normalizza la distanza
  assign(file_name, get(file_name) / sum(get(file_name)))
  
  # Puoi fare qualcos'altro con l'oggetto, ad esempio stampare un messaggio
  cat("Calcolo della distanza dalla radice completato per", file, "\n")
}

######################################################
##################
######################################################

# Trova tutte le variabili che seguono il modello "IterationX_Block1" e "IterationX_Block2"
iteration_vars <- ls(pattern = "^Iteration[0-9]+_Block[3-4]$")

# Iterare su tutte le variabili trovate
for (iteration_var in iteration_vars) {
    # Estrarre il numero di iterazione dalla variabile corrente
    iteration_number <- gsub("^Iteration([0-9]+)_Block[3-4]$", "\\1", iteration_var)
    
    # Costruire i nomi delle variabili Block1, Block2 e nucox per l'iterazione corrente
    block3_var <- paste0("Iteration", iteration_number, "_Block3")
    block4_var <- paste0("Iteration", iteration_number, "_Block4")
    mito_var <- "mito"
    
    # Controllare se le variabili esistono
    if (exists(block3_var) && exists(block4_var) && exists(mito_var)) {
        # Ordina le specie alfabeticamente per Block1, Block2 e nucox
        block3_species <- sort(names(get(block3_var)))
        block4_species <- sort(names(get(block4_var)))
        mito_species <- sort(names(get(mito_var)))
        
        # Controllo se le specie sono nello stesso ordine
        if (all.equal(block3_species, block4_species) && all.equal(block3_species, mito_species)) {
            # Normalizza Block1
            assign(paste0("Iteration", iteration_number, "_Block3_norm"), get(block3_var)[block3_species] / get(block4_var)[block4_species])
            
            # Normalizza nucox
            assign(paste0("Iteration", iteration_number, "_mito_norm"), get(mito_var)[mito_species] / get(block4_var)[block4_species])
        } else {
            cat("Errore: Le specie non sono nello stesso ordine in", iteration_var, "\n")
        }
    } else {
        # Se una delle variabili non esiste, stampa un messaggio di avviso
        cat("Alcune variabili per l'iterazione", iteration_number, "non esistono.\n")
    }
}

###############################
############# r^2 #############
###############################

# Apri un file per scrivere i valori di rho
file_path <- "correlation_results_block34.txt"
sink(file_path)

# Vettore per memorizzare le iterazioni già trattate
processed_iterations <- c()

# Iterare su tutte le variabili trovate
for (iteration_var in iteration_vars) {
    # Estrarre il numero di iterazione dalla variabile corrente
    iteration_number <- gsub("^Iteration([0-9]+)_Block[3-4]$", "\\1", iteration_var)
    
    # Verifica se l'iterazione è già stata trattata
    if (iteration_number %in% processed_iterations) {
        next  # Salta l'iterazione se è già stata trattata
    }
    
    # Costruire il nome della variabile Block1_norm per l'iterazione corrente
    block3_norm_var <- paste0("Iteration", iteration_number, "_Block3_norm")
    
    # Costruire il nome della variabile nucox_norm per l'iterazione corrente
    mito_norm_var <- paste0("Iteration", iteration_number, "_mito_norm")
    
    # Controllare se le variabili esistono
    if (exists(block3_norm_var) && exists(mito_norm_var)) {
        # Calcola il test di correlazione di Spearman tra Block1_norm e nucox_norm
        correlation_test <- cor.test(get(block3_norm_var), get(mito_norm_var), method = "spearman")
        
        # Estrai il valore di rho
        rho_value <- correlation_test$estimate
        
        # Scrivi il valore di rho nel file
        cat(iteration_var, "rho ", rho_value, "\n")
        
        # Aggiungi l'iterazione al vettore delle iterazioni già trattate
        processed_iterations <- c(processed_iterations, iteration_number)
    } else {
        # Se una delle variabili non esiste, stampa un messaggio di avviso
        cat("Alcune variabili per l'iterazione", iteration_number, "non esistono.\n")
    }
}

# Chiudi il file
sink()

####################################
############density plot############
####################################
prova<-read.table("correlation_results_block34.txt")
ggplot(data = prova, aes(x = V3)) +
    geom_density(fill = "blue", alpha = 0.5) +
    labs(x = "Valore di rho", y = "Densità", title = "Density plot dei valori di rho") +
    theme_minimal()
