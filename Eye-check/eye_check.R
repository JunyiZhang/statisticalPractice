#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' Investgate the mismatch of left and right eye
#' i.e. whether both of eyes focus the same thing 
#' or not.


if(!require("dplyr")){
  install.packages("dplyr")
  library("dplyr")
}

setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw Data/")
files = dir()
files = sort(files)

# initialize the dataframe
mismatch_df = data.frame(Participant = character(),
                         Version = integer(),
                         Mismatch = integer(),
                         Mismatch_rate = double(),
                         Tracking_ratio = double())

# Calulate the mismatch and mismatch rate in each version
v = 1
for (file in files) {
  data = read.table(file, sep = "\t", header = TRUE, as.is = TRUE)
  p_list = unique(data$Participant)
  for (p in p_list) {
    p_data = filter(data, Participant == p)
    mismatch = sum(p_data$AOI.Name.Left != p_data$AOI.Name.Right)
    mismatch_rate = round((mismatch / nrow(p_data)) * 100, 2)
    tracking_ratio = round(mean(p_data$Tracking.Ratio....), 2)
    mismatch_df = rbind(mismatch_df, data.frame(Participant = p,
                                                Version = v,
                                                Mismatch = mismatch,
                                                Mismatch_rate = mismatch_rate,
                                                Tracking_ratio = tracking_ratio))
  }
  v = v + 1
}

mismatch_df

# investgate the cor between mismatch rate and tracking ratio
plot(mismatch_df$Tracking_ratio, mismatch_df$Mismatch_rate, 
     col = mismatch_df$Version, xlab = "Tacking Ratio",
     ylab = "Mismatch Rate")
abline(v = 50)
legend("topleft", pch = 21,col = 1:8,
       legend = c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8"))
# pearson cor
cor(mismatch_df$Tracking_ratio, mismatch_df$Mismatch_rate)
# maximal cor
a = acepack::ace(mismatch_df$Mismatch_rate, mismatch_df$Tracking_ratio)
cor(a$tx, a$ty)
