performIteration <- function(iter){
  
  v_LCC <- NULL
  e_LCC <- NULL
  e_tot <- NULL

  for (i in 1:iter){
    
    random_node <- selectRandomNodes(degree_distribution)
    
    random_subgraph <- induced_subgraph(graph,random_node)
    
    random_LCC <- extractLargestConnectedComponent(random_subgraph)
    
    v_LCC <- c(v_LCC,random_LCC$num_node)
    e_LCC <- c(e_LCC,random_LCC$num_edge)
    
    e_tot <- c(e_tot,length(E(random_subgraph)))
    
  }
  
  df <- data.frame(num_node_LCC = v_LCC, num_edge_LCC = e_LCC, num_edge_tot = e_tot)
  
  return(df)
  
}