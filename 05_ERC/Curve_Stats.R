################################
### Summarize density curves ###
################################

# Control Curve Busco-nucOXPHOS
> summary(table_rho_Block12$V3) 
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.59532 -0.09489  0.10044  0.08637  0.26610  0.67329

# Control Curve Busco-mtOXPHOS 
> summary(table_rho_Block34$V3)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-0.6662 -0.1158  0.1197  0.1140  0.3684  0.8033
 
# Control Curve nucOXPHOS-mtOXPHOS 
> summary(table_rho_nucOXPHOS_mt$V1)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.5047  0.6926  0.7236  0.7182  0.7499  0.8127 

# Control Curve Contact_nucOXPHSO-mtOXPHOS 
> summary(table_rho_contact_nucOXPHOS_mt$V1)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.6437  0.7722  0.7921  0.7882  0.8090  0.8568

################################
######## Normality Test ########
################################

> shapiro.test(table_rho_Block12$V3)
	Shapiro-Wilk normality test
data:  table_rho_Block12$V3
W = 0.99139, p-value = 1.387e-05

> shapiro.test(table_rho_Block34$V3)
	Shapiro-Wilk normality test
data:  table_rho_Block34$V3
W = 0.98404, p-value = 4.593e-08

> shapiro.test(table_rho_contact_nucOXPHOS_mt$V1)
	Shapiro-Wilk normality test
data:  table_rho_contact_nucOXPHOS_mt$V1
W = 0.9509, p-value = 2.574e-16

> shapiro.test(table_rho_nucOXPHOS_mt$V1)
	Shapiro-Wilk normality test
data:  table_rho_nucOXPHOS_mt$V1
W = 0.96711, p-value = 5.337e-13

################################
######### Wilcox Test ##########
################################

#Comparison between nucOXPHOS-mtOXPHOS curve and contact_nucOXPHOS and mtOXPHOS curve
> wilcox.test(table_rho_nucOXPHOS_mt$V1, table_rho_contact_nucOXPHOS_mt$V1)
	Wilcoxon rank sum test with continuity correction
data:  table_rho_nucOXPHOS_mt$V1 and table_rho_contact_nucOXPHOS_mt$V1
W = 59871, p-value < 2.2e-16
alternative hypothesis: true location shift is not equal to 0



