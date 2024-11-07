import os
import json

# Define directory
directory = "./"

# Iterate on files into directory
for filename in os.listdir(directory):
    if filename.endswith("_meme.out"):
        # Extract gene name from file name
        gene_name = filename.split("_")[0]
        
        # Define paths
        input_file = os.path.join(directory, filename)
        output_file = os.path.join(directory, f"{gene_name}_meme_filtered.out")
        
        # Define function to recursively remove unnecessary keys 
        def filter_substitutions(data):
            if isinstance(data, dict):
                if "substitutions" in data:
                    return {"substitutions": data["substitutions"]}
                else:
                    return {key: filter_substitutions(value) for key, value in data.items()}
            elif isinstance(data, list):
                return [filter_substitutions(item) for item in data]
            else:
                return data
        
        # Read file JSON (input)
        with open(input_file, "r") as f:
            data = json.load(f)
        
        # Extract substitutions from json
        filtered_data = filter_substitutions(data)
        
        # Write output and print the confirm!
        with open(output_file, "w") as f:
            json.dump(filtered_data, f, indent=2)
        
        print(f"Operation completed for gene {gene_name}. Data saved in {output_file}")
