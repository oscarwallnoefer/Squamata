### le due distribuzioni non sono normali > W. rank sum test
### distribuzione geni contatto diversa da geni non contatto

> print(mw_test)

	Wilcoxon rank sum test with continuity correction

data:  Valore by Tipo
W = 191425, p-value = 0.001597
alternative hypothesis: true location shift is not equal to 0

> # Riepilogo delle statistiche per entrambi i gruppi
> riepilogo_valori <- valori_geni %>%
+     group_by(Tipo) %>%
+     summarise(
+         Media = mean(Valore, na.rm = TRUE),
+         Mediana = median(Valore, na.rm = TRUE),
+         Deviazione_Standard = sd(Valore, na.rm = TRUE),
+         N = n()
+     )

> print(riepilogo_valori)
# A tibble: 2 × 5
  Tipo          Media Mediana Deviazione_Standard     N
  <chr>         <dbl>   <dbl>               <dbl> <int>
1 Contatto     -0.232  -0.537                1.30   586
2 Non Contatto -0.489  -0.734                1.24   584
