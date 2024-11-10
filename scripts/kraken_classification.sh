#!/bin/bash
# Taxonomic classification using Kraken2

# Load necessary modules
module load tools
module load kraken2/2.1.3

# Define input, output directories, and Kraken2 database path
DB_PATH="/home/projects/ku_00158/data/gildas_data/kraken_gil/"
INPUT_DIR="results/host_removed"
OUTPUT_DIR="results/kraken_results"
THREADS=32
mkdir -p "$OUTPUT_DIR"

# Loop through each FASTQ file for classification
for f in "$INPUT_DIR"/*.fastq; do
    sample_name=$(basename "$f" .fastq)
    echo "Running Kraken2 for $sample_name..."

    kraken2 --db "$DB_PATH" --threads "$THREADS" \
        --report "$OUTPUT_DIR/${sample_name}_report.txt" \
        --output "$OUTPUT_DIR/${sample_name}_output.txt" "$f"

    echo "Kraken2 completed for $sample_name."
done

echo "All Kraken2 classifications completed successfully!"

