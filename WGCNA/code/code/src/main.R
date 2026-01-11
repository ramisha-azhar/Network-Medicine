rm(list = ls())

options(stringsAsFactors = FALSE)

setwd("C:/Users/ramis/OneDrive/Desktop/BIOINFORMETICS 2/Network Medicine/WGCNA/code/code")

######################################
library(WGCNA)

source("src/script/getSource.R")
######################################
getSource()
input_parameter <- config() #there we will open the config file to change the parameters
input_file <- inputFiles()
output_file <- outputFiles()
######################################

dataInput()

networkConstruction()

relateModstoExt() #compute the relationship between module and trait

visualization()

exportNetwork()


