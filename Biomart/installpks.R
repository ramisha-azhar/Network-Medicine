#R code to convert Gene_symgol into Entrez_gene_ID

#To install Biomart

#install BiocManager
if (!require("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager") 

#use BiocManager to install biomart
BiocManager::install("biomaRt")
