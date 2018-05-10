#' CMU MSP 36726 Project
#' Junyi Zhang
#' 
#' April, 2018
#' 
#' This script calculates the condition summary for version 1 to 6

# version 1
setwd("~/Desktop/36726 Statistical Practice/Project/data/clean data/")
source("~/Desktop/36726 Statistical Practice/Project/code/Condition Summary/condition_summary_functions.R")

data = read.csv("clean_data_v1.csv")
con = condition_summary(data, 4)
write.csv(con[[1]], "Verson 1 Standard", row.names = FALSE)
write.csv(con[[2]], "Verson 1 Separated", row.names = FALSE)
stimulus_summary(data, "clean_stimulus_v1")

# version 2
data = read.csv("clean_data_v2.csv")
con = condition_summary(data, 8)
write.csv(con[[1]], "Verson 2 Separated", row.names = FALSE)
write.csv(con[[2]], "Verson 2 Standard", row.names = FALSE)
stimulus_summary(data, "clean_stimulus_v2")

# version 3
data = read.csv("clean_data_v3.csv")
con = condition_summary(data, 4)
write.csv(con[[1]], "Verson 3 Standard", row.names = FALSE)
write.csv(con[[2]], "Verson 3 Partial", row.names = FALSE)
stimulus_summary(data, "clean_stimulus_v3")

# version 4
data = read.csv("clean_data_v4.csv")
con = condition_summary(data, 4)
write.csv(con[[1]], "Verson 4 Partial", row.names = FALSE)
write.csv(con[[2]], "Verson 4 Standard", row.names = FALSE)
stimulus_summary(data, "clean_stimulus_v4")

# version 5
data = read.csv("clean_data_v5.csv")
con = condition_summary(data, 3)
write.csv(con[[1]], "Verson 5 Standard", row.names = FALSE)
write.csv(con[[2]], "Verson 5 Clean", row.names = FALSE)
stimulus_summary(data, "clean_stimulus_v5")

# version 6
data = read.csv("clean_data_v6.csv")
condition_summary(data, 3)
write.csv(con[[1]], "Verson 6 Clean", row.names = FALSE)
write.csv(con[[2]], "Verson 6 Standard", row.names = FALSE)
stimulus_summary(data, "clean_stimulus_v6")

