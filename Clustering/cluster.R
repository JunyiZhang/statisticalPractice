#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' This script performs the clustering based on condition


setwd("~/Desktop/36726 Statistical Practice/Project/data/clean data/")
library(dplyr)

# read all the data
v1 = read.csv("clean_stimulus_v1.csv")
v2 = read.csv("clean_stimulus_v2.csv")
v3 = read.csv("clean_stimulus_v3.csv")
v4 = read.csv("clean_stimulus_v4.csv")
v5 = read.csv("clean_stimulus_v5.csv")
v6 = read.csv("clean_stimulus_v6.csv")

# combine them into one
data_list = list(v1, v2, v3, v4, v5, v6)
data = do.call(rbind, data_list)
data$Avg_fix_pct = data$Avg_total_fix_dur / data$Avg_trial_dur
data[is.na(data)] = 0
data = data[-1]

# choose features and perform hierachel clustering
hc = hclust(dist(scale(select(data, -c(Participant, Condition, 
                                       Avg_blank_fix_count, Avg_image_fix_time_pct,
                                       Avg_total_alt))), 
            method = "euclidean"), method = "average")
plot(hc, cex = 0.4)

# cut the tree
hc_cluster = cutree(hc, 5)
table(hc_cluster)

data$cluster = hc_cluster
table(data$Condition, data$cluster)
table(data$Participant, data$cluster)

biplot(princomp(scale(data[4:ncol(data)])))
