library(gplots)
library(sfsmisc)

options(stringsAsFactors = F)

setwd("C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/DIAMond/code/code")

#################################
source("script/getInputData.R")
source("script/makeConversion.R")
#################################
tag <- "brca"
random <- TRUE #if it is true then we see normal distribution

filename_interactome <- "files/interactome.txt"
filename_seed_proteins <- "files/seed-proteins.txt"

filename_DIAMOND_results <- "Results/1_breast-neoplasms.txt"

disease_num <- strsplit(filename_DIAMOND_results,"/")[[1]][2]
disease_num <- as.numeric(strsplit(disease_num,"_")[[1]][1])
#################################
path <- "C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/SWIMmer/code_/project/TCGA/dataset/"#my swimmer result path
switch_genes <- read.table(paste(path,tag,"/switch/txtFile/switch.txt",sep = ""), header = F, sep = "\t", check.names = F)
switch_genes <- switch_genes$V1
switch_genes  <- sapply(strsplit(switch_genes,"\\|"), function(x) x[1])

tmp <- read.table(filename_DIAMOND_results, header = T, sep = "\t", check.names = F)
new_disease_genes <- tmp$`gene name`
new_disease_genes <- unique(new_disease_genes)

rm(tmp)

#################################  
input <- getInputData(filename_interactome,filename_seed_proteins)

conversion_table <- input$conversion_table
interactome <- input$interactome
seed_proteins <- input$seed_proteins
disease <- input$disease
disease <- disease[disease_num]

rm(input)

#################################
source <- as.character(interactome[,1])
target <- as.character(interactome[,2])
node <- unique(c(source,target))
node_symbol <- makeConversion(node,conversion_table)
node_symbol <- unique(node_symbol)

rm(source,target,interactome)

#################################
sp_list <- seed_proteins[disease,]
sp_list <- sp_list[sp_list != ""]
sp_list <- sp_list[(sp_list %in% node)]

sp_symbol <- makeConversion(sp_list,conversion_table)
sp_symbol <- unique(sp_symbol)
s0 <- length(sp_symbol)

rm(sp_list,seed_proteins,disease,conversion_table)

#################################
switch_genes <- switch_genes[(switch_genes %in% node_symbol)]

if (random){
  DEGs <- read.table(paste(path,tag,"/filtering/txtFile/stat_dataFiltered.txt",sep = ""), header = T, sep = "\t", check.names = F)
  DEGs  <- sapply(strsplit(DEGs[,1],"\\|"), function(x) x[1])
  DEGs <- DEGs[(DEGs %in% node_symbol)]
  
  switch_genes <- sample(DEGs, length(switch_genes))
   
}
#################################
disease_genes <- c(sp_symbol,new_disease_genes)

rm(new_disease_genes,sp_symbol,node,path)

#################################
N <- length(node_symbol)
M <- length(disease_genes)

k <- length(switch_genes)
n <- N-s0

count <- 1
L <- 0
pval <- NULL
while( L <= M ){
  
  L <- s0 + (count-1)
  intersezione <- intersect(switch_genes,disease_genes[count:L])
  x <- length(intersezione)
  
  pval[count] <- sum(dhyper(x:k,s0,n,k))
  
  count <- count + 1
  
}

iteration <- 1:(count-1)

#################################
plot(iteration,pval,type="l",lwd=3,log="y",col="turquoise4", xlab="Iteration", ylab="Enrichment p-value",family="sans",las=1,xaxt="n", yaxt="n")
eaxis(1)  # x-axis
eaxis(2,n.axp=1)  # y-axis
abline(h=0.05,lwd=2,lty=2)
abline(v=175,lwd=2,lty=2)

#################################

if(random){
  plot(iteration,pval,type="l",lwd=3,log="y",col="turquoise4", xlab="Iteration", ylab="Enrichment p-value",family="sans",las=1,xaxt="n", yaxt="n", ylim= c(1.56*10^-5,1))
  eaxis(1)  # x-axis
  eaxis(2,n.axp=1)  # y-axis
  abline(h=0.05,lwd=2,lty=2)
}
file.exists("C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/SWIMmer/code_/project/TCGA/brca/switch/txtFile/switch.txt")

