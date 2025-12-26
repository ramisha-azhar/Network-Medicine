extractLargestConnectedComponent <- function(graph){
  
  component <- components(graph)
  
  ind <- which(component$membership == which.max(component$csize))
  
  LCC <- induced_subgraph(graph , V(graph)[ind])
  
  v <- length(V(LCC))
  e <- length(E(LCC))
  
  df <- data.frame(num_node = v, num_edge = e)
  
  return(df)
  
}
