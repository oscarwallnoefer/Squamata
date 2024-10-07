# Completeness Matrix

Need the list of species name (called "species_list.txt). 

ex. 
  
    Python_bivittatus
    Morelia_viridis
    Naja_naja

Then, python (`presence_absence.py`).

Output: `completeness_matrix.csv`, then `sed 's/_/ /'`.

Then, R (`completeness.R`).

### Count TRUE and FALSE

    logical_columns <- matrix[, sapply(matrix, is.logical)]
    true_count <- sum(logical_columns, na.rm = TRUE) 
    false_count <- sum(!logical_columns, na.rm = TRUE)
    cat("Numero di TRUE:", true_count, "\n")
    cat("Numero di FALSE:", false_count, "\n")


---

![completeness_matrix](completeness_mtOXPHOS.svg)

![completeness_matrix](completeness_nucOXPHOS.svg)
