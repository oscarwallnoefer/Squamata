import glob
import os

# Get the list of all files into the current directory that begin with "output_"
file_list = glob.glob("output_*")

# Loop across the list
for input_filename in file_list:
    # Get gene name from file name
    gene_name = os.path.splitext(input_filename)[0].replace("output_", "")
    # Run script for the current gene
    os.system("python confronti2_solo_NS.py " + gene_name)
