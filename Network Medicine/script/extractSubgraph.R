extractSubgraph <- function(list){
  
  ID <- as.character(list$ID)
  symbol <- list$Symbol
  
  ind <- which(ID %in% node)
  ID_interactome <- ID[ind]
  symbol_interactome <- symbol[ind]
  
  df <- data.frame(ID = ID_interactome, symbol = symbol_interactome)
  rownames(df) <- ID_interactome
  
  subgraph <- induced_subgraph(graph,ID_interactome)

  df <- df[names(V(subgraph)),]
  
  # chiamo i vertex con i symbol invece che con gli ID
  subgraph <- set_vertex_attr(subgraph, "name", index = V(subgraph), df$symbol)
  
  plot(subgraph, 
       layout = layout_randomly,
       vertex.size = 10, 
       vertex.color = "red", 
       vertex.label = NA,
       vertex.label.color = "black", 
       vertex.label.cex = 0.6)
  
  write_graph(subgraph, paste0(disease,"_subnetwork.txt"), format = "ncol")
  
  return(subgraph)
  
}
