computeDegreeDistribution <- function(list){
  
  from <- which(node %in% list)
  d <- degree(graph, v = V(graph)[from])
  
  t <- table(d)
  
  degree_sorted <- as.numeric(names(t))
  freq <- as.numeric(t)
  
  df <- data.frame(degree = degree_sorted, frequency = freq)

  return(df)

}