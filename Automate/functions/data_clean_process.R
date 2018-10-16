#' CMU MSP 36726 Project
#' Junyi Zhang, Rebecca Gu, Dejia Su
#' 
#' July, 2018
#' 
#' Version 3.0
#' 
#' This file contains the details of data cleaning process,
#' including calling other functions and write output files

print("Check the output folder")
if(!dir.exists("./Output Data/")){
  dir.create("./Output Data/")
}

print("Start to process")
source("./functions/alternation_functions.R")
# fix the trial number of raw data
data = trial_num_fix_raw(data)

print("Calculating alternation stats")
# calculate the alternation stats
alt_df = alt_stats(data, eye, version)
# convert factor to character
alt_df$Participant = as.character(alt_df$Participant)
alt_df$Trial = as.character(alt_df$Trial)

source("./functions/reformat_functions.R")
print("Processing AOI Blanks")
blanks = blanks %>%
         check_blanks() %>%
         proc_blanks()

fixation$AOI.Group = as.character(fixation$AOI.Group)
fixation$AOI.Group[fixation$AOI.Group == ""] = 'Background'

print("Processing AOI Fixations")
fix_image = filter(fixation, AOI.Group != "Text") %>%
  check_fix_image() %>%
  proc_fix_image()
fix_text = filter(fixation, AOI.Group == "Text") %>%
  check_fix_text() %>%
  proc_fix_text()

fix_extr = NA
fix_relevant = NA
if ('Extraneous' %in% unique(fixation$AOI.Group) && 
    'Relevant' %in% unique(fixation$AOI.Group)){
  fix_extr = filter(fixation, AOI.Group == 'Extraneous') %>%
    check_fix_extr() %>%
    proc_fix_extr()
  fix_relevant = filter(fixation, AOI.Group == 'Relevant') %>%
    check_fix_relevant() %>%
    proc_fix_relevant()
  fix_background = filter(fixation, AOI.Group == 'Background') %>%
    check_fix_background() %>%
    proc_fix_background()
}

print("Processing Fixations, saccades, and blink counts")
fsb_counts = fsb_counts %>%
  check_fsb_counts() %>%
  proc_fsb_counts()

print("Processing trial duration")
trial_dur = trial_dur %>%
  check_trial_dur() %>%
  proc_trial_dur()

print("Merging files")
# merge dataframes created above to reformatted data
ret = reformat(blanks, fix_image, fix_text, fsb_counts, trial_dur, fix_extr, fix_relevant)
ret$Participant = as.character(ret$Participant)
# merge the reformatted data with alternation stats
ret = left_join(ret, alt_df, by = c("Participant", "Trial"))
ret$Version = version
ret_no_zero = drop_zero(ret)
# write the output file
write.csv(ret_no_zero, paste0("./output\ data/",export_name, ".csv"), row.names = FALSE)
print("Finish processing long clean data")

source("./functions/condition_summary_functions.R")
print("Start to calculate clean data by condition")
# create the condition summary based on the reformatted data
con = condition_summary(ret, sep)
con1 = drop_zero(as.data.frame(con[[1]]))
con2 = drop_zero(as.data.frame(con[[2]]))
write.csv(con1, paste0("./output\ data/",export_name, "_",cond1,".csv"), row.names = FALSE)
write.csv(con2, paste0("./output\ data/",export_name, "_",cond2,".csv"), row.names = FALSE)
print("Finished!")
