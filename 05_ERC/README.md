# Evolutionary Rate Correlations

**Evolutionary rate correlation** (ERC, also known as _evolutionary rate covariation_) is a widely used approach to investigate physical interactions and shared functionality among proteins. 
Since correlation between branch lengths are exposed to phylogenetic bias (_PIC: Phylogenetic Indipendet Contrast_), we developed a method to avoid this effect. Furthermore, we have built a strong approach to test correlation between branch lengths, based on distribution of thousends of Spearman's Rho. See `workflow_ERC.svg`. 

Branch lengths are optimized with a custom phylo tree (in our case Squamata species tree _Burbrick et al. 2020_). We used RAxML with _"-f e"_ option, specifing the partition file and the model selection.
        
        raxmlHPC -f e -t ortho_erc_test.tree -m GTRGAMMAIX -q mt_nt_oxphos.best_scheme -s concatenated.out -n TEST
        # -t = species tree based on literature.
        # -m = model selected
        # -q = best partitioning scheme obtained from iqtree, or the partition file (in RAxML format)
        # -s = concatenated alignment
        # -n = output prefix

---

##  Pipeline extensive approach

| 00_Preliminary_Steps | Script |
|---|---|
|a. Branch lenghts are optimized from both mitochondrial and nuclear OXPHOS genes (mtOXPHOS and nucOXPHOS). | `RAxML with "-f e" option` |
|b. Four different set of orthologs are extracted from our dataset of ~900 BUSCO genes as follows: 73 genes (Block1), 73 (Block2), 13 (Block3) and 13 (Block4). Reiterate the extraction 1000 times. Each "Block" must be indipendent from the others for each iteraction. OXPHOS genes were been previously removed from BUSCO dataset.| `Random_fna_from_folder_x1000.sh`|
|c. Branch lengths are optimized across all the 1000 iterations. Then, extract all the results. | `Run_RAxML_Across_Folders.sh` `Extraction_treefile_across_folders.sh` |

Then, R. 

| 01_Normalization_&_Plots| Script|
|---|---|
|Load newick trees, scale branch lengths. |`DensityPlot_nucOXPHOS_BUSCO.R`|
|Normalization: for each iterations we used Block2 to normalize both Block1 and nuclear OXPHOS, and Block4 to normalize both Block3 and mitochondrial OXPHOS. |`DensityPlot_nucOXPHOS_BUSCO.R`|
|Calculate Spearman Correlations|`DensityPlot_nucOXPHOS_BUSCO.R`|
|Plot all the values of Rho|`DensityPlot_nucOXPHOS_BUSCO.R`|

NB: Set `DensityPlot_Nucox_Ortho.R` depending on your variables. For example, when mitochondrial OXPHOS evolutionary rates are considered, you have to normalize Block3 and mitochondrial branch lengths with Block4.

Then, plot correlations (`DensityPlots.R`).


---

# Pipeline

![workflow_ERC](workflow_ERC.svg)
