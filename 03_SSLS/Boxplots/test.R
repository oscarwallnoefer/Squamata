# test normalità
shapiro_test_contatto <- shapiro.test(valori_geni$Valore[valori_geni$Tipo == "Contatto"])
shapiro_test_non_contatto <- shapiro.test(valori_geni$Valore[valori_geni$Tipo == "Non Contatto"])

library(dplyr)

mw_test <- wilcox.test(Valore ~ Tipo, data = valori_geni)
print(mw_test)

riepilogo_valori <- valori_geni %>%
    group_by(Tipo) %>%
    summarise(
        Media = mean(Valore, na.rm = TRUE),
        Mediana = median(Valore, na.rm = TRUE),
        Deviazione_Standard = sd(Valore, na.rm = TRUE),
        N = n()
    )
print(riepilogo_valori)

# violin
library(ggplot2)
ggplot(valori_geni, aes(x = Tipo, y = Valore, fill = Tipo)) +
    geom_violin(trim = FALSE) + 
    geom_boxplot(width = 0.1, position = position_dodge(0.9), outlier.shape = NA) + 
    labs(title = "Violin Plot Geni di Contatto e Non Contatto",
         x = "Tipo di Gene",
         y = "Valore") +
    theme_minimal() +
    theme(legend.position = "none")  
