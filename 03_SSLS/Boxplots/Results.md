# ERCs's Rho Distribution Comparisons

### Shapiro-Wilk normality test

|type| W | p-value|
|---|---|---|
|contact|0.96049|1.923e-11|
|non contact|0.96536|1.664e-10|

Comment: the two sets do not follow a normal distributions.

### Wilcoxon rank sum test with continuity correction

Command: `wilcox.test(valori_geni$Valore[valori_geni$Tipo == "Contatto"],valori_geni$Valore[valori_geni$Tipo == "Non Contatto"])`
W = 191743, p-value = 0.000357

Comment: the two sets differ significantly.  

---

### Summarize statistics

<details>
	
<summary> script </summary>

	riepilogo_valori <- valori_geni %>%
	     group_by(Tipo) %>%
	     summarise(
	         Media = mean(Valore, na.rm = TRUE),
	         Mediana = median(Valore, na.rm = TRUE),
	         Deviazione_Standard = sd(Valore, na.rm = TRUE),
	         N = n()
	     )
> print(riepilogo_valori)
	
</details>

|Type|Mean|Median|St. Dev.|N|
|---|---|---|---|---|
|contact |    -0.232 | -0.537  |              1.30 |  586
|non contact |-0.489 | -0.734   |             1.24|   584

--- 

### Summary significant support for one topology

|Type|> 0.5| < -0.5|
|---|---|---|
|True|477|693|
| False|44931|44715|

|Type|> 0.5| < -0.5|
|---|---|---|
|contact| 280 | 306 |
|non contact | 197 | 387|

---

### Codon position differences

|Type|> 0.5| < -0.5|
|---|---|---|
|first two positions|276| 287|
|third positions|201|406|

---

### Distributions based on codon positions

|Type|> 0.5| mean | < -0.5| mean|
|---|---|---|---|---|
|first two positions|276|1.022774| 287|-1.235252|
|third positions|201|0.9230339|406|-1.351129| 

Wilcoxon rank sum test with continuity correction
> first two codon positions>0.5 and third positions>0.5
> W = 23692, p-value = 0.0065

Wilcoxon rank sum test with continuity correction
> first two codon positions < -0.5 and third positions < -0.5 
> W = 61147, p-value = 0.2663

Comment: over the 0.5 there is a significant difference (**), under the -0.5 there is not.
