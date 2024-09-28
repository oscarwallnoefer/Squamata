# Single Site Likelihood Support 

Maximum likelihood per site means that the likelihood of each site of our concatenated treefile (concatenated.out) is tested on both mitochondrial and nuclear tree (specie tree) topology.

Command: `raxmlHPC -f G -s concatenated.out -m [model] -z [mt or busco_topology.tree] -n [MT or NUC_hypothesis]`

Then, from the two outputs delta values are extracted (MLxSite-contact - MLxSite-non_contact):
+ values > 0 likelihood towards the MT topology
+ values < 0 likelihood towards the NUC topology

R was used to plot likelihoods. Delta > 0.5 or < -0.5 were highlighted, since they show strong support levels for one tree or the other.

R:
       
+ `mt_mlxsite <- read.table("RAxML_perSiteLLs.MT", skip = 1)`
+ `nuc_contact_mlxsite <- read.table("RAxML_perSiteLLs.NUC", skip = 1)`
+ `mt_mlxsite <- mt_mlxsite[,-1]`
+ `nuc_mlxsite <-nuc_mlxsite[,-1]`
+ `delta <- mt_mlxsite - nuc_mlxsite`
+ `values <- unlist(delta)`

Then:
       coordinate_genes <- data.frame(
              Gene = c("ATP5A1", "ATP5B", ...)
              Intervallo = c("1-1599", "1600-3189", ...))
         
       vettori_genes <- list()
           for (i in 1:nrow(coordinate_genes)) { #Iterate through each gene across the coordinate table
               gene <- coordinate_genes$Gene[i]  # Gene name
               intervallo <- unlist(strsplit(coordinate_genes$Intervallo[i], "-"))  # Interval of coordinates
               start <- as.numeric(intervallo[1])
               end <- as.numeric(intervallo[2])
               # Estract values corresponding to the current gene
               vettore_gene <- values[start:end]
               # Assign the vector to the corresponding gene in the list
               vettori_genes[[gene]] <- vettore_gene
           }
