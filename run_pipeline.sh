#!/bin/bash
# Master script for running the full ICRECT metagenomic pipeline

echo "Starting the ICRECT metagenomic pipeline..."

# Step 1: Demultiplexing
echo "Step 1: Demultiplexing..."
bash scripts/demultiplex.sh

# Step 2: Deduplication
echo "Step 2: Deduplication..."
bash scripts/deduplicate.sh

# Step 3: Quality Filtration
echo "Step 3: Quality Filtration..."
bash scripts/filter.sh

# Step 4: Host Genome Removal
echo "Step 4: Host Genome Removal..."
bash scripts/host_removal.sh

# Step 5: Taxonomic Classification with Kraken2
echo "Step 5: Taxonomic Classification with Kraken2..."
bash scripts/kraken_classification.sh

# Step 6: Abundance Estimation with Bracken
echo "Step 6: Abundance Estimation with Bracken..."
bash scripts/run_bracken.sh

# Step 7: Export to BIOM Format
echo "Step 7: Exporting to BIOM format..."
bash scripts/export_biom.sh

# Step 8: R Analysis
echo "Step 8: Running R analysis..."
Rscript -e "rmarkdown::render('R_analysis/ICRECT_hww_biom.Rmd')"

# Step 9: Jupyter Notebook ARG Analysis
echo "Step 9: Running Jupyter Notebook ARG analysis..."
conda activate icrect_env
jupyter nbconvert --execute notebooks/ARG_Mapping_rgi_bwt_ONT.ipynb --to html

echo "Pipeline completed successfully! All results are saved in the 'results/' folder."

