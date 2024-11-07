# Test for convergences

## Step 1: run MEME

## Step 2: extract substitutions form json file (MEME output)

Prepare a folder where both [gene name].treefile and [gene name]_meme.out are located. 

Run `1_loop_extraction_json.py`

Output names: [gene name]_meme_filtered.out

## Step 3: for each site under episodic diversification, extract the respective codon from all the .treefile nodes.

Run `2_loop_codon_table.py`

Output names: output_[gene name].txt

Each gene has a [gene].treefile in newick format, where nodes are annotated (es. Node29). Node names must correspond in all the .treefile of your dataset. 
This script creates a data frame where rows are sites (positions of sites under episodic diversification) and colums are nodes (See the example belowe).
Remember: If you have only one species and you want to tag it, substitute the species name with "NodeXX" in the newick file. As well, substitute the species name in the "output_GENENAME.txt" with "NodeXX".

Example of output:

| Codon | Node27 | Node99 | Node40 | Root|
|---|---|---|---|---|
|12| AAT | NaN | --- | AAA |
|234| CTC | NaN | TTT | ATC | 
|300| NaN | --- | CGG |CGC |
|421| NaN | --- | TCC | AAA | 


## Step 4: Convergent Nodes

Step 4_option_A and Step 4_option_B are indipendent. Select one of them depending on your goal.

+ ### Step 4_option_A

  Run `confronti2.py`

  Output name: coordinate_[gene name].txt
  
  Here we extract from the previous output all couples of nodes which show **both synonym and non-synonym convergences**. 

  Output format is like: 
      ('Node10', 'Node100'): (1, 1)
      ('Node10', 'Node105'): (13, 7)
      ('Node10', 'Node107'): (2, 1)
  
  Thus, an editing phase with `for a in coordinate_*; do sed "s/[:,'()]//g" $a > new_$a; done` is recommended before the plotting step. 

+ ### Step 4_option_B
  
  Run `confronti2_solo_NS.py`

  Output name: coordinate_[gene name].txt
  
  Here we extract from the previous output all couples of nodes which show **only non-synonym convergences**. 

  Output format is like: 
      ('Node10', 'Node100'): (1, 1)
      ('Node10', 'Node105'): (13, 7)
      ('Node10', 'Node107'): (2, 1)
  
  Thus, an editing phase with `for a in coordinate_*; do sed "s/[:,'()]//g" $a > new_$a; done` is recommended before the plotting step. 

---

## Workflow scheme
### NB: Before running scripts, read their headers for important informations. 

![schema](https://github.com/oscarwallnoefer/Squamata_MainRepository/assets/123078003/af131f4f-aae5-4cbd-8f95-09f6fdfe6800)
