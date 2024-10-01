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
               Gene = c(
               "ATP5A1", "ATP5B", "ATP5C1", "ATP5D", "ATP5E", 
               "ATP5F1", "ATP5G", "ATP5J", "ATP5L", "ATP5O", 
               "COX10", "COX11", "COX15", "COX17", "COX4", 
               "COX5A", "COX5B", "COX6A", "COX6B", "COX6C", 
               "COX7A", "COX7B", "COX7C", "CYC1", "NDUFA10", 
               "NDUFA11", "NDUFA12", "NDUFA13", "NDUFA1", "NDUFA2", 
               "NDUFA3", "NDUFA4", "NDUFA5", "NDUFA6", "NDUFA7", 
               "NDUFA8", "NDUFA9", "NDUFAB1", "NDUFB10", "NDUFB11", 
               "NDUFB1", "NDUFB2", "NDUFB3", "NDUFB4", "NDUFB5", 
               "NDUFB6", "NDUFB7", "NDUFB8", "NDUFB9", "NDUFC1", 
               "NDUFC2", "NDUFS1", "NDUFS2", "NDUFS3", "NDUFS4", 
               "NDUFS5", "NDUFS6", "NDUFS7", "NDUFS8", "NDUFV1", 
               "NDUFV2", "NDUFV3", "QCR10", "QCR2", "QCR6", 
               "QCR7", "QCR8", "QCR9", "SDH3", "SDH4", 
               "SDHA", "SDHB", "UQCRFS1"),
               Intervallo = c("1-1515", "1516-2967", "2968-3702", "3703-4089", "4090-4242", 
               "4243-4999", "5000-5374", "5375-5695", "5696-5950", "5951-6583", 
               "6584-7815", "7816-8546", "8547-9759", "9760-9964", "9965-10474", 
               "10475-10900", "10901-11293", "11294-11509", "11510-11744", "11745-11969", 
               "11970-12315", "12316-12506", "12507-12695", "12696-13532", "13533-14512", 
               "14513-14918", "14919-15333", "15334-15768", "15769-15972", "15973-16275", 
               "16276-16479", "16480-16788", "16789-17115", "17116-17502", "17503-17845", 
               "17846-18307", "18308-19352", "19353-19652", "19653-20177", "20178-20584", 
               "20585-20755", "20756-21033", "21034-21287", "21288-21659", "21660-22223", 
               "22224-22601", "22602-22976", "22977-23421", "23422-23943", "23944-24166", 
               "24167-24496", "24497-26679", "26680-28053", "28054-28817", "28818-29362", 
               "29363-29665", "29666-30061", "30062-30712", "30713-31336", "31337-32731", 
               "32732-33466", "33467-34627", "34628-34780", "34781-36140", "36141-36393", 
               "36394-36630", "36631-36873", "36874-37056", "37057-37317", "37318-37623", 
               "37624-39602", "39603-40103", "40104-40922"))

              
                     vettori_genes <- list()
              
              for (i in 1:nrow(coordinate_genes)) {
                  gene <- coordinate_genes$Gene[i]  # Nome del gene
                  intervallo <- unlist(strsplit(coordinate_genes$Intervallo[i], "-"))  # Coordinate
                  
                  # Verifica che l'intervallo contenga due valori numerici
                  if (length(intervallo) == 2) {
                      start <- as.numeric(intervallo[1])
                      end <- as.numeric(intervallo[2])
                      
                      # Controlla che start ed end siano numerici e non NA
                      if (!is.na(start) && !is.na(end)) {
                          vettore_gene <- values[start:end]
                          vettori_genes[[gene]] <- vettore_gene
                      } else {
                          warning(paste("Intervallo non valido per il gene:", gene))
                      }
                  } else {
                      warning(paste("Intervallo non riconosciuto per il gene:", gene))
                  }
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

