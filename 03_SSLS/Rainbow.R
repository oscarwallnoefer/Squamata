library(zoo)

window_size <- 10
moving_avg_gene <- lapply(vettori_genes[nomi_geni[which(nomi_geni %in% names(vettori_genes))]], function(gene_values) {
    rollmean(gene_values, k = window_size, fill = NA, align = "center")
})

moving_avg_combined <- unlist(moving_avg_gene)
palette_colori <- rainbow(length(moving_avg_gene))
valori_ordinati <- unlist(vettori_genes[nomi_geni[which(nomi_geni %in% names(vettori_genes))]])

colors <- rep("grey", length(valori_ordinati))
positions_yellow <- c()
positions_purple <- c()

for (i in seq(1, length(valori_ordinati), by = 3)) {
    if (!is.na(valori_ordinati[i]) && (valori_ordinati[i] < -0.5 || valori_ordinati[i] > 0.5)) {
        positions_purple <- c(positions_purple, i)
    }
    if ((i + 1) <= length(valori_ordinati) && !is.na(valori_ordinati[i + 1]) && 
        (valori_ordinati[i + 1] < -0.5 || valori_ordinati[i + 1] > 0.5)) {
        positions_purple <- c(positions_purple, i + 1)
    }
    if ((i + 2) <= length(valori_ordinati) && !is.na(valori_ordinati[i + 2]) && 
        (valori_ordinati[i + 2] < -0.5 || valori_ordinati[i + 2] > 0.5)) {
        positions_yellow <- c(positions_yellow, i + 2)
    }
}

plot(valori_ordinati, pch = 19, cex = 0.8, col = colors, xlab = "", ylab = "ΔSSLS", 
     ylim = c(min(valori_ordinati, na.rm = TRUE), max(valori_ordinati, na.rm = TRUE)))

# yellow = third codon positions
# purple  = first two codon positions
points(positions_yellow, valori_ordinati[positions_yellow], pch = 21, cex = 0.8, bg = "white", col = "black")
points(positions_purple, valori_ordinati[positions_purple], pch = 21, cex = 0.8, bg = "black", col = "black")

for (i in seq_along(moving_avg_gene)) {
    start_pos <- sum(sapply(moving_avg_gene[1:(i - 1)], length)) + 1 
    x_pos <- start_pos:(start_pos + length(moving_avg_gene[[i]]) - 1)
    lines(x_pos, moving_avg_gene[[i]], col = palette_colori[i], lwd = 2)
}

segments(x0 = length(C_I), y0 = min(valori_ordinati, na.rm = TRUE), x1 = length(C_I), 
         y1 = max(valori_ordinati, na.rm = TRUE), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II), y0 = min(valori_ordinati, na.rm = TRUE), 
         x1 = length(C_I) + length(C_II), y1 = max(valori_ordinati, na.rm = TRUE), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III), y0 = min(valori_ordinati, na.rm = TRUE), 
         x1 = length(C_I) + length(C_II) + length(C_III), y1 = max(valori_ordinati, na.rm = TRUE), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y0 = min(valori_ordinati, na.rm = TRUE), 
         x1 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y1 = max(valori_ordinati, na.rm = TRUE), col = "black", lwd = 2, lty = 2)
