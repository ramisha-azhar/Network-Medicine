library(igraph)

options(stringsAsFactors = F)

setwd("C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/Network Medicine")

######################################
source("script/computeDegreeDistribution.R")
source("script/extractSubgraph.R")
source("script/extractLargestConnectedComponent.R")
source("script/selectRandomNodes.R")
source("script/performIteration.R")
source("script/computeStatistics.R")
######################################

disease <- "Glioblastoma" #insert disease name

disease_gene <- read.table("files/Glioblastoma_DiseaseGene.txt", header = T, sep = '\t', check.names = F, quote = "")

interactome <- read.table("files/Supplementary_data1.txt",header = T, sep = '\t', check.names = F, quote = "")


######################################

#we will create the network in the form of graph of the interactome
graph <- graph_from_data_frame(interactome, directed = F) #create undirected network

graph <- simplify(graph, remove.multiple = TRUE, remove.loops = TRUE,
                  edge.attr.comb = igraph_opt("edge.attr.comb")) #remove duplicated edges and self loop

node <- names(V(graph))

degree <- degree(graph, v = V(graph)) #compute the degree of each network node

rm(interactome) #15970 elements or nodes

######################################

degree_distribution <- computeDegreeDistribution(disease_gene$ID)  #134 observation
#extract the degree of each node,
#it is 134 observation of two variables
View(degree_distribution)


######################################

subgraph <- extractSubgraph(disease_gene) 
#This function extracts an induced sub graph from the global interactome corresponding to disease-associated genes
#The file Glioblastoma_subnetwork.txt is an edge list describing a glioblastoma-specific molecular sub-network.


subgraph_LCC <- extractLargestConnectedComponent(subgraph)
#this function extract the LCC from the disease gene subnetwork
#it tells how many nodes and edges we have of LCC
#NODES 309
#EDGES 1009
View(subgraph_LCC)

######################################

random_distribution <- performIteration(iter = 100) #IF POSSIBLE 1000
View(random_distribution)


par_size <- computeStatistics(random_distribution$num_node_LCC,subgraph_LCC$num_node,"Size of LCC")
View(par_size)


par_edge <- computeStatistics(random_distribution$num_edge_LCC,subgraph_LCC$num_edge,"Number of the interactions in LCC")

par_edge_tot <- computeStatistics(random_distribution$num_edge_tot,length(E(subgraph)),"Number of the total interactions")
######################################



