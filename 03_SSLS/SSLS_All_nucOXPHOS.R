# Load necessary library
library(stats)
library(zoo)


# Define a gene order
nomi_geni <- c("NDUFA1", "NDUFA2", "NDUFA3", "NDUFA4", "NDUFA5", "NDUFA6", "NDUFA7", "NDUFA8", "NDUFA9", "NDUFA10", "NDUFA11", "NDUFA12", "NDUFA13", "NDUFAB1", "NDUFB1", "NDUFB2", "NDUFB3", "NDUFB4", "NDUFB5", "NDUFB6", "NDUFB7", "NDUFB8", "NDUFB9", "NDUFB10", "NDUFB11", "NDUFC1", "NDUFC2", "NDUFS1", "NDUFS2", "NDUFS3", "NDUFS4","NDUFS5", "NDUFS6", "NDUFS7", "NDUFS8", "NDUFV1", "NDUFV2", "NDUFV3", "SDHA", "SDHB","SDH3", "SDH4", "QCR2", "QCR6", "QCR7", "QCR8", "QCR9", "QCR10", "UQCRFS1", "CYC1", "COX4", "COX5A", "COX5B", "COX6A", "COX6B", "COX6C", "COX7A", "COX7B", "COX7C", "COX10", "COX11", "COX15", "COX17","ATP5A1", "ATP5B", "ATP5C1", "ATP5D", "ATP5E", "ATP5F1", "ATP5G", "ATP5J", "ATP5L", "ATP5O")
valori_ordinati <- unlist(vettori_genes[nomi_geni])

# Define the window size
window_size <- 60

# Calculate moving average
#moving_avg <- filter(valori_ordinati, rep(1/window_size, window_size), sides = 2)
moving_avg <- rollmean(valori_ordinati, k = window_size, fill = NA, align = "center")

# Reset colors and positions
colors <- rep("grey", length(valori_ordinati))
positions_yellow <- c()
positions_purple <- c()

# Assign colors based on the value and position in the triplet
for (i in seq(1, length(valori_ordinati), by = 3)) {
    # Check for NA values before performing comparisons
    if (!is.na(valori_ordinati[i])) {
        if (valori_ordinati[i] < -0.5 || valori_ordinati[i] > 0.5) {
            positions_purple <- c(positions_purple, i)  # 1st point of the triplet in purple
        }
    }
    if ((i + 1) <= length(valori_ordinati) && !is.na(valori_ordinati[i + 1])) {
        if (valori_ordinati[i + 1] < -0.5 || valori_ordinati[i + 1] > 0.5) {
            positions_purple <- c(positions_purple, i + 1)  # 2nd point of the triplet in purple
        }
    }
    if ((i + 2) <= length(valori_ordinati) && !is.na(valori_ordinati[i + 2])) {
        if (valori_ordinati[i + 2] < -0.5 || valori_ordinati[i + 2] > 0.5) {
            positions_yellow <- c(positions_yellow, i + 2)  # 3rd point of the triplet in yellow
        }
    }
}


# Plot the original points with grey color
plot(valori_ordinati, pch = 19, cex = 0.8, col = colors, xlab = "", ylab = "ΔSSLS", ylim = c(min(valori_ordinati), max(valori_ordinati)))

# Add yellow points
points(positions_yellow, valori_ordinati[positions_yellow], pch = 21, cex = 0.8, bg = "white", col = "black")

# Add purple points
points(positions_purple, valori_ordinati[positions_purple], pch = 21, cex = 0.8, bg = "black", col = "black")

# Plot the moving average
lines(moving_avg, col = "#cc3333", lwd = 2)

segments(x0 = length(C_I), y0 = min(valori_ordinati), x1 = length(C_I), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II), y0 = min(valori_ordinati), x1 = length(C_I) + length(C_II), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III), y0 = min(valori_ordinati), x1 = length(C_I) + length(C_II) + length(C_III), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y0 = min(valori_ordinati), x1 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
