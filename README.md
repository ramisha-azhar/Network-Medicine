# Network-Medicine
-installpks.r
This script installs the required Bioconductor packages needed to **convert gene symbols into Entrez Gene IDs**. It first checks for the presence of the BiocManager package and installs it if missing, and then uses BiocManager to install the biomaRt package, which provides access to BioMart databases for gene identifier mapping

-query_Biomart 
**Gene Symbol to Entrez Gene ID Conversion Using biomaRt**
This R script converts a list of **glioblastoma-associated gene symbols** into their corresponding Entrez Gene IDs using the **biomaRt package** and the Ensembl **BioMart database**. The input gene list is read from the file glioblastoma_gene_list.txt, which contains human gene symbols relevant to glioblastoma analysis. Converting gene symbols to standardized Entrez Gene IDs ensures consistency and compatibility for downstream network medicine and bioinformatics analyses.
The script connects to the **Ensembl human gene dataset (hsapiens_gene_ensembl**) using the **useMart() function**. This function establishes a connection to a specific BioMart database and dataset, allowing access to gene annotation data stored in Ensembl. Once the connection is established, the **getBM() function** is used to query the database. getBM() retrieves selected attributes—in this case, HGNC gene symbols and Entrez Gene IDs—based on user-defined filters and input values. The resulting gene identifier mapping is then written to a tab-delimited output file for further analysis. in this case the file name is **conversion.txt**
