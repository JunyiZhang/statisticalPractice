#' CMU MSP 36726 Project
#' Junyi Zhang
#' 
#' April, 2018
#' 
#' This script calculates all the alternation stats and write out to csv files

# load all the functions required from the function file
source("~/Desktop/36726 Statistical Practice/Project/code/Altertation/alternation_functions.R")

setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw Data/")
files = dir()
files = sort(files)

for (v in 1:6){
  setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw Data/")
  data = read.table(files[v], 
                    sep = "\t", header = TRUE, as.is = TRUE)
  data = trial_num_fix_raw(data)
  
  setwd("~/Desktop/36726 Statistical Practice/Project/data/clean data/")
  df = alt_stats(data, "right", v)
  write.csv(df, paste0("alternation_stats_", v, ".csv"), row.names = FALSE)
}


