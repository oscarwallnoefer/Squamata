#### NB: before using this script, remember to edit treefile. 
#### Treefiles must be in newick format [remove "{Foreground}" adn the last 7 rows from the MEME output.]

import pandas as pd
from ete3 import Tree
import sys

gene=str(sys.argv[1])
t1=Tree(gene+".treefile",format=1)
# Amino acids dictionary (Standard Code)
amino_acid_table = {
    'TTT': 'Phe', 'TCT': 'Ser', 'TAT': 'Tyr', 'TGT': 'Cys',
    'TTC': 'Phe', 'TCC': 'Ser', 'TAC': 'Tyr', 'TGC': 'Cys',
    'TTA': 'Leu', 'TCA': 'Ser', 'TAA': 'Stop', 'TGA': 'Stop',
    'TTG': 'Leu', 'TCG': 'Ser', 'TAG': 'Stop', 'TGG': 'Trp',
    'CTT': 'Leu', 'CCT': 'Pro', 'CAT': 'His', 'CGT': 'Arg',
    'CTC': 'Leu', 'CCC': 'Pro', 'CAC': 'His', 'CGC': 'Arg',
    'CTA': 'Leu', 'CCA': 'Pro', 'CAA': 'Gln', 'CGA': 'Arg',
    'CTG': 'Leu', 'CCG': 'Pro', 'CAG': 'Gln', 'CGG': 'Arg',
    'ATT': 'Ile', 'ACT': 'Thr', 'AAT': 'Asn', 'AGT': 'Ser',
    'ATC': 'Ile', 'ACC': 'Thr', 'AAC': 'Asn', 'AGC': 'Ser',
    'ATA': 'Ile', 'ACA': 'Thr', 'AAA': 'Lys', 'AGA': 'Arg',
    'ATG': 'Met', 'ACG': 'Thr', 'AAG': 'Lys', 'AGG': 'Arg',
    'GTT': 'Val', 'GCT': 'Ala', 'GAT': 'Asp', 'GGT': 'Gly',
    'GTC': 'Val', 'GCC': 'Ala', 'GAC': 'Asp', 'GGC': 'Gly',
    'GTA': 'Val', 'GCA': 'Ala', 'GAA': 'Glu', 'GGA': 'Gly',
    'GTG': 'Val', 'GCG': 'Ala', 'GAG': 'Glu', 'GGG': 'Gly'
}

# Ensure independence of columns (so nodes)
def check_indipendeza_colonne(col1,col2):
    check=True
    print(col1+"_"+col2)
    # Find node of column 1 (col1) across the tree
    node1 = t1.search_nodes(name=col1)[0]
    lineage1=[]
    # Starting from node1, run node-to-root and add nodes to lineage1
    while node1.name:
        node1=node1.up
        lineage1.append(node1.name)
    node2 = t1.search_nodes(name=col2)[0]
    lineage2=[]
    # Same for node2
    while node2.name:
        node2=node2.up
        lineage2.append(node2.name)
    # If node1 show the same lineage of node2 (or viceversa): nodes are NOT independent. If not independent, check=False
    if col1 in lineage2 or col2 in lineage1:
        check=False
    return check

# Find ancestral nodes
def codone_precedente(count,col):
    # Find node into the treefile
    node = t1.search_nodes(name=col)[0]
    codon=""
    # Cycle node-to-root and find the first ancestral node different from the current one. Thus, it is possible reconstruct substitution records (ATG -> ATT)
    while node.name:
        node=node.up
        # Go back of one node: if it is into the table and it is not NA, it is the ancestral node
        if node.name in df_r.columns and pd.notna(df_r[node.name][count]):
            codon=df_r[node.name][count]
            break
    # If running back there is no ancestral codon, this node is the root 
    if not codon:
        codon=df_r["root"][count]
    return codon
    
# Load data from outputs
df = pd.read_csv("output_"+gene+".txt", delim_whitespace=True)
df_r=df

# Remove 'root' colums
if 'root' in df.columns:
    df = df.drop(columns=['root'])

# Translate "---" in "NaN"
df = df.replace('---', pd.NA)
df_r = df_r.replace('---', pd.NA)

# Function to compare columns and calculate number of substitions (total and synonymous) 
def confronta_colonne(col1, col2):
    sostituzioni_totali = 0
    sostituzioni_sinonime = 0
    count=0
    for val1, val2 in zip(df[col1], df[col2]):
        if pd.notna(val1) and pd.notna(val2):  # Verifica se entrambi i valori non sono mancanti
            sostituzioni_totali += 1
            if amino_acid_table.get(val1) == amino_acid_table.get(val2):
                # Obtain ancestral codons of val1 and val2
                cod_prece1=codone_precedente(count,col1)
                cod_prece2=codone_precedente(count,col2)
                print(amino_acid_table.get(val1)+"-"+amino_acid_table.get(cod_prece1)+" "+amino_acid_table.get(val2)+"-"+amino_acid_table.get(cod_prece2))
                # If the ancestral codon of val1 correspond to an amino acid different from val2: classify the substitution as synonymous. Same for val2.
                if amino_acid_table.get(cod_prece1) != amino_acid_table.get(val1) and amino_acid_table.get(cod_prece2) != amino_acid_table.get(val2):
                    print(amino_acid_table.get(val1)+"-"+amino_acid_table.get(cod_prece1)+"||"+amino_acid_table.get(val2)+"-"+amino_acid_table.get(cod_prece2))
                    sostituzioni_sinonime += 1
        count+=1
    return sostituzioni_totali, sostituzioni_sinonime


# Extract all columns but not 'Codons'
colonne = df.columns[1:]

# List tuples of values (total substitutions, synonymous substitutions)
data_points = []
for i in range(len(colonne)):
    for j in range(i+1, len(colonne)):
        col1 = colonne[i]
        col2 = colonne[j]
        # Use the function "check_indipendenza_colonne) to check independence between nodes. If are independet, proceed with comparisons
        check=check_indipendeza_colonne(col1,col2)
        if check:
            sostituzioni_totali, sostituzioni_sinonime = confronta_colonne(col1, col2)
            print(col1+" "+col2+" "+str(sostituzioni_totali))
            if sostituzioni_totali > 0:  # Verifica se ci sono sostituzioni totali
                data_points.append(((col1, col2), (sostituzioni_totali, sostituzioni_sinonime)))

# Print list of tuples to the output
print("Couples of nodes and relative data:")
for coppia, dati in data_points:
    print(f"{coppia}: {dati}")

# Write results in a file with gene name
output_file_name = f"coordinate_"+gene
with open(output_file_name, 'w') as output_file:
    output_file.write("Couples of nodes and relative data:\n")
    for coppia, dati in data_points:
        output_file.write(f"{coppia}: {dati}\n")
