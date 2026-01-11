config <- function(){
  
  #################################
  project <- "TCGA" #change the project name 
  dataset <- "brca"
  
  path <- paste0("project/",project,"/dataset/",dataset)
  #################################
  # input files
  
  filename_data <- paste0(path,"/matrix/RNAseq_DEGs.txt")
  
  filename_traits <- paste0(path,"/matrix/Traits.txt")
  #################################
  # input parameters
  #parameters for the construction of the network
  
  abline_h <- 150
  
 #View(datTraits)
  
  
  corType <- "pearson"
  power <- 6
  networkType <- "unsigned"
  TOMType <- "unsigned"
  minModuleSize <- 50 #modules contain the number of genes greater than 30 can be 50
  #to know the best configuration we see the trait change the parameters for the best cancer data set 
  
  trait_name <- "Subtypes_num" #we have to select the trait of interest
  
  module <- "blue" 
  #################################
  
  input_parameter <- list(path = path,
                          project = project,
                          dataset = dataset,
                          filename_data = filename_data,
                          filename_traits = filename_traits,
                          abline_h = abline_h,
                          corType = corType,
                          power = power,
                          networkType = networkType,
                          TOMType = TOMType,
                          minModuleSize = minModuleSize,
                          trait_name = trait_name,
                          module = module)
  
  return(input_parameter)
  
}

