#!/bin/bash
# Abundance estimation using Bracken

# Load necessary modules
module load tools
module load bracken/2.9

# Define input, output directories, and Bracken database path
KRAKEN_DB_PATH="/home/databases/kraken2/bracken/"
INPUT_DIR="results/kraken_results"
OUTPUT_DIR="results/bracken_results"
READ_LENGTH=150  # The read length used in your Kraken2 analysis
THRESHOLD=1
LEVEL="S"  # Desired taxonomic level (e.g., S for species, G for genus)

mkdir -p "$OUTPUT_DIR"

# Loop through each Kraken2 report file for Bracken analysis
for report in "$INPUT_DIR"/*_report.txt; do
    filename=$(basename "$report" .txt)
    echo "Running Bracken for $filename..."

    bracken -d "$KRAKEN_DB_PATH" \
            -i "$report" \
            -o "$OUTPUT_DIR/${filename}_bracken.txt" \
            -r "$READ_LENGTH" \
            -l "$LEVEL" \
            -t "$THRESHOLD"

    echo "Bracken analysis completed for $filename."
done

echo "All Bracken analyses completed successfully!"

