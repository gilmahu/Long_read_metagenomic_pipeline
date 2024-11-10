#!/bin/bash
# Demultiplexing with Guppy

# Load necessary modules
module load tools
module load cuda/toolkit/12.2.0

# Define input and output directories
INPUT_DIR="data/raw_reads"
OUTPUT_DIR="results/demultiplexed"
mkdir -p "$OUTPUT_DIR"

# Run Guppy demultiplexing
/home/projects/ku_00158/data/gildas_data/ont-guppy/bin/guppy_barcoder \
    -i "$INPUT_DIR" -s "$OUTPUT_DIR" -t 40 --barcode_kits SQK-RBK114-24 -r

