# Single Site Likelihood Support 

Maximum likelihood per site means that the likelihood of each site of our concatenated treefile (concatenated.out) is tested on both mitochondrial and nuclear tree (specie tree) topology.

Command: `raxmlHPC -f G -s concatenated.out -m [model] -z [mt or busco_topology.tree] -n [MT or NUC_hypothesis]`

Then, from the two outputs delta values are extracted (MLxSite-contact - MLxSite-non_contact):
+ values > 0 likelihood towards the MT topology
+ values < 0 likelihood towards the NUC topology

R was used to plot likelihoods. Delta > 0.5 or < -0.5 were highlighted, since they show strong support levels for one tree or the other.

R:
       
+ `mt_mlxsite <- read.table("RAxML_perSiteLLs.MT", skip = 1)`
+ `nuc_mlxsite <- read.table("RAxML_perSiteLLs.NUC", skip = 1)`
+ `mt_mlxsite <- mt_mlxsite[,-1]`
+ `nuc_mlxsite <-nuc_mlxsite[,-1]`
+ `delta <- mt_mlxsite - nuc_mlxsite`
+ `values <- unlist(delta)`

Then:

              coordinate_genes <- data.frame(
                            Gene = c("ATP5A1", "ATP5B", ...)
                            Intervallo = c("1-1599", "1600-3189", ...))
                       
              #rename columns
              colnames(coordinate_genes) <- c("Gene", "Intervallo")
              #check
              str(coordinate_genes)
              
              vettori_genes <- list()
              for (i in 1:nrow(coordinate_genes)) {
                  gene <- coordinate_genes$Gene[i]  #gene name
                  intervallo <- unlist(strsplit(coordinate_genes$Intervallo[i], "-")) #coordinates                  start <- as.numeric(intervallo[1])
                  end <- as.numeric(intervallo[2])
                  vettore_gene <- values[start:end]
                  vettori_genes[[gene]] <- vettore_gene
              }


Then: 

       C_I <- c(vettori_genes$NDUFA1, vettori_genes$NDUFA2, ...) # create complexes
       C_II<- c(vettori_genes$SDH3, vettori_genes$SDH4, ...)
       ...

Plot:


       plot(C_I, pch = 19, cex=0.5, col = ifelse( C_I < -0.5 | C_I > 0.5, "red","black"), main = "Complex I")
       plot(C_II, pch = 19, cex=0.5, col = ifelse( C_II < -0.5 | C_II > 0.5, "red","black"), main = "Complex II")
       plot(C_III, pch = 19, cex=0.5, col = ifelse( C_III < -0.5 | C_III > 0.5, "red","black"), main = "Complex III")
       plot(C_IV, pch = 19, cex=0.5, col = ifelse( C_IV < -0.5 | C_IV > 0.5, "red","black"), main = "Complex IV")
       plot(C_V, pch = 19, cex=0.5, col = ifelse( C_V < -0.5 | C_V > 0.5, "red","black"), main = "Complex V")

    
---

![SSLS](SSLS_PointsOption.png)

