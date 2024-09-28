# Single Site Likelihood Support 

Maximum likelihood per site means that the likelihood of each site of our concatenated treefile (concatenated.out) is tested on both mitochondrial and nuclear tree (specie tree) topology.

Command: `raxmlHPC -f G -s concatenated.out -m [model] -z [mt or busco_topology.tree] -n [MT or NUC_hypothesis]`

Then, from the two outputs delta values are extracted (MLxSite-contact - MLxSite-non_contact):
+ values > 0 likelihood towards the MT topology
+ values < 0 likelihood towards the NUC topology

R was used to plot likelihoods. Delta > 0.5 or < -0.5 were highlighted, since they show strong support levels for one tree or the other.

R:
       
`mt_mlxsite <- read.table("RAxML_perSiteLLs.MT", skip = 1)`
         
`nuc_contact_mlxsite <- read.table("RAxML_perSiteLLs.NUC", skip = 1)`
                 
`mt_mlxsite <- mt_mlxsite[,-1]`
         
`nuc_mlxsite <-nuc_mlxsite[,-1]`
                 
`delta <- mt_mlxsite - nuc_mlxsite`
                 
`values <- unlist(delta)`


