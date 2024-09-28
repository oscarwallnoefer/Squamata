import os
from Bio import SeqIO

# Function to extract species from a FASTA file
def extract_species_from_fasta(fasta_file):
    species = set()
    for record in SeqIO.parse(fasta_file, "fasta"):
        species.add(record.id.split()[0])  # Adjust this part if the header format is different
    return species

# Read the species list from the lista_specie.txt file
with open("species_list.txt", "r") as f:
    total_species_list = [line.strip() for line in f]

# Get all FASTA files in the current directory
fasta_directory = "."  # Change this path if the files are in a different folder
fasta_files = [f for f in os.listdir(fasta_directory) if f.endswith(".fasta") or f.endswith(".fa")]

# Create a dictionary for the completeness matrix
completeness_matrix = {species: [] for species in total_species_list}

# For each FASTA file (gene), check the presence of species
for fasta_file in fasta_files:
    present_species = extract_species_from_fasta(os.path.join(fasta_directory, fasta_file))
    
    for species in total_species_list:
        if species in present_species:
            completeness_matrix[species].append("TRUE")
        else:
            completeness_matrix[species].append("FALSE")

# Sort the species alphabetically
sorted_species = sorted(completeness_matrix.items())

# Save the matrix in a CSV file
import csv

with open("completeness_matrix.csv", "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    
    # Header (gene names)
    writer.writerow(["Species"] + [f.split(".")[0] for f in fasta_files])
    
    # Write the sorted matrix data
    for species, presence in sorted_species:
        writer.writerow([species] + presence)

print(f"Completeness matrix created and sorted: 'completeness_matrix.csv'")
