### le due distribuzioni non sono normali > W. rank sum test
### distribuzione geni contatto diversa da geni non contatto

> shapiro_test_contatto

	Shapiro-Wilk normality test

data:  valori_geni$Valore[valori_geni$Tipo == "Contatto"]
W = 0.96049, p-value = 1.923e-11

> shapiro_test_non_contatto

	Shapiro-Wilk normality test

data:  valori_geni$Valore[valori_geni$Tipo == "Non Contatto"]
W = 0.96536, p-value = 1.664e-10

#################################################################

> wilcox.test(valori_geni$Valore[valori_geni$Tipo == "Contatto"],valori_geni$Valore[valori_geni$Tipo == "Non Contatto"])

	Wilcoxon rank sum test with continuity correction

data:  valori_geni$Valore[valori_geni$Tipo == "Contatto"] and valori_geni$Valore[valori_geni$Tipo == "Non Contatto"]
W = 191743, p-value = 0.000357
alternative hypothesis: true location shift is not equal to 0

##################################################################
### Riepilogo delle statistiche per entrambi i gruppi
> riepilogo_valori <- valori_geni %>%
+     group_by(Tipo) %>%
+     summarise(
+         Media = mean(Valore, na.rm = TRUE),
+         Mediana = median(Valore, na.rm = TRUE),
+         Deviazione_Standard = sd(Valore, na.rm = TRUE),
+         N = n()
+     )

> print(riepilogo_valori)
### A tibble: 2 × 5
  |Tipo|          Media| Mediana| Deviazione_Standard|     N|
  |---|---|---|---|---|
|Contatto |    -0.232 | -0.537  |              1.30 |  586
|Non Contatto |-0.489 | -0.734   |             1.24|   584

#################################################################

> summary(values > 0.5)

   Mode   FALSE    TRUE 

logical   44931     477 

> summary(values < -0.5)

   Mode   FALSE    TRUE 

logical   44715     693 


|Tipo|> 0.5| < -0.5|
|---|---|---|
|Contact| 280 | 197 |
|Non contact | 306 | 387|

#################################################################

### differenza 1° e 2° base vs 3° base

> num_viola_sopra_0.5
[1] 276
> punti_viola_sotto_0.5 <- valori_ordinati[positions_purple] < -0.5
> sum(punti_viola_sotto_0.5)
[1] 287
> punti_gialli_sotto_0.5 <- valori_ordinati[positions_yellow] < -0.5
> sum(punti_gialli_sotto_0.5)
[1] 406
> punti_gialli_sopra_0.5 <- valori_ordinati[positions_gialli] > 0.5
Error: object 'positions_gialli' not found
> punti_gialli_sopra_0.5 <- valori_ordinati[positions_yellow] > 0.5
> sum(punti_gialli_sopra_0.5)
[1] 201

################# distribuzione punti sopra lo 0.5

	Wilcoxon rank sum test with continuity correction

data:  punti_gialli_sopra_0.5 and punti_viola_sopra_0.5
W = 23692, p-value = 0.0065
alternative hypothesis: true location shift is not equal to 0

> mean(punti_viola_sopra_0.5)
[1] 1.022774
> mean(punti_gialli_sopra_0.5)
[1] 0.9230339

################# distribuzione punti sotto lo -0.5
> print(test_mann_whitney_neg)

	Wilcoxon rank sum test with continuity correction

data:  punti_gialli_sotto_neg_0.5 and punti_viola_sotto_neg_0.5
W = 61147, p-value = 0.2663
alternative hypothesis: true location shift is not equal to 0

> mean(punti_viola_sotto_neg_0.5)
[1] -1.351129
> mean(punti_gialli_sotto_neg_0.5)
[1] -1.235252

### commento: sopra lo 0.5 significativa differenza (**), nulla sotto lo -0.5. Le prime due basi hanno una distribuzione più ampia (vedi medie).
