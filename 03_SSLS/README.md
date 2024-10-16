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
    "SDHA", "SDHB", "UQCRFS1"
  ),
  Intervallo = c(
    "1-2556", "2557-4281", "4282-5556", "5557-6621", "6622-6978", 
    "6979-11043", "11044-11772", "11773-12342", "12343-12930", "12931-13980", 
    "13981-16344", "16345-17301", "17302-18840", "18841-19302", "19303-19986", 
    "19987-20877", "20878-21414", "21415-22173", "22174-22776", "22777-23178", 
    "23179-23850", "23851-24180", "24181-24372", "24373-26208", "26209-27801", 
    "27802-28278", "28279-29079", "29080-29931", "29932-30327", "30328-30846", 
    "30847-31671", "31672-32034", "32035-32685", "32686-33228", "33229-33825", 
    "33826-34716", "34717-39744", "39745-40593", "40594-41364", "41365-42180", 
    "42181-42588", "42589-42906", "42907-43563", "43564-44178", "44179-44991", 
    "44992-45498", "45499-45900", "45901-46920", "46921-47766", "47767-48282", 
    "48283-49104", "49105-54333", "54334-55980", "55981-56976", "56977-58029", 
    "58030-58509", "58510-59124", "59125-60666", "60667-61545", "61546-64098", 
    "64099-67851", "67852-70047", "70048-70653", "70654-72363", "72364-72699", 
    "72700-73263", "73264-73575", "73576-74019", "74020-75912", "75913-76701", 
    "76702-87648", "87649-89352", "89353-90372"
  )
)

              
                     vettori_genes <- list()
              
              for (i in 1:nrow(coordinate_genes)) {
                  gene <- coordinate_genes$Gene[i]  # Nome del gene
                  intervallo <- unlist(strsplit(coordinate_genes$Intervallo[i], "-"))  # Coordinate
                  
                  if (length(intervallo) == 2) {
                      start <- as.numeric(intervallo[1])
                      end <- as.numeric(intervallo[2])
                      
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

