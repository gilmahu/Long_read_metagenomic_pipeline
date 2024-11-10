#!/bin/bash
# Host genome removal using Minimap2 and Samtools

# Load necessary modules
module load tools
module load minimap2/2.24r1122
module load samtools/1.17

# Define input, output, and reference genome directories
REFERENCE_GENOME="data/reference/Ref_BosTaurus_GCF_002263795.fna" ## could be humaan genome
INPUT_DIR="results/filtered"
OUTPUT_DIR="results/host_removed"
mkdir -p "$OUTPUT_DIR"

# Index the reference genome
echo "Indexing reference genome..."
minimap2 -d "${REFERENCE_GENOME}.mmi" "$REFERENCE_GENOME"

# Loop through each FASTQ file and align reads to the host genome
for input_file in "$INPUT_DIR"/*.fastq; do
    base_name=$(basename "${input_file%.fastq}")
    echo "Processing $base_name..."

    # Step 1: Align reads
    minimap2 -ax map-ont "${REFERENCE_GENOME}.mmi" "$input_file" > "$OUTPUT_DIR/${base_name}_aligned.sam"

    # Step 2: Convert SAM to BAM, sort, and filter
    samtools view -S -b "$OUTPUT_DIR/${base_name}_aligned.sam" > "$OUTPUT_DIR/${base_name}_aligned.bam"
    samtools sort -o "$OUTPUT_DIR/${base_name}_sorted.bam" "$OUTPUT_DIR/${base_name}_aligned.bam"
    samtools view -h

