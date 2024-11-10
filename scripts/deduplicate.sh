#!/bin/bash
# Deduplication of reads using SeqKit

# Load necessary modules
module load tools
module load pigz/2.3.4
module load seqkit/0.7.1

# Define input and output directories
INPUT_DIR="results/demultiplexed"
OUTPUT_DIR="results/deduplicated"
mkdir -p "$OUTPUT_DIR"

# Deduplicate each FASTQ file
for f in "$INPUT_DIR"/*.fastq; do
    base_name=$(basename "$f")
    echo "Processing $base_name..."
    seqkit rmdup --by-seq --ignore-case --md5 "$f" -o "$OUTPUT_DIR/ddp_${base_name}"
done

echo "Deduplication completed successfully!"

