#' CMU MSP 36726 Project
#' Junyi Zhang
#' 
#' April, 2018
#' 
#' This script is used to plot and save the alternation plots based 
#' on clustrering result or good vs bad readers

source("~/Desktop/36726 Statistical Practice/Project/code/Altertation/alternation_functions.R")

cluster_df = read.csv("~/Desktop/36726 Statistical Practice/Project/data/Cluster/cluster.csv", as.is = TRUE)
cluster_df = cluster_df[-1]

top_retell_cluster = read.csv("~/Desktop/36726 Statistical Practice/Project/data/Cluster/Retell/top_retller.csv",
                          as.is = TRUE)

bottom_retell_cluster = read.csv("~/Desktop/36726 Statistical Practice/Project/data/Cluster/Retell/bottom_retller.csv",
                              as.is = TRUE)

setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw Data/")
file_name = dir(".")
#file_name = file_name[-5]
# v1 = read.table(file_name[1], sep = "\t", header = TRUE, as.is = TRUE)
# v2 = read.table(file_name[2], sep = "\t", header = TRUE, as.is = TRUE)
# v3 = read.table(file_name[3], sep = "\t", header = TRUE, as.is = TRUE)
# v4 = read.table(file_name[4], sep = "\t", header = TRUE, as.is = TRUE)
v5 = read.table(file_name[5], sep = "\t", header = TRUE, as.is = TRUE)
# v6 = read.table(file_name[6], sep = "\t", header = TRUE, as.is = TRUE)
data = do.call(rbind, lapply(file_name, function(x) trial_num_fix_raw(read.table(x, sep = "\t", header = TRUE, as.is = TRUE))[,names(v5)]))

# plot based on the clustering result
setwd("~/Desktop/36726 Statistical Practice/Project/data/Cluster/By page/")
c_list = unique(cluster_df$Cluster)
for (c in c_list){ 
  cur_cluster = filter(cluster_df, Cluster == c)
  plot(alt_plot_cluster(data, "right", cur_cluster))
  ggsave(paste0(c,".png"), width = 16, height = ifelse(nrow(cur_cluster) < 20, 9, nrow(cur_cluster) * 0.15), limitsize = FALSE) 
}

# plot for all the good readers
setwd("~/Desktop/36726 Statistical Practice/Project/data/Cluster/Retell/")
c_list = unique(top_retell_cluster$Cluster)
for (c in c_list){ 
  cur_cluster = filter(top_retell_cluster, Cluster == c)
  plot(alt_plot_cluster(data, "right", cur_cluster, good = TRUE))
  ggsave(paste0("Top ", c,".png"), width = 16, height = ifelse(nrow(cur_cluster) < 20, 9, nrow(cur_cluster) * 0.3), limitsize = FALSE) 
}

# plot for all the bad readers
setwd("~/Desktop/36726 Statistical Practice/Project/data/Cluster/Retell/")
c_list = unique(bottom_retell_cluster$Cluster)
for (c in c_list){ 
  cur_cluster = filter(bottom_retell_cluster, Cluster == c)
  plot(alt_plot_cluster(data, "right", cur_cluster, good = FALSE))
  ggsave(paste0("Bottom ", c,".png"), width = 16, height = ifelse(nrow(cur_cluster) < 20, 9, nrow(cur_cluster) * 0.3), limitsize = FALSE) 
}
