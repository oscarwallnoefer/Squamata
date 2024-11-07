#!/bin/bash
# Script to extract 1000 random files (88+88+13+13)
for (( count=0; count<1000; count++ )); do
    block1=$(ls *.fna | shuf -n 73)
    block2=$(ls *.fna | grep -v "$(echo "$block1" | tr ' ' '|')" | shuf -n 73)
    block3=$(ls *.fna | grep -v "$(echo "$block1 $block2" | tr ' ' '|')" | shuf -n 13)
    block4=$(ls *.fna | grep -v "$(echo "$block1 $block2 $block3" | tr ' ' '|')" | shuf -n 13)
    
    combined_files=$(echo "$block1 $block2 $block3 $block4" | tr ' ' '\n' | sort | uniq)

    # Check sum of files = 172
    if [ $(echo "$combined_files" | wc -l) -eq 172 ]; then
        output_dir="Iteration_$count"
        mkdir -p "$output_dir"/Block{1,2,3,4}
        cp $block1 "$output_dir"/Block1/
        cp $block2 "$output_dir"/Block2/
        cp $block3 "$output_dir"/Block3/
        cp $block4 "$output_dir"/Block4/
    else
        count=$((count-1))
    fi
done
