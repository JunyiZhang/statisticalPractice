#' CMU MSP 36726 Project
#' Junyi Zhang
#' 
#' Feb, 2018
#' 
#' Code below is uesed to draw the alternation plots for all the participants
#' in each trial of a version and the alternation plots for all the trials of
#' each participant

VERSION_NUM = 6
by_trial = FALSE
by_participant = FALSE
by_cluster = TRUE

for (v in 1:VERSION_NUM){
  # set wd
  setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw Data/") 
  # load all the functions required from the function file
  source("~/Desktop/36726 Statistical Practice/Project/code/Altertation/alternation_functions.R")
  
  # read the data for a specific version
  data = read.table(paste0("Version ", v, " - Raw Data_4-6-2018.txt"), 
                    sep = "\t", header = TRUE, as.is = TRUE)
  
  data = trial_num_fix_raw(data)
  
  if (by_trial == TRUE){
    # reset directory to the folder that stores alternation plots for all the trials 
    # of each participant
    setwd(paste0("~/Desktop/36726 Statistical Practice/Project/data/Alternation Plots/Version ", v, " Trial/"))
    # loop through all the trials
    # print out the plots and store all the plots as png
    for (trial in 1:length(unique(data$Trial))){
      print(alt_plot_trial(data, "right", v, trial)) 
      ggsave(paste0("Version ", v, " Trial ", trial, ".png"), width = 16, height = 9) 
    }
  }
  
  if (by_participant == TRUE){
    # reset the directory to the folder that stores alternation plots for all the participants
    # of each trial
    setwd(paste0("~/Desktop/36726 Statistical Practice/Project/data/Alternation Plots/Version ", v, " Participants/"))
    p_list = unique(data$Participant)
    # loop through all the participants
    # print out and store all the plots
    for (p in p_list){
      print(alt_plot_participant(data, "right", p, v))
      ggsave(paste0("Participant ", p, ".png"), width = 16, height = 9)
    }
  }
    
}
  

  
