#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' Reformat all the export data from version 1 to 6 
#' join the reformatted data with alternation stats

source("~/Desktop/36726 Statistical Practice/Project/code/Reformat/reformat_functions.R")

for (v in 1:6){
  # set the wd
  setwd(paste0("~/Desktop/36726 Statistical Practice/Project/data/export data/Version ", v, "/"))
  
  # get all the file names in the wd
  files = dir()
  
  blanks_name = NA
  fsb_name = NA
  trial_dur_name = NA
  fixation_name = NA
  
  # match the file name
  for (file in files){
    if (grepl("blank", tolower(file))) {
      blanks_name = file
    } else if (grepl("saccade", tolower(file))) {
      fsb_name = file
    } else if (grepl("duration", tolower(file))) {
      trial_dur_name = file
    } else {
      fixation_name = file
    }
  }
  
  if (any(sapply(c(blanks_name, fsb_name, trial_dur_name, fixation_name), is.na))) {
    stop("One file is missing!")
  }
  
  # check and process all the dataframes
  blanks = read.table(blanks_name, sep = "\t", header = TRUE) %>%
    check_blanks() %>%
    proc_blanks()
  fixation = read.table(fixation_name, sep = "\t", header = TRUE)
  fix_image = filter(fixation, AOI.Group == "Image") %>%
    check_fix_image() %>%
    proc_fix_image()
  fix_text = filter(fixation, AOI.Group == "Text") %>%
    check_fix_text() %>%
    proc_fix_text()
  fsb_counts = read.table(fsb_name,sep = "\t", header = TRUE) %>%
    check_fsb_counts() %>%
    proc_fsb_counts()
  trial_dur = read.table(trial_dur_name, sep = "\t", header = TRUE) %>%
    check_trial_dur() %>%
    proc_trial_dur()
  # join the table together
  ret = reformat(blanks, fix_image, fix_text, fsb_counts, trial_dur)
  ret$Participant = as.character(ret$Participant)
  # read the alternation stats
  setwd("~/Desktop/36726 Statistical Practice/Project/data/clean data/")
  alter_stats = read.csv(paste0("alternation_stats_", v, ".csv"), as.is = TRUE)
  # join the alternation stats with the reformatted data
  ret = left_join(ret, alter_stats, by = c("Participant", "Trial"))
  ret$Version = v
  write.csv(ret, paste0("clean_data_v", v, ".csv"), row.names = FALSE)
}


  
  



