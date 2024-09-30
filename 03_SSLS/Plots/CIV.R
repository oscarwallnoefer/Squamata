library(stats)

# Define the window size
window_size <- 100

# Calculate moving average
moving_avg <- rollmean(C_IV, rep(1/window_size, window_size), k = window_size, fill = NA, align = "center")
# Create vectors to store the colors and positions
colors <- rep("grey", length(C_IV))
positions_yellow <- c()
positions_purple <- c()

# Assign colors based on the value and position in the triplet
for (i in seq(1, length(C_IV), by = 3)) {
    if (i <= length(C_IV)) {
        if (C_IV[i] < -0.5 || C_IV[i] > 0.5) {
            positions_purple <- c(positions_purple, i)  # 1st point of the triplet in purple
        }
    }
    if ((i + 1) <= length(C_IV)) {
        if (C_IV[i + 1] < -0.5 || C_IV[i + 1] > 0.5) {
            positions_purple <- c(positions_purple, i + 1)  # 2nd point of the triplet in purple
        }
    }
    if ((i + 2) <= length(C_IV)) {
        if (C_IV[i + 2] < -0.5 || C_IV[i + 2] > 0.5) {
            positions_yellow <- c(positions_yellow, i + 2)  # 3rd point of the triplet in yellow
        }
    }
}

# Plot the original points with grey color
plot(C_IV, pch = 19, cex = 0.8, col = colors, xlab = "", ylab = "ΔSSLS", ylim = c(-6.2, max(C_IV)), main = "Complex IV")

# Add yellow points
points(positions_yellow, C_IV[positions_yellow], pch = 21, cex = 0.8, bg = "white", col = "black")

# Add purple points
points(positions_purple, C_IV[positions_purple], pch = 21, cex = 0.8, bg = "#009966", col = "black")

# Plot the moving average
lines(moving_avg, col = "black", lwd = 2)

segments(x0 = cumsum(lunghezze_CIV), y0 = min(C_IV), x1 = cumsum(lunghezze_CIV), y1 = max(C_IV), col = "black", lwd = 2, lty = 2) 
text(x = cumsum(lunghezze_CIV), y = min(C_IV) -0.2 , labels = nomi_geni_CIV, ,srt = 90, adj =1, cex = 1)
