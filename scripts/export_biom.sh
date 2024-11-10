#!/bin/bash
# Export Bracken results to BIOM format using kraken-biom

# Activate the conda environment for kraken-biom
conda activate kraken-biom36

# Define input and output directories
INPUT_DIR="results/bracken_results"
OUTPUT_FILE="results/biom_output/icrect_biom.json"
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Export to BIOM format
echo "Converting Bracken results to BIOM format..."
kraken-biom "$INPUT_DIR"/*.txt -o "$OUTPUT_FILE" --fmt json

echo "BIOM export completed successfully! Output saved to $OUTPUT_FILE."

