# Plot the original points with grey color
plot(valori_ordinati, pch = 19, cex = 0.8, col = colors, xlab = "", ylab = "ΔSSLS", ylim = c(-5, max(C_I)))

# Add yellow points
points(positions_yellow, valori_ordinati[positions_yellow], pch = 19, cex = 0.8, col = "#feb95f")

# Add purple points
points(positions_purple, valori_ordinati[positions_purple], pch = 19, cex = 0.8, col = "#2d689f")

# Plot the moving average
lines(moving_avg, col = "black", lwd = 2)

segments(x0 = length(C_I), y0 = -6, x1 = length(C_I), y1 = 6, col = "grey", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II), y0 = -6, x1 = length(C_I) + length(C_II), y1 = 6, col = "grey", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III), y0 = -6, x1 = length(C_I) + length(C_II) + length(C_III), y1 = 6, col = "grey", lwd = 2, lty = 2)
segments(x0 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y0 = -6, x1 = length(C_I) + length(C_II) + length(C_III) + length(C_IV), y1 = 6, col = "grey", lwd = 2, lty = 2)
