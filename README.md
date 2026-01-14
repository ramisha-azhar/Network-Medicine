# Network-Medicine
- installpks.r-
This script installs the required Bioconductor packages needed to **convert gene symbols into Entrez Gene IDs**. It first checks for the presence of the BiocManager package and installs it if missing, and then uses BiocManager to install the biomaRt package, which provides access to BioMart databases for gene identifier mapping

- glioblastoma_gene_list.txt- I have downloaded my gene list from the phenopedia
Phenopedia is a literature-based database that catalogs genes associated with human diseases and phenotypes, supporting disease-gene discovery and network-based analyses.
https://phgkb.cdc.gov/PHGKB/startPagePhenoPedia.action (this is the website)

- BioMart-Ensembl https://www.ensembl.org/biomart/martview/6cbb47295e71e580879f5083bfd42e0c
Is a BioMart query interface from Ensembl that lets us customize and download datasets based on selected filters and attributes.
we can either enter the gene list here or use the R script to get the Entrez Gene ID 
  
- query_Biomart -
**Gene Symbol to Entrez Gene ID Conversion Using biomaRt**
This R script converts a list of **glioblastoma-associated gene symbols** into their corresponding Entrez Gene IDs using the **biomaRt package** and the Ensembl **BioMart database**. The input gene list is read from the file glioblastoma_gene_list.txt, which contains human gene symbols relevant to glioblastoma analysis. Converting gene symbols to standardized Entrez Gene IDs ensures consistency and compatibility for downstream network medicine and bioinformatics analyses.
The script connects to the **Ensembl human gene dataset (hsapiens_gene_ensembl**) using the **useMart() function**. This function establishes a connection to a specific BioMart database and dataset, allowing access to gene annotation data stored in Ensembl. Once the connection is established, the **getBM() function** is used to query the database. getBM() retrieves selected attributes—in this case, HGNC gene symbols and Entrez Gene IDs—based on user-defined filters and input values. The resulting gene identifier mapping is then written to a tab-delimited output file for further analysis. in this case the file name is **conversion.txt**

- interactome I have downloaded my interactome from here https://www.nature.com/ncomms/ it is a Nature Communications publishes influential studies on interactome organization and network-based approaches to understanding disease and biological systems I want to map my disease gene on the enteractome for that I make sure the  gene identifiers are entrez gene IDs for both the files glioblastoma and interactome This file contains a curated human protein–protein interaction interactome, represented as gene–gene interactions with Entrez Gene IDs and supported by multiple experimental databases, and is used as the reference network for disease module analysis
- DIAMOnd
DIAMOnD (DIseAse Module Detection) is a network‑medicine algorithm that expands a known set of disease genes by identifying new genes that are unusually connected to them in the human interactome. It is now used to predict novel disease‑associated genes from protein–protein interaction (PPI) networks.
DIAMOnD is a computational method designed to uncover disease modules—clusters of genes in the interactome that collectively contribute to a disease. Instead of looking at genes individually, it focuses on how they are connected.
A disease module is based on the idea that disease‑related genes tend to cluster together in the interactome .
DIAMOnD starts with a set of known disease genes (the “seed protein”) and then:
Analyzes connectivity patterns between seed protein and all other nodes in the interactome
Ranks candidate protein by how unexpectedly connected they are to the seed set
Adds genes iteratively, one at a time, based on statistical significance
Builds a disease module that expands the original seed list
This approach is grounded in the observation that disease genes are not randomly scattered but form dense, statistically enriched neighborhoods
DIAMOnD is powerful because it:
Predicts new disease genes even when experimental data is limited
Uses the structure of the interactome rather than expression levels alone
Supports multi‑omics integration (e.g., with SWIM, WGCNA, GWAS, etc.)
Improves biomarker discovery by identifying genes functionally close to known disease drivers
Helps build mechanistic disease networks for cancer, neurodegeneration, and complex diseases
**DIAMOnd algorithm**
Diamond uses the hypergeometric test to calculate the probability of having Ks which is do the k nearest neighbour of a certain protein include a significance fraction of seed protein When the p value is small we concluded that the list of the nearest neighbour of a certain protein is enriched in seed protein respect to what one would expect by chance

Then we use the connectivity significance which is at least one link to the seed protein to calculate the smallest p value among all significance fraction of interaction and add it to the set of our initial seed protein in each iteration, the protein with the highest rank that is lowest connectivity significance is added to the set of the seed protein and are called candidate protein

We fix the number of iteration then diamond give us all the predicted candidate protein following the algorithm

To validate the disease module we use the threshold that is total number of protein to be considered  to bound our disease module we can chose our threshold through biological criterion

In biological criterion is use the slide window approach in which each protein in the slide window is annotated the one which is similar to the seed gene are added to our seed gene set as the true positive,  the size of the slide window is similar to the initial seed protein side

We perform the functional enrichment analysis to identify the GO terms enriched in our list of the initial seed proteins then we see the  candidate protein in our sliding window the one that are enriched with GO term of the initial seed protein are called true positive and they are added to our seed protein set for the slide window approach we use hypergeometric test which gives us true positive in each iteration
**SWIMmer V/S DIAMOnD**
I started from the curated list of seed genes that are breast neoplasms , DIAMOnD iteratively adds genes that are significantly connected to the seed set. At each iteration, it evaluates all remaining genes in the network and selects the one with the most statistically unexpected number of connections to the current module. This process continues until a predefined number of genes are added that are enrichment significantly and those genes are switch genes from our dataset TCGA that is breast carcinoma(brca)
The enrichment p-value plotted across iterations reflects how strongly the added genes are connected to the seed set compared to random expectation. A sharp drop followed by a plateau (as seen around iteration 200 in the graph) indicates the optimal module size—beyond which added genes may no longer be biologically relevant.

<img width="748" height="368" alt="image" src="https://github.com/user-attachments/assets/2228abde-b542-4e7b-9708-fc0e3e63a4b4" />
This plot shows how the enrichment p-value changes as DIAMOnD adds genes to the disease module over 500 iterations. Each iteration represents one gene added to the module.
Y-axis: Enrichment p-value (log scale)
Measures how statistically significant the added gene is in terms of connectivity to the seed set.
Lower values (closer to 10⁻³ or 10⁻⁴) mean stronger enrichment—the gene is highly connected to the seed genes.
The log scale helps visualize small p-values more clearly.
X-axis: Iteration
Each point corresponds to the p-value of the gene added at that iteration.
The algorithm starts with your seed genes and adds one gene per iteration based on connectivity significance.
Early iterations (1–200): DIAMOnD is adding genes that are tightly linked to your disease module and are considered as threshold for us to make the disease module
Later iterations (200–500): Connectivity weakens, and added genes may not be as biologically meaningful.
The dashed line helps us decide how many genes to keep for downstream analysis 
“A substantial proportion of SWIM‑identified switch genes overlapped with the list of the candidat protein formed by diamond , indicating strong biological relevance. When DIAMOnD was applied to expand the disease module, the algorithm successfully recovered all true‑positive switch genes. This convergence between expression‑based and topology‑based methods reinforces the robustness of our identified gene set and highlights their central role in the breast cancer interactome.”


![Uploading image.png…]()

This plot represents the random baseline for DIAMOnD. It shows what happens when the algorithm is run on a shuffled or randomized network, where no real biological signal is expected. It serves as a null model to benchmark the significance of your real results.When we compare this to your actual DIAMOnD run, where the p-values drop sharply and stay low, you can confidently say:
“The real enrichment is not due to chance — the disease module is statistically significant.”


