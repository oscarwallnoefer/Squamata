import json
import pandas as pd
import os

# Define directory 
directory = "./"

# Iterate on files across directory
for filename in os.listdir(directory):
    if filename.endswith("_meme_filtered.out"):
        # Extract gene name from filename
        gene_name = filename.split("_")[0]
        
        # Define paths
        input_file = os.path.join(directory, filename)
        output_file = os.path.join(directory, f"output_{gene_name}.txt")
        
        # Load data from json
        with open(input_file) as f:
            data = json.load(f)

        # Create dictionary list
        table_data = []
        # Create a set to annotate all "Node" keys 
        node_keys = set()

        # Extract only data relative to substitutions
        for key, value in data["substitutions"].items():
            # Iterate through levels after "substitutions" if exist
            if value is not None:
                for sub_key, sub_value in value.items():
                    if sub_value is not None:
                        # Add key Codon
                        row = {'Codons': sub_key}
                        # Add key "root" and all keys beginning with "Node" to the dictionary
                        for k, v in sub_value.items():
                            if k.startswith('Node'):
                                # Add key "Node" and its value to the dictionary
                                row[k] = v
                                # Add key "Node" to set
                                node_keys.add(k)
                            elif k == 'root':
                                # Add key "root" to the dictionary 
                                row[k] = v
                        table_data.append(row)

        # Create data frame with pandas
        df = pd.DataFrame(table_data)

        # Order columns
        columns_order = ['Codons'] + sorted(node_keys)
        if 'root' in df.columns:
            columns_order.append('root')
        df = df[columns_order]

        # Convert DataFrame into strings 
        df_string = df.to_string(index=False)

        # Write string in output file
        with open(output_file, "w") as f:
            f.write(df_string)

        print(f"Operation completed for gene {gene_name}. Data saved in: {output_file}")
