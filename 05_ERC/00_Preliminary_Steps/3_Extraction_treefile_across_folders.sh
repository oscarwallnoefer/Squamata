#!/bin/bash
# Script to extract all the output files (RAxML_result.TEST) 
destination_folder="00_treefile"
mkdir -p "$destination_folder"
iteration_folders=$(find . -maxdepth 1 -type d -name "Iteration_*" | sort)

# Loop across iteration folders
for iteration_folder in $iteration_folders; do
    # Extraction of the iteration number
    iteration_number=$(basename "$iteration_folder" | sed 's/Iteration_//')
    
    # Find subfolders "Block" and loop to extract "RAxML_result.TEST"
    block_folders=$(find "$iteration_folder" -maxdepth 1 -type d -name "Block[1-4]" | sort)
    for block_folder in $block_folders; do
        raxml_file=$(find "$block_folder" -maxdepth 1 -type f -name "RAxML_result.TEST")
        
        if [ -f "$raxml_file" ]; then
            new_filename="rax_Iteration${iteration_number}_$(basename "$block_folder").treefile"
            cp "$raxml_file" "$destination_folder/$new_filename"
            echo "Copied and renamed: $raxml_file -> $destination_folder/$new_filename"
        fi
    done
done
