#' CMU MSP 36726 Project
#' Junyi Zhang, Rebecca Gu, Dejia Su
#' 
#' April, 2018
#' 
#' Version 2.0
#' 
#' This file contains all the function needed for the cleaning purpose

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

print("Processing AOI Fixations")
fix_image = filter(fixation, AOI.Group == "Image") %>%
  check_fix_image() %>%
  proc_fix_image()
fix_text = filter(fixation, AOI.Group == "Text") %>%
  check_fix_text() %>%
  proc_fix_text()

print("Processing Fixations, saccades, and blink counts")
fsb_counts = fsb_counts %>%
  check_fsb_counts() %>%
  proc_fsb_counts()

print("Processing trial duration")
trial_dur = trial_dur %>%
  check_trial_dur() %>%
  proc_trial_dur()

print("Merging files")
# merge five dataframe to reformatted data
ret = reformat(blanks, fix_image, fix_text, fsb_counts, trial_dur)
ret$Participant = as.character(ret$Participant)
# merge the reformatted data with alternation stats
ret = left_join(ret, alt_df, by = c("Participant", "Trial"))
ret$Version = version
# write the output file
write.csv(ret, paste0(export_name, ".csv"), row.names = FALSE)
print("Finish processing long clean data")

source("./functions/condition_summary_functions.R")
print("Start to calculate clean data by condition")
# create the condition summary based on the reformatted data
condition_summary(ret, sep, 
                  paste0("version ", version, "_", cond1), 
                  paste0("version ", version, "_", cond2))
print("Finished!")
