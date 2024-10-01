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

              C_I <- c(vettori_genes$NDUFA1, vettori_genes$NDUFA2, vettori_genes$NDUFA3, vettori_genes$NDUFA4, vettori_genes$NDUFA5, vettori_genes$NDUFA6, vettori_genes$NDUFA7, vettori_genes$NDUFA8, vettori_genes$NDUFA9, vettori_genes$NDUFA10, vettori_genes$NDUFA11, vettori_genes$NDUFA12, vettori_genes$NDUFA13, vettori_genes$NDUFAB1, vettori_genes$NDUFB1, vettori_genes$NDUFB2, vettori_genes$NDUFB3, vettori_genes$NDUFB4, vettori_genes$NDUFB5, vettori_genes$NDUFB6, vettori_genes$NDUFB7, vettori_genes$NDUFB8, vettori_genes$NDUFB9, vettori_genes$NDUFB10, vettori_genes$NDUFB11, vettori_genes$NDUFC1, vettori_genes$NDUFC2, vettori_genes$NDUFS1, vettori_genes$NDUFS2, vettori_genes$NDUFS3, vettori_genes$NDUFS4, vettori_genes$NDUFS5, vettori_genes$NDUFS6, vettori_genes$NDUFS7, vettori_genes$NDUFS8, vettori_genes$NDUFV1, vettori_genes$NDUFV2, vettori_genes$NDUFV3)
              
              C_II<- c(vettori_genes$SDHA, vettori_genes$SDHB, vettori_genes$SDH3, vettori_genes$SDH4)
              
              C_III <- c(vettori_genes$QCR2, vettori_genes$QCR6, vettori_genes$QCR7, vettori_genes$QCR8, vettori_genes$QCR9, vettori_genes$QCR10, vettori_genes$UQCRFS1, vettori_genes$CYC1)
              
              C_IV <- c(vettori_genes$COX4, vettori_genes$COX5A, vettori_genes$COX5B, vettori_genes$COX6A, vettori_genes$COX6B, vettori_genes$COX6C, vettori_genes$COX7A, vettori_genes$COX7B, vettori_genes$COX7C, vettori_genes$COX10, vettori_genes$COX11, vettori_genes$COX15, vettori_genes$COX17)
              
              C_V <- c(vettori_genes$ATP5A1, vettori_genes$ATP5B, vettori_genes$ATP5C1, vettori_genes$ATP5D, vettori_genes$ATP5E, vettori_genes$ATP5F1, vettori_genes$ATP5G, vettori_genes$ATP5J, vettori_genes$ATP5L, vettori_genes$ATP5O)

Plot:


       plot(C_I, pch = 19, cex=0.5, col = ifelse( C_I < -0.5 | C_I > 0.5, "red","black"), main = "Complex I")
       plot(C_II, pch = 19, cex=0.5, col = ifelse( C_II < -0.5 | C_II > 0.5, "red","black"), main = "Complex II")
       plot(C_III, pch = 19, cex=0.5, col = ifelse( C_III < -0.5 | C_III > 0.5, "red","black"), main = "Complex III")
       plot(C_IV, pch = 19, cex=0.5, col = ifelse( C_IV < -0.5 | C_IV > 0.5, "red","black"), main = "Complex IV")
       plot(C_V, pch = 19, cex=0.5, col = ifelse( C_V < -0.5 | C_V > 0.5, "red","black"), main = "Complex V")

    
---

![SSLS](SSLS_PointsOption.png)

