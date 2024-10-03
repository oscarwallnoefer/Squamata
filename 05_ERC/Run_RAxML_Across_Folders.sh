#!/bin/bash
# Script to run raxml across subfolders (Iteration_*/Block*)
main_directory="Iterations"
for iteration_folder in "$main_directory"/Iteration_*/; do
    for block_folder in "$iteration_folder"/Block*/; do
        cd "$block_folder" || exit

        raxmlHPC -f e -t ortho_erc_test.tree -m GTRGAMMA -s concatenated.out -q partitions.txt -n TEST

        cd - || exit
    done
done
