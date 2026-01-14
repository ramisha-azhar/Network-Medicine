options(stringsAsFactors = F)

setwd("C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/DIAMond/code/code")

##########################
source("script/getInputData.R")
source("script/createAdjMatrix.R")
source("script/makeConversion.R")
source("script/createCandidateMatrix.R")
source("script/findCandidate.R")
source("script/findDiseaseGenes.R")
##########################
filename_interactome<- "files/interactome.txt"
filename_seed_proteins <- "files/seed-proteins.txt"

dirRes <- 'Results/' #create result folder
if( !file.exists(dirRes) ){
  dir.create(dirRes)
}

N_iter <- 500 #set the number of iteration

##########################
#getInputData()
input <- getInputData(filename_interactome,filename_seed_proteins)
names (input)
#[1] "conversion_table"
#[2] "interactome"     
#[3] "seed_proteins"   
#[4] "disease"

conversion_table <- input$conversion_table
interactome <- input$interactome
seed_proteins <- input$seed_proteins
disease <- input$disease

##########################
#createAdjMatrix()
network <- createAdjMatrix(interactome)
names(network)
adj <- network$adj
nodi <- network$nodi

#findDiseaseGenes()
disease <- disease[1] # only the first row of breast (comment this line to execute all the disease)
lapply(disease, function(x){
  
  new_disease_genes <- findDiseaseGenes(x,adj,nodi,seed_proteins,conversion_table,N_iter)
  
  num <- which(disease %in% x)
  
  write.table(new_disease_genes, paste(dirRes,paste(num,"_",x,".txt",sep=""), sep = ""), sep = "\t", 
              row.names = F, col.names = c("gene ID","gene name","p-value","K","Ks"), quote = F)
  
})



