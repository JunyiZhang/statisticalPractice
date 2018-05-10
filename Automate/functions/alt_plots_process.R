#' CMU MSP 36726 Project
#' Junyi Zhang, Rebecca Gu, Dejia Su
#' 
#' April, 2018
#' 
#' Version 2.0
#' 
#' This file contains the details of creating the alternation plots,
#' including calling other functions and write output files
#' 

# source the necessary functions
source("./functions/alternation_functions.R")

print("Check the output folder")
# create all the necessary dir
version_dir = paste0("./Version ", version, "/")
by_trial_dir = paste0(version_dir,"Version ",version," Trials/")
by_par_dir = paste0(version_dir,"Version ",version," Participants/")
# create dir if necessary
if(!dir.exists(version_dir)){
  dir.create(version_dir)
}

# fix the trial number for raw data
data = trial_num_fix_raw(data)

# plot by participant
if (type == "a" | type == "c"){
  if(!dir.exists(by_par_dir)){
    dir.create(by_par_dir)
  }
  
  print("Creating plots contains all trials(pages) for one participant")
  p_list = unique(data$Participant)
  total = length(p_list)
  finished = 1
  for (p in p_list){
    print(alt_plot_participant(data, eye, p, version))
    ggsave(paste0(by_par_dir, "Participant ", p, ".png"), width = 16, height = 9)
    print(paste0(finished, "/", total, " Done"))
    finished = finished + 1
  }
}

if (type == "b" | type == "c"){
  if(!dir.exists(by_trial_dir)){
    dir.create(by_trial_dir)
  }
  
  print("Creating plots contains all participants for one trial(page)")
  total_trial = length(unique(data$Trial))
  for (trial in 1:total_trial){
    print(alt_plot_trial(data, eye, version, trial))
    ggsave(paste0(by_trial_dir, "Version ", version, " Trial ", trial, ".png"), width = 16, height = 9)
    print(paste0(trial, "/", total_trial, " Done"))
  }
}

print("Finished!")
