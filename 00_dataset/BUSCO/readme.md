# Squamata BUSCO genes

The BUSCO v.5.5.0 pipeline was run with the Metazoa_odb10 dataset to assess the completeness of our assemblies. Species with low BUSCO completeness scores (< 50%) were removed from the dataset. We included in our third dataset, the BUSCO genes dataset, all single copy BUSCO genes that were inferred in at least 80% of our species. We made sure that all OXPHOS genes were filtered out from the BUSCO genes dataset. 

For BUSCO genes, multiple sequence alignment, trimming, and creation of a supermatrix were performed using the amazing `BUSCO_phylogenomics.py` (McGowan 2023), both for nucleotide and amino acid sequences. 

[BUSCO_phylogenomics.py](https://github.com/jamiemcg/BUSCO_phylogenomics?tab=readme-ov-file)

