# Load necessary library
library(stats)

# Define the window size
window_size <- 100

# Calculate moving average
#moving_avg <- filter(valori_ordinati, rep(1/window_size, window_size), sides = 2)
moving_avg <- rollmean(valori_ordinati, k = window_size, fill = NA, align = "center")
# Create vectors to store the colors and positions
colors <- rep("grey", length(valori_ordinati))
positions_yellow <- c()
positions_purple <- c()

# Assign colors based on the value and position in the triplet
for (i in seq(1, length(valori_ordinati), by = 3)) {
    if (i <= length(valori_ordinati)) {
        if (valori_ordinati[i] < -0.5 || valori_ordinati[i] > 0.5) {
            positions_purple <- c(positions_purple, i)  # 1st point of the triplet in purple
        }
    }
    if ((i + 1) <= length(valori_ordinati)) {
        if (valori_ordinati[i + 1] < -0.5 || valori_ordinati[i + 1] > 0.5) {
            positions_purple <- c(positions_purple, i + 1)  # 2nd point of the triplet in purple
        }
    }
    if ((i + 2) <= length(valori_ordinati)) {
        if (valori_ordinati[i + 2] < -0.5 || valori_ordinati[i + 2] > 0.5) {
            positions_yellow <- c(positions_yellow, i + 2)  # 3rd point of the triplet in yellow
        }
    }
}

# Plot the original points with grey color
plot(valori_ordinati, pch = 19, cex = 0.8, col = colors, xlab = "", ylab = "ΔSSLS", ylim = c(-5, max(C_I)))

# Add yellow points
points(positions_yellow, valori_ordinati[positions_yellow], pch = 21, cex = 0.8, bg = "white", col = "black")

# Add purple points
points(positions_purple, valori_ordinati[positions_purple], pch = 21, cex = 0.8, bg = "#009966", col = "black")

# Plot the moving average
lines(moving_avg, col = "black", lwd = 2)

segments(x0 = length(C_I), y0 = min(valori_ordinati), x1 = length(C_I), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II), y0 = min(valori_ordinati), x1 = length(C_I) + length(C_II), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III), y0 = min(valori_ordinati), x1 = length(C_I) + length(C_II) + length(C_III), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y0 = min(valori_ordinati), x1 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y1 = max(valori_ordinati), col = "black", lwd = 2, lty = 2)
