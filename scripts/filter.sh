#!/bin/bash
# Quality filtration using Filtlong

# Load necessary modules
module load tools
module load filtlong/20190515

# Define input and output directories
INPUT_DIR="results/deduplicated"
OUTPUT_DIR="results/filtered"
mkdir -p "$OUTPUT_DIR"

# Filter each FASTQ file
for f in "$INPUT_DIR"/*.fastq; do
    base_name=$(basename "$f")
    echo "Filtering $base_name..."
    filtlong --min_length 500 --keep_percent 90 --target_bases 500000000 "$f" > "$OUTPUT_DIR/filt_${base_name}"
done

echo "Quality filtration completed successfully!"

