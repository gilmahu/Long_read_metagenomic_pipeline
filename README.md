# Long_read_metagenomic_pipeline
Comprehensive pipeline for metagenomic analysis using Nanopore sequencing

---

# **ICRECT Long-Read Metagenomic Analysis Pipeline**

## **Overview**
This repository contains a comprehensive pipeline for analyzing long-read metagenomic data generated from Nanopore sequencing. The pipeline includes steps for demultiplexing, quality control, host genome removal, taxonomic classification, abundance estimation, and antimicrobial resistance gene (ARG) detection. The final analysis is performed using R and Jupyter Notebook.

## **Directory Structure**
```
ICRECT_Pipeline/
├── data/                  # Raw and reference data
├── scripts/               # Shell scripts for each analysis step
├── results/               # Processed results from each pipeline stage
├── notebooks/             # Jupyter Notebook for ARG analysis
├── R_analysis/            # R Markdown file for compositional analysis
├── logs/                  # Log files for tracking analysis progress
└── README.md              # This documentation file
```

## **Installation & Dependencies**
Ensure you have the following tools installed:
- **Conda/Mamba** for environment management
- **Guppy** for demultiplexing
- **SeqKit** for deduplication
- **Filtlong** for quality filtration
- **Minimap2 & Samtools** for host genome removal
- **Kraken2 & Bracken** for taxonomic classification and abundance estimation
- **RGI** for ARG detection
- **Jupyter Notebook** and **R** for downstream analysis

### **Setting Up the Environment**
You can install the required tools using Conda:
```bash
conda create -n icrect_env guppy seqkit filtlong minimap2 samtools kraken2 bracken rgi jupyter r-essentials
conda activate icrect_env
```

## **Pipeline Workflow**

### **1. Demultiplexing**
Demultiplex the raw reads using Guppy:
```bash
bash scripts/demultiplex.sh
```
Output: `results/demultiplexed/`

### **2. Deduplication**
Remove duplicate reads using SeqKit:
```bash
bash scripts/deduplicate.sh
```
Output: `results/deduplicated/`

### **3. Quality Filtration**
Filter low-quality reads using Filtlong:
```bash
bash scripts/filter.sh
```
Output: `results/filtered/`

### **4. Host Genome Removal**
Align reads to the host genome and remove host-aligned reads using Minimap2 and Samtools:
```bash
bash scripts/host_removal.sh
```
Output: `results/host_removed/`

### **5. Taxonomic Classification**
Classify reads using Kraken2:
```bash
bash scripts/kraken_classification.sh
```
Output: `results/kraken_results/`

### **6. Abundance Estimation**
Refine taxonomic classification with Bracken:
```bash
bash scripts/run_bracken.sh
```
Output: `results/bracken_results/`

### **7. Export to BIOM Format**
Convert Bracken results to a BIOM format for R analysis:
```bash
bash scripts/export_biom.sh
```
Output: `results/biom_output/icrect_biom.json`

### **8. R Analysis**
Run the R Markdown file for compositional analysis:
```bash
Rscript -e "rmarkdown::render('R_analysis/ICRECT_hww_biom.Rmd')"
```
Output: `R_analysis/ICRECT_hww_biom.html`

### **9. Jupyter Notebook Analysis**
Analyze the ARG results using Jupyter Notebook:
```bash
conda activate icrect_env
jupyter notebook notebooks/ARG_Mapping_rgi_bwt_ONT.ipynb
```
Output: Visualizations and analysis of ARG profiles.

## **How to Run the Full Pipeline**
To run the entire pipeline step by step, execute each script in order as shown above. Alternatively, create a master script to automate the process.

## **Expected Output**
The pipeline generates:
- Demultiplexed and deduplicated FASTQ files
- Filtered reads and cleaned BAM files
- Taxonomic classification reports (`*_report.txt`)
- Abundance estimates (`*_bracken.txt`)
- A BIOM file for R analysis (`icrect_biom.json`)
- Compositional analysis report (`ICRECT_hww_biom.html`)
- ARG analysis report (viewed via Jupyter Notebook)

## **Troubleshooting**
- Ensure all input directories and filenames match those specified in the scripts.
- Check the `logs/` folder for error logs if any step fails.

## **Contributing**
Feel free to fork the repository and submit pull requests for improvements.

