#Load the biomaRt library
library(biomaRt)

options(stringsAsFactors = F)

setwd('C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/code')


#Read the gene list(containing gene symbols)
list <- read.table("../Biomart/glioblastoma_gene_list.txt",sep = "\t", check.names = F, header = F)
View(list)

#Convert to data frame and rename column
list <- data.frame(list$V1)
colnames(list) <- "GeneSymbol"


#Connect to Ensembl
ensembl <- useMart("ensembl",dataset="hsapiens_gene_ensembl")

attributes <- listAttributes(ensembl) 
filters <- listFilters(ensembl)

#Query Ensembl for conversion
conversion <- getBM(attributes=c('hgnc_symbol','entrezgene_id'),
                    filters='hgnc_symbol',
                    values=list, #gene symbols from our list
                    mart=ensembl)
colnames(conversion) <- c("gene_symbol","entrez_geneID")

write.table(conversion, "../Biomart/conversion.txt", sep = "\t", row.names = FALSE, col.names = T, quote = FALSE)





