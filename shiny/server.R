# server for Reading & Attention Project EDA

library(shiny)
library(shinyjs)


# load in comprehension data
compre_data = read.csv("compre_abv.csv")
compres = split(compre_data, compre_data$version)
for(i in 1:6) {
  assign(paste0("compre_", i), compres[[i]])
}


# load in eye-tracking data
eye_v1_std = read.csv("Version 1 Standard.csv")[, c(2, 7, 9, 10, 12, 15, 23)]
eye_v1_spt = read.csv("Version 1 Separated.csv")[, c(2, 7, 9, 10, 12, 15, 23)]

eye_v2_std = read.csv("Version 2 Standard.csv")[, c(2, 7, 9, 10, 12, 15, 23)]
eye_v2_spt = read.csv("Version 2 Separated.csv")[, c(2, 7, 9, 10, 12, 15, 23)]

eye_v3_std = read.csv("Version 3 Standard.csv")[, c(2, 7, 9, 10, 12, 15, 23)]
eye_v3_ptl = read.csv("Version 3 Partial.csv")[, c(2, 7, 9, 10, 12, 15, 23)]

eye_v4_std = read.csv("Version 4 Standard.csv")[, c(2, 7, 9, 10, 12, 15, 23)]
eye_v4_ptl = read.csv("Version 4 Partial.csv")[, c(2, 7, 9, 10, 12, 15, 23)]

eye_v5_std = read.csv("Version 5 Standard.csv")[, c(2, 7, 9, 10, 12, 15, 23)]
eye_v5_cln = read.csv("Version 5 Clean.csv")[, c(2, 7, 9, 10, 12, 15, 23)]

eye_v6_std = read.csv("Version 6 Standard.csv")[, c(2, 7, 9, 10, 12, 15, 23)]
eye_v6_cln = read.csv("Version 6 Clean.csv")[, c(2, 7, 9, 10, 12, 15, 23)]


# generate data for eye-tracking whole dataset
avg_image_fix_count = c(eye_v1_std$Avg_image_fix_count, eye_v1_spt$Avg_image_fix_count, 
                        eye_v2_std$Avg_image_fix_count, eye_v2_spt$Avg_image_fix_count,
                        eye_v3_std$Avg_image_fix_count, eye_v3_ptl$Avg_image_fix_count,
                        eye_v4_std$Avg_image_fix_count, eye_v4_ptl$Avg_image_fix_count,
                        eye_v5_std$Avg_image_fix_count, eye_v5_cln$Avg_image_fix_count,
                        eye_v6_std$Avg_image_fix_count, eye_v6_cln$Avg_image_fix_count)

avg_image_fix_time_pct = c(eye_v1_std$Avg_image_fix_time_pct, eye_v1_spt$Avg_image_fix_time_pct, 
                           eye_v2_std$Avg_image_fix_time_pct, eye_v2_spt$Avg_image_fix_time_pct,
                           eye_v3_std$Avg_image_fix_time_pct, eye_v3_ptl$Avg_image_fix_time_pct,
                           eye_v4_std$Avg_image_fix_time_pct, eye_v4_ptl$Avg_image_fix_time_pct,
                           eye_v5_std$Avg_image_fix_time_pct, eye_v5_cln$Avg_image_fix_time_pct,
                           eye_v6_std$Avg_image_fix_time_pct, eye_v6_cln$Avg_image_fix_time_pct)

avg_text_fix_count = c(eye_v1_std$Avg_text_fix_count, eye_v1_spt$Avg_text_fix_count, 
                       eye_v2_std$Avg_text_fix_count, eye_v2_spt$Avg_text_fix_count,
                       eye_v3_std$Avg_text_fix_count, eye_v3_ptl$Avg_text_fix_count,
                       eye_v4_std$Avg_text_fix_count, eye_v4_ptl$Avg_text_fix_count,
                       eye_v5_std$Avg_text_fix_count, eye_v5_cln$Avg_text_fix_count,
                       eye_v6_std$Avg_text_fix_count, eye_v6_cln$Avg_text_fix_count)

avg_text_fix_time_pct = c(eye_v1_std$Avg_text_fix_time_pct, eye_v1_spt$Avg_text_fix_time_pct, 
                          eye_v2_std$Avg_text_fix_time_pct, eye_v2_spt$Avg_text_fix_time_pct,
                          eye_v3_std$Avg_text_fix_time_pct, eye_v3_ptl$Avg_text_fix_time_pct,
                          eye_v4_std$Avg_text_fix_time_pct, eye_v4_ptl$Avg_text_fix_time_pct,
                          eye_v5_std$Avg_text_fix_time_pct, eye_v5_cln$Avg_text_fix_time_pct,
                          eye_v6_std$Avg_text_fix_time_pct, eye_v6_cln$Avg_text_fix_time_pct)

avg_saccade_count = c(eye_v1_std$Avg_saccade_count, eye_v1_spt$Avg_saccade_count, 
                          eye_v2_std$Avg_saccade_count, eye_v2_spt$Avg_saccade_count,
                          eye_v3_std$Avg_saccade_count, eye_v3_ptl$Avg_saccade_count,
                          eye_v4_std$Avg_saccade_count, eye_v4_ptl$Avg_saccade_count,
                          eye_v5_std$Avg_saccade_count, eye_v5_cln$Avg_saccade_count,
                          eye_v6_std$Avg_saccade_count, eye_v6_cln$Avg_saccade_count)

avg_text_image_alt = c(eye_v1_std$Avg_Text_Image, eye_v1_spt$Avg_Text_Image, 
                      eye_v2_std$Avg_Text_Image, eye_v2_spt$Avg_Text_Image,
                      eye_v3_std$Avg_Text_Image, eye_v3_ptl$Avg_Text_Image,
                      eye_v4_std$Avg_Text_Image, eye_v4_ptl$Avg_Text_Image,
                      eye_v5_std$Avg_Text_Image, eye_v5_cln$Avg_Text_Image,
                      eye_v6_std$Avg_Text_Image, eye_v6_cln$Avg_Text_Image)


# get the maximum ylim 
# comprehension dataset - whole dataset 
compre_whole_max = max(max(table(compre_data$E1_5)), max(table(compre_data$E6_10)), 
                       max(table(compre_data$E_total)), 
                       max(table(compre_data$Q1_3)), max(table(compre_data$Q4_6)),
                       max(table(compre_data$Q_total)))

# comprehension dataset - one experiment - exp1 - Q
compre_exp1_Q_max = max(max(table(factor(compre_1$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_1$Q4_6, levels = c(0: 7)))),
                        max(table(factor(compre_2$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_2$Q4_6, levels = c(0: 7)))),
                        max(table(factor(c(compre_1$Q1_3, compre_2$Q4_6), levels = c(0: 7)))),
                        max(table(factor(c(compre_1$Q4_6, compre_2$Q1_3), levels = c(0: 7))))
                        )

# comprehension dataset - one experiment - exp1 - E
compre_exp1_E_max = max(max(table(factor(compre_1$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_1$E6_10, levels = c(0: 5)))),
                        max(table(factor(compre_2$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_2$E6_10, levels = c(0: 5)))),
                        max(table(factor(c(compre_1$E1_5, compre_2$E6_10), levels = c(0: 5)))),
                        max(table(factor(c(compre_1$E6_10, compre_2$E1_5), levels = c(0: 5))))
                        )

# comprehension dataset - one experiment - exp2 - Q
compre_exp2_Q_max = max(max(table(factor(compre_3$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_3$Q4_6, levels = c(0: 7)))),
                        max(table(factor(compre_4$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_4$Q4_6, levels = c(0: 7)))),
                        max(table(factor(c(compre_3$Q1_3, compre_4$Q4_6), levels = c(0: 7)))),
                        max(table(factor(c(compre_3$Q4_6, compre_4$Q1_3), levels = c(0: 7))))
                        )

# comprehension dataset - one experiment - exp2 - E
compre_exp2_E_max = max(max(table(factor(compre_3$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_3$E6_10, levels = c(0: 5)))),
                        max(table(factor(compre_4$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_4$E6_10, levels = c(0: 5)))),
                        max(table(factor(c(compre_3$E1_5, compre_4$E6_10), levels = c(0: 5)))),
                        max(table(factor(c(compre_3$E6_10, compre_4$E1_5), levels = c(0: 5))))
                        )

# comprehension dataset - one experiment - exp3 - Q
compre_exp3_Q_max = max(max(table(factor(compre_5$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_5$Q4_6, levels = c(0: 7)))),
                        max(table(factor(compre_6$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_6$Q4_6, levels = c(0: 7)))),
                        max(table(factor(c(compre_5$Q1_3, compre_6$Q4_6), levels = c(0: 7)))),
                        max(table(factor(c(compre_5$Q4_6, compre_6$Q1_3), levels = c(0: 7))))
                        )

# comprehension dataset - one experiment - exp3 - Q
compre_exp3_E_max = max(max(table(factor(compre_5$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_5$E6_10, levels = c(0: 5)))),
                        max(table(factor(compre_6$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_6$E6_10, levels = c(0: 5)))),
                        max(table(factor(c(compre_5$E1_5, compre_6$E6_10), levels = c(0: 5)))),
                        max(table(factor(c(compre_5$E6_10, compre_6$E1_5), levels = c(0: 5))))
                       )

# comprehension dataset - std first - Q
compre_std1_Q_max = max(max(table(factor(compre_1$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_3$Q1_3, levels = c(0: 7)))),
                        max(table(factor(compre_5$Q1_3, levels = c(0: 7))))
                        )

# comprehension dataset - std second - Q
compre_std2_Q_max = max(max(table(factor(compre_2$Q4_6, levels = c(0: 7)))),
                        max(table(factor(compre_4$Q4_6, levels = c(0: 7)))),
                        max(table(factor(compre_6$Q4_6, levels = c(0: 7))))
                       )

# comprehension dataset - std first - E
compre_std1_E_max = max(max(table(factor(compre_1$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_3$E1_5, levels = c(0: 5)))),
                        max(table(factor(compre_5$E1_5, levels = c(0: 5))))
                       )

# comprehension dataset - std second - E
compre_std2_E_max = max(max(table(factor(compre_2$E6_10, levels = c(0: 5)))),
                        max(table(factor(compre_4$E6_10, levels = c(0: 5)))),
                        max(table(factor(compre_6$E6_10, levels = c(0: 5))))
                        )









# function to generate summary for comprehension data whole dataset
non_graphical_analysis = function(input, data, var, version = FALSE) {
  validate(need(data, "no data available"))
  if(var == "compre") {
    x = input$compre_vars
  } 
  if(x == "id") {
    cat(nrow(data), "participants in total. Unique id for each participant")
  } else{
    if(x == "version") {
      if(version == FALSE) {
        cat("version ", data$version[1])
      } else {
        cat("6 versions in total")
      }
    } else {
      summary(data[, x])
    }
  }
}


# function to generate plots for comprehension data whole dataset
graphical_analysis = function(input, data, var, version = FALSE) {
  validate(need(data, "no data available"))
  if(var == "compre") {
    x = input$compre_vars
  } 
  if(x != "id") {
    if(x == "version") {
      if(version == TRUE) {
        barplot(table(data[, x]), main = x, xlab = x, ylim = c(0,40))
      }
    } else {
      if(x == "E1_5" || x == "E6_10") {
        barplot(table(factor(data[, x], 0:5)), main = x, xlab = x, ylab = "Frequency", ylim = c(0, compre_whole_max))
      }
      if(x == "Q1_3" || x == "Q4_6") {
        barplot(table(factor(data[, x], 0:7)), main = x, xlab = x, ylab = "Frequency", ylim = c(0, compre_whole_max))
      }
      if(x == "Q_total") {
        barplot(table(factor(data[, x], 0:14)), main = x, xlab = x, ylab = "Frequency", ylim = c(0, compre_whole_max))
      }
      if(x == "E_total") {
        barplot(table(factor(data[, x], 0:10)), main = x, xlab = x, ylab = "Frequency", ylim = c(0, compre_whole_max))
      }

    }
  }
}





# This is the server function, and it is the "return value" if
# this file is sourced.
function(input, output) {
  
  observe({
    if(input$dataset == "One Experiment") {
      shinyjs::show("experiment")
      shinyjs::hide("version")
    } else if(input$dataset == "Standard Condition") {
      shinyjs::hide("experiment")
      shinyjs::show("version")
    } else {
      shinyjs::hide("experiment")
      shinyjs::hide("version")
    }
  })

    
  # select variable to analyze in comprehension dataset
  output$compre_dropdown = renderUI(selectInput("compre_vars", "Select variables",
                                                choices=names(compre_data)))
  
  # select variable to analyze in eye-tracking dataset
  output$eye_dropdown = renderUI(selectInput("eye_vars", "Select variables",
                                                choices=names(eye_v1_std)[-1]))
  
  
  # print summary for whole dataset in comprehension dataset
  output$compre_summary = renderPrint({
    non_graphical_analysis(input, compre_data, "compre", TRUE)
  })
  
  
  # plots for whole dataset in comprehension dataset
  output$compre_plot = renderPlot({
    graphical_analysis(input, compre_data, "compre", TRUE)
  })
  
  
  # plots for exp 1 events
  output$plot_V1_E1_5 = renderPlot({
    V1_E1_5 = factor(compre_1$E1_5, levels = c(0: 5))
    barplot(table(V1_E1_5), xlab = "Events 1-5 Score", 
            main = "Version 1 Events 1-5 \n(Standard Condition)",
            ylim = c(0, compre_exp1_E_max))
  })
  output$plot_V1_E6_10 = renderPlot({
    V1_E6_10 = factor(compre_1$E6_10, levels = c(0: 5))
    barplot(table(V1_E6_10), xlab = "Events 6-10 Score", 
            main = "Version 1 Events 6-10 \n(Fully-Separated Condition)",
            ylim = c(0, compre_exp1_E_max))
  })
  output$plot_V2_E1_5 = renderPlot({
    V2_E1_5 = factor(compre_2$E1_5, levels = c(0: 5))
    barplot(table(V2_E1_5), xlab = "Events 1-5 Score", 
            main = "Version 2 Events 1-5 \n(Fully-Separated Condition)",
            ylim = c(0, compre_exp1_E_max))
  })
  output$plot_V2_E6_10 = renderPlot({
    V2_E6_10 = factor(compre_2$E6_10, levels = c(0: 5))
    barplot(table(V2_E6_10), xlab = "Events 6-10 Score", 
            main = "Version 2 Events 6-10 \n(Standard Condition)",
            ylim = c(0, compre_exp1_E_max))
  })
  output$plot_V12_E_std = renderPlot({
    V12_E_std = factor(c(compre_1$E1_5, compre_2$E6_10), levels = c(0: 5))
    barplot(table(V12_E_std), 
            xlab = "Events Score\n(Standard Condition in Version 1 & 2)", 
            main = "Version 1 & 2 Events \nUnder Standard Condition",
            ylim = c(0, compre_exp1_E_max))
  })
  output$plot_V12_E_sep = renderPlot({
    V12_E_sep = factor(c(compre_1$E6_10, compre_2$E1_5), levels = c(0: 5))
    barplot(table(V12_E_sep), 
            xlab = "Events Score\n(Fully-Separated Condition in Version 1 & 2)", 
            main = "Version 1 & 2 Events \nUnder Fully-Separated Condition",
            ylim = c(0, compre_exp1_E_max))
  })
  
  
  # plots for exp 1 questions
  output$plot_V1_Q1_3 = renderPlot({
    V1_Q1_3 = factor(compre_1$Q1_3, levels = c(0: 7))
    barplot(table(V1_Q1_3), xlab = "Questions 1-3 Score", 
            main = "Version 1 Questions 1-3 \n(Standard Condition)",
            ylim = c(0, compre_exp1_Q_max))
  })
  output$plot_V1_Q4_6 = renderPlot({
    V1_Q4_6 = factor(compre_1$Q4_6, levels = c(0: 7))
    barplot(table(V1_Q4_6), xlab = "Questions 4-6 Score", 
            main = "Version 1 Questions 4-6 \n(Fully-Separated Condition)",
            ylim = c(0, compre_exp1_Q_max))
  })
  output$plot_V2_Q1_3 = renderPlot({
    V2_Q1_3 = factor(compre_2$Q1_3, levels = c(0: 7))
    barplot(table(V2_Q1_3), xlab = "Questions 1-3 Score", 
            main = "Version 2 Questions 1-3 \n(Fully-Separated Condition)",
            ylim = c(0, compre_exp1_Q_max))
  })
  output$plot_V2_Q4_6 = renderPlot({
    V2_Q4_6 = factor(compre_2$Q4_6, levels = c(0: 7))
    barplot(table(V2_Q4_6), xlab = "Questions 4-6 Score", 
            main = "Version 2 Questions 4-6 \n(Standard Condition)",
            ylim = c(0, compre_exp1_Q_max))
  })
  output$plot_V12_Q_std = renderPlot({
    V12_Q_std = factor(c(compre_1$Q1_3, compre_2$Q4_6), levels = c(0: 7))
    barplot(table(V12_Q_std), 
            xlab = "Questions (Standard Condition in Version 1 & 2) Score", 
            main = "Version 1 & 2 Questions \nUnder Standard Condition",
            ylim = c(0, compre_exp1_Q_max))
  })
  output$plot_V12_Q_sep = renderPlot({
    V12_Q_sep = factor(c(compre_1$Q4_6, compre_2$Q1_3), levels = c(0: 7))
    barplot(table(V12_Q_sep), 
            xlab = "Questions (Standard Condition in Version 1 & 2) Score", 
            main = "Version 1 & 2 Questions \nUnder Fully-Separated Condition",
            ylim = c(0, compre_exp1_Q_max))
  })
  
  
  # plots for exp 2 events
  output$plot_V3_E1_5 = renderPlot({
    V3_E1_5 = factor(compre_3$E1_5, levels = c(0: 5))
    barplot(table(V3_E1_5), xlab = "Events 1-5 Score", 
            main = "Version 3 Events 1-5 \n(Standard Condition)",
            ylim = c(0, compre_exp2_E_max))
  })
  output$plot_V3_E6_10 = renderPlot({
    V3_E6_10 = factor(compre_3$E6_10, levels = c(0: 5))
    barplot(table(V3_E6_10), xlab = "Events 6-10 Score", 
            main = "Version 3 Events 6-10 \n(Partially-Separated Condition)",
            ylim = c(0, compre_exp2_E_max))
  })
  output$plot_V4_E1_5 = renderPlot({
    V4_E1_5 = factor(compre_4$E1_5, levels = c(0: 5))
    barplot(table(V4_E1_5), xlab = "Events 1-5 Score", 
            main = "Version 4 Events 1-5 \n(Partially-Separated Condition)",
            ylim = c(0, compre_exp2_E_max))
  })
  output$plot_V4_E6_10 = renderPlot({
    V4_E6_10 = factor(compre_4$E6_10, levels = c(0: 5))
    barplot(table(V4_E6_10), xlab = "Events 6-10 Score", 
            main = "Version 4 Events 6-10 \n(Standard Condition)",
            ylim = c(0, compre_exp2_E_max))
  })
  output$plot_V34_E_std = renderPlot({
    V34_E_std = factor(c(compre_3$E1_5, compre_4$E6_10), levels = c(0: 5))
    barplot(table(V34_E_std), 
            xlab = "Events Score\n(Standard Condition in Version 3 & 4)", 
            main = "Version 3 & 4 Events \nUnder Standard Condition",
            ylim = c(0, compre_exp2_E_max))
  })
  output$plot_V34_E_part = renderPlot({
    V34_E_part = factor(c(compre_3$E6_10, compre_4$E1_5), levels = c(0: 5))
    barplot(table(V34_E_part), 
            xlab = "Events Score\n(Partially-Separated Condition in Version 3 & 4)", 
            main = "Version 3 & 4 Events \nUnder Fully-Separated Condition",
            ylim = c(0, compre_exp2_E_max))
  })
  
  
  # plots for exp 2 questions
  output$plot_V3_Q1_3 = renderPlot({
    V3_Q1_3 = factor(compre_3$Q1_3, levels = c(0: 7))
    barplot(table(V3_Q1_3), xlab = "Questions 1-3 Score", 
            main = "Version 3 Questions 1-3 \n(Standard Condition)",
            ylim = c(0, compre_exp2_Q_max))
  })
  output$plot_V3_Q4_6 = renderPlot({
    V3_Q4_6 = factor(compre_3$Q4_6, levels = c(0: 7))
    barplot(table(V3_Q4_6), xlab = "Questions 4-6 Score", 
            main = "Version 3 Questions 4-6 \n(Partially-Separated Condition)",
            ylim = c(0, compre_exp2_Q_max))
  })
  output$plot_V4_Q1_3 = renderPlot({
    V4_Q1_3 = factor(compre_4$Q1_3, levels = c(0: 7))
    barplot(table(V4_Q1_3), xlab = "Questions 1-3 Score", 
            main = "Version 4 Questions 1-3 \n(Partially-Separated Condition)",
            ylim = c(0, compre_exp2_Q_max))
  })
  output$plot_V4_Q4_6 = renderPlot({
    V4_Q4_6 = factor(compre_4$Q4_6, levels = c(0: 7))
    barplot(table(V4_Q4_6), xlab = "Questions 4-6 Score", 
            main = "Version 4 Questions 4-6 \n(Standard Condition)",
            ylim = c(0, compre_exp2_Q_max))
  })
  output$plot_V34_Q_std = renderPlot({
    V34_Q_std = factor(c(compre_3$Q1_3, compre_4$Q4_6), levels = c(0: 7))
    barplot(table(V34_Q_std), 
            xlab = "Questions Score\n(Standard Condition in Version 3 & 4)", 
            main = "Version 3 & 4 Questions \nUnder Standard Condition",
            ylim = c(0, compre_exp2_Q_max))
  })
  output$plot_V34_Q_part = renderPlot({
    V34_Q_part = factor(c(compre_3$Q4_6, compre_4$Q1_3), levels = c(0: 7))
    barplot(table(V34_Q_part), 
            xlab = "Questions Score\n(Partially-Separated Condition in Version 3 & 4)", 
            main = "Version 3 & 4 Questions \nUnder Partially-Separated Condition",
            ylim = c(0, compre_exp2_Q_max))
  })
  
  
  # plots for exp 3 events
  output$plot_V5_E1_5 = renderPlot({
    V5_E1_5 = factor(compre_5$E1_5, levels = c(0: 5))
    barplot(table(V5_E1_5), xlab = "Events 1-5 Score", 
            main = "Version 5 Events 1-5 \n(Standard Condition)",
            ylim = c(0, compre_exp3_E_max))
  })
  output$plot_V5_E6_10 = renderPlot({
    V5_E6_10 = factor(compre_5$E6_10, levels = c(0: 5))
    barplot(table(V5_E6_10), xlab = "Events 6-10 Score", 
            main = "Version 5 Events 6-10 \n(Clean Condition)",
            ylim = c(0, compre_exp3_E_max))
  })
  output$plot_V6_E1_5 = renderPlot({
    V6_E1_5 = factor(compre_6$E1_5, levels = c(0: 5))
    barplot(table(V6_E1_5), xlab = "Events 1-5 Score", 
            main = "Version 6 Events 1-5 \n(Clean Condition)",
            ylim = c(0, compre_exp3_E_max))
  })
  output$plot_V6_E6_10 = renderPlot({
    V6_E6_10 = factor(compre_6$E6_10, levels = c(0: 5))
    barplot(table(V6_E6_10), xlab = "Events 6-10 Score", 
            main = "Version 6 Events 6-10 \n(Standard Condition)",
            ylim = c(0, compre_exp3_E_max))
  })
  output$plot_V56_E_std = renderPlot({
    V56_E_std = factor(c(compre_5$E1_5, compre_6$E6_10), levels = c(0: 5))
    barplot(table(V56_E_std), 
            xlab = "Events Score\n(Standard Condition in Version 5 & 6)", 
            main = "Version 5 & 6 Events \nUnder Standard Condition",
            ylim = c(0, compre_exp3_E_max))
  })
  output$plot_V56_E_cln = renderPlot({
    V56_E_cln = factor(c(compre_5$E6_10, compre_6$E1_5), levels = c(0: 5))
    barplot(table(V56_E_cln), 
            xlab = "Events Score\n(Clean Condition in Version 5 & 6)", 
            main = "Version 5 & 6 Events \nUnder Clean Condition",
            ylim = c(0, compre_exp3_E_max))
  })
  
  
  # plots for exp 3 questions
  output$plot_V5_Q1_3 = renderPlot({
    V5_Q1_3 = factor(compre_5$Q1_3, levels = c(0: 7))
    barplot(table(V5_Q1_3), xlab = "Questions 1-3 Score", 
            main = "Version 5 Questions 1-3 \n(Standard Condition)",
            ylim = c(0, compre_exp3_Q_max))
  })
  output$plot_V5_Q4_6 = renderPlot({
    V5_Q4_6 = factor(compre_5$Q4_6, levels = c(0: 7))
    barplot(table(V5_Q4_6), xlab = "Questions 4-6 Score", 
            main = "Version 5 Questions 4-6 \n(Clean Condition)",
            ylim = c(0, compre_exp3_Q_max))
  })
  output$plot_V6_Q1_3 = renderPlot({
    V6_Q1_3 = factor(compre_6$Q1_3, levels = c(0: 7))
    barplot(table(V6_Q1_3), xlab = "Questions 1-3 Score", 
            main = "Version 6 Questions 1-3 \n(Clean Condition)",
            ylim = c(0, compre_exp3_Q_max))
  })
  output$plot_V6_Q4_6 = renderPlot({
    V6_Q4_6 = factor(compre_6$Q4_6, levels = c(0: 7))
    barplot(table(V6_Q4_6), xlab = "Questions 4-6 Score", 
            main = "Version 6 Questions 4-6 \n(Standard Condition)",
            ylim = c(0, compre_exp3_Q_max))
  })
  output$plot_V56_Q_std = renderPlot({
    V56_Q_std = factor(c(compre_5$Q1_3, compre_6$Q4_6), levels = c(0: 7))
    barplot(table(V56_Q_std), 
            xlab = "Questions Score\n(Standard Condition in Version 5 & 6)", 
            main = "Version 5 & 6 Questions \nUnder Standard Condition",
            ylim = c(0, compre_exp3_Q_max))
  })
  output$plot_V56_Q_cln = renderPlot({
    V56_Q_cln = factor(c(compre_5$Q4_6, compre_6$Q1_3), levels = c(0: 7))
    barplot(table(V56_Q_cln), 
            xlab = "Questions Score\n(Clean Condition in Version 5 & 6)", 
            main = "Version 5 & 6 Questions \nUnder Clean Condition",
            ylim = c(0, compre_exp3_Q_max))
  })
  
  
  # plots for standard conditions Questions
  output$exp1_std1_Q = renderPlot({
    exp1_std1_Q = factor(compre_1$Q1_3, levels = c(0: 7))
    barplot(table(exp1_std1_Q), xlab = "Questions 1-3 Score", 
            main = "Version 1 Questions 1-3 \n(Standard Condition)",
            ylim = c(0, compre_std1_Q_max))
  })
  
  output$exp2_std1_Q = renderPlot({
    exp2_std1_Q = factor(compre_3$Q1_3, levels = c(0: 7))
    barplot(table(exp2_std1_Q), xlab = "Questions 1-3 Score", 
            main = "Version 3 Questions 1-3 \n(Standard Condition)",
            ylim = c(0, compre_std1_Q_max))
  })
  
  output$exp3_std1_Q = renderPlot({
    exp3_std1_Q = factor(compre_5$Q1_3, levels = c(0: 7))
    barplot(table(exp3_std1_Q), xlab = "Questions 1-3 Score", 
            main = "Version 5 Questions 1-3 \n(Standard Condition)",
            ylim = c(0, compre_std1_Q_max))
  })
  
  output$exp1_std2_Q = renderPlot({
    exp1_std2_Q = factor(compre_2$Q4_6, levels = c(0: 7))
    barplot(table(exp1_std2_Q), xlab = "Questions 4-6 Score", 
            main = "Version 2 Questions 4-6 \n(Standard Condition)",
            ylim = c(0, compre_std2_Q_max))
  })
  
  output$exp2_std2_Q = renderPlot({
    exp2_std2_Q = factor(compre_4$Q4_6, levels = c(0: 7))
    barplot(table(exp2_std2_Q), xlab = "Questions 4-6 Score", 
            main = "Version 4 Questions 4-6 \n(Standard Condition)",
            ylim = c(0, compre_std2_Q_max))
  })
  
  output$exp3_std2_Q = renderPlot({
    exp3_std2_Q = factor(compre_6$Q4_6, levels = c(0: 7))
    barplot(table(exp3_std2_Q), xlab = "Questions 4-6 Score", 
            main = "Version 6 Questions 4-6 \n(Standard Condition)",
            ylim = c(0, compre_std2_Q_max))
  })
  
  
  # plots for standard conditions Events
  output$exp1_std1_E = renderPlot({
    exp1_std1_E = factor(compre_1$E1_5, levels = c(0: 5))
    barplot(table(exp1_std1_E), xlab = "Events 1-5 Score", 
            main = "Version 1 Events 1-5 \n(Standard Condition)",
            ylim = c(0, compre_std1_E_max))
  })
  
  output$exp2_std1_E = renderPlot({
    exp2_std1_E = factor(compre_3$E1_5, levels = c(0: 5))
    barplot(table(exp2_std1_E), xlab = "Events 1-5 Score", 
            main = "Version 3 Events 1-5 \n(Standard Condition)",
            ylim = c(0, compre_std1_E_max))
  })
  
  output$exp3_std1_E = renderPlot({
    exp3_std1_E = factor(compre_5$E1_5, levels = c(0: 5))
    barplot(table(exp3_std1_E), xlab = "Events 1-5 Score", 
            main = "Version 5 Events 1-5 \n(Standard Condition)",
            ylim = c(0, compre_std1_E_max))
  })
  
  output$exp1_std2_E = renderPlot({
    exp1_std2_E = factor(compre_2$E6_10, levels = c(0: 5))
    barplot(table(exp1_std2_E), xlab = "Events 6-10 Score", 
            main = "Version 2 Events 6-10 \n(Standard Condition)",
            ylim = c(0, compre_std2_E_max))
  })
  
  output$exp2_std2_E = renderPlot({
    exp2_std2_E = factor(compre_4$E6_10, levels = c(0: 5))
    barplot(table(exp2_std2_E), xlab = "Events 6-10 Score", 
            main = "Version 4 Events 6-10 \n(Standard Condition)",
            ylim = c(0, compre_std2_E_max))
  })
  
  output$exp3_std2_E = renderPlot({
    exp3_std2_E = factor(compre_6$E6_10, levels = c(0: 5))
    barplot(table(exp3_std2_E), xlab = "Events 6-10 Score", 
            main = "Version 6 Events 6-10 \n(Standard Condition)",
            ylim = c(0, compre_std2_E_max))
  })

  
  
  ################## eye tracking data ######################
  
  # plots for eye-tracking whole data set
  output$avg_img_fix_ct_plot = renderPlot({
    hist(avg_image_fix_count, breaks = 20, xlim = c(0, 150), ylim = c(0, 90),
         main = "Average Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$avg_img_fix_pct_plot = renderPlot({
    hist(avg_image_fix_time_pct, breaks = seq(0, 100, by = 3), xlim = c(0, 100), ylim = c(0, 90),
         main = "Average Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$avg_txt_fix_ct_plot = renderPlot({
    hist(avg_text_fix_count, breaks = 40, xlim = c(0, 150), ylim = c(0, 90),
         main = "Average Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$avg_txt_fix_pct_plot = renderPlot({
    hist(avg_text_fix_time_pct, breaks = seq(0, 100, by = 3), xlim = c(0, 100), ylim = c(0, 90),
         main = "Average Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$avg_saccade_ct_plot = renderPlot({
    hist(avg_saccade_count, breaks = 50, xlim = c(0, 150), ylim = c(0, 90),
         main = "Average Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$avg_text_img_alt_plot = renderPlot({
    hist(avg_text_image_alt, breaks = seq(0, 100, by = 3), xlim = c(0, 100), ylim = c(0, 90),
         main = "Average Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # summary for eye-tracking whole data set
  output$avg_img_fix_ct_sum = renderPrint({
    summary(avg_image_fix_count)
  })
  
  output$avg_img_fix_pct_sum = renderPrint({
    summary(avg_image_fix_time_pct)
  })
  
  output$avg_txt_fix_ct_sum = renderPrint({
    summary(avg_text_fix_count)
  })
  
  output$avg_txt_fix_pct_sum = renderPrint({
    summary(avg_text_fix_time_pct)
  })
  
  output$avg_saccade_ct_sum = renderPrint({
    summary(avg_saccade_count)
  })
  
  output$avg_text_img_alt_sum = renderPrint({
    summary(avg_text_image_alt)
  })
  
  
  # v1_std
  output$v1_std_img_ct = renderPlot({
    hist(eye_v1_std$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 1 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v1_std_img_pct = renderPlot({
    hist(eye_v1_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 20),
         main = "Version 1 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v1_std_txt_ct = renderPlot({
    hist(eye_v1_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 14),
         main = "Version 1 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v1_std_txt_pct = renderPlot({
    hist(eye_v1_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 10),
         main = "Version 1 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v1_std_saccade_ct = renderPlot({
    hist(eye_v1_std$Avg_saccade_count, breaks = seq(0, 150, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v1_std_txt_img = renderPlot({
    hist(eye_v1_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 1 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v1_std for standard condition button b/c no duplicate name allowed in shiny
  output$v1_std_img_ct_s = renderPlot({
    hist(eye_v1_std$Avg_image_fix_count, breaks = seq(0, 150, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v1_std_img_pct_s = renderPlot({
    hist(eye_v1_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v1_std_txt_ct_s = renderPlot({
    hist(eye_v1_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v1_std_txt_pct_s = renderPlot({
    hist(eye_v1_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v1_std_saccade_ct_s = renderPlot({
    hist(eye_v1_std$Avg_saccade_count, breaks = seq(0, 210, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v1_std_txt_img_s = renderPlot({
    hist(eye_v1_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 1 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v1_spt
  output$v1_spt_img_ct = renderPlot({
    hist(eye_v1_spt$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 1 Fully-Separated Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v1_spt_img_pct = renderPlot({
    hist(eye_v1_spt$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 20),
         main = "Version 1 Fully-Separated Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v1_spt_txt_ct = renderPlot({
    hist(eye_v1_spt$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 14),
         main = "Version 1 Fully-Separated Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v1_spt_txt_pct = renderPlot({
    hist(eye_v1_spt$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 10),
         main = "Version 1 Fully-Separated Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v1_spt_saccade_ct = renderPlot({
    hist(eye_v1_spt$Avg_saccade_count, breaks = seq(0, 150, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 1 Fully_Separated Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v1_spt_txt_img = renderPlot({
    hist(eye_v1_spt$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 1 Fully_Separated Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  
  # v2_std
  output$v2_std_img_ct = renderPlot({
    hist(eye_v2_std$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 2 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v2_std_img_pct = renderPlot({
    hist(eye_v2_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 20),
         main = "Version 2 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v2_std_txt_ct = renderPlot({
    hist(eye_v2_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 14),
         main = "Version 2 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v2_std_txt_pct = renderPlot({
    hist(eye_v2_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 10),
         main = "Version 2 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v2_std_saccade_ct = renderPlot({
    hist(eye_v2_std$Avg_saccade_count, breaks = seq(0, 170, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v2_std_txt_img = renderPlot({
    hist(eye_v2_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 2 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v2_std_s
  output$v2_std_img_ct_s = renderPlot({
    hist(eye_v2_std$Avg_image_fix_count, breaks = seq(0, 150, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v2_std_img_pct_s = renderPlot({
    hist(eye_v2_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v2_std_txt_ct_s = renderPlot({
    hist(eye_v2_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v2_std_txt_pct_s = renderPlot({
    hist(eye_v2_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v2_std_saccade_ct_s = renderPlot({
    hist(eye_v2_std$Avg_saccade_count, breaks = seq(0, 210, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v2_std_txt_img_s = renderPlot({
    hist(eye_v2_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 2 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v2_spt
  output$v2_spt_img_ct = renderPlot({
    hist(eye_v2_spt$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 2 Fully-Separated Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v2_spt_img_pct = renderPlot({
    hist(eye_v2_spt$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 20),
         main = "Version 2 Fully-Separated Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v2_spt_txt_ct = renderPlot({
    hist(eye_v2_spt$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 14),
         main = "Version 2 Fully-Separated Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v2_spt_txt_pct = renderPlot({
    hist(eye_v2_spt$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 10),
         main = "Version 2 Fully-Separated Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v2_spt_saccade_ct = renderPlot({
    hist(eye_v2_spt$Avg_saccade_count, breaks = seq(0, 150, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 2 Fully-Separated Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v2_spt_txt_img = renderPlot({
    hist(eye_v2_spt$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 2 Fully-Separated Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })

  
  # v3_std
  output$v3_std_img_ct = renderPlot({
    hist(eye_v3_std$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 3 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v3_std_img_pct = renderPlot({
    hist(eye_v3_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 3 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v3_std_txt_ct = renderPlot({
    hist(eye_v3_std$Avg_text_fix_count, breaks = seq(0, 120, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v3_std_txt_pct = renderPlot({
    hist(eye_v3_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v3_std_saccade_ct = renderPlot({
    hist(eye_v3_std$Avg_saccade_count, breaks = seq(0, 230, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v3_std_txt_img = renderPlot({
    hist(eye_v3_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 3 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v3_std_s
  output$v3_std_img_ct_s = renderPlot({
    hist(eye_v3_std$Avg_image_fix_count, breaks = seq(0, 150, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v3_std_img_pct_s = renderPlot({
    hist(eye_v3_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v3_std_txt_ct_s = renderPlot({
    hist(eye_v3_std$Avg_text_fix_count, breaks = 10, xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v3_std_txt_pct_s = renderPlot({
    hist(eye_v3_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v3_std_saccade_ct_s = renderPlot({
    hist(eye_v3_std$Avg_saccade_count, breaks = 20, xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v3_std_txt_img_s = renderPlot({
    hist(eye_v3_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v3_ptl
  output$v3_ptl_img_ct = renderPlot({
    hist(eye_v3_ptl$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 3 Partially-Separated Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v3_ptl_img_pct = renderPlot({
    hist(eye_v3_ptl$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 3 Partially-Separated Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v3_ptl_txt_ct = renderPlot({
    hist(eye_v3_ptl$Avg_text_fix_count, breaks = seq(0, 110, by = 10), xlim = c(0, 120), ylim = c(0, 15),
         main = "Version 3 Partially-Separated Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v3_ptl_txt_pct = renderPlot({
    hist(eye_v3_ptl$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Partially-Separated Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v3_ptl_saccade_ct = renderPlot({
    hist(eye_v3_ptl$Avg_saccade_count, breaks = seq(0, 250, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 3 Partially-Separated Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v3_ptl_txt_img = renderPlot({
    hist(eye_v3_ptl$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 3 Partially-Separated Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v4_std
  output$v4_std_img_ct = renderPlot({
    hist(eye_v4_std$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 4 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v4_std_img_pct = renderPlot({
    hist(eye_v4_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 4 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v4_std_txt_ct = renderPlot({
    hist(eye_v4_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v4_std_txt_pct = renderPlot({
    hist(eye_v4_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v4_std_saccade_ct = renderPlot({
    hist(eye_v4_std$Avg_saccade_count, breaks = seq(0, 110, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v4_std_txt_img = renderPlot({
    hist(eye_v4_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 4 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v4_std_s
  output$v4_std_img_ct_s = renderPlot({
    hist(eye_v4_std$Avg_image_fix_count, breaks = seq(0, 150, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v4_std_img_pct_s = renderPlot({
    hist(eye_v4_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v4_std_txt_ct_s = renderPlot({
    hist(eye_v4_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v4_std_txt_pct_s = renderPlot({
    hist(eye_v4_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v4_std_saccade_ct_s = renderPlot({
    hist(eye_v4_std$Avg_saccade_count, breaks = seq(0, 210, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v4_std_txt_img_s = renderPlot({
    hist(eye_v4_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  
  # v4_ptl
  output$v4_ptl_img_ct = renderPlot({
    hist(eye_v4_ptl$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 4 Partially-Separated Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v4_ptl_img_pct = renderPlot({
    hist(eye_v4_ptl$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 4 Partially-Separated Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v4_ptl_txt_ct = renderPlot({
    hist(eye_v4_ptl$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 4 Partially-Separated Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v4_ptl_txt_pct = renderPlot({
    hist(eye_v4_ptl$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Partially-Separated Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v4_ptl_saccade_ct = renderPlot({
    hist(eye_v4_ptl$Avg_saccade_count, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 4 Partially-Separated Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v4_ptl_txt_img = renderPlot({
    hist(eye_v4_ptl$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 4 Partially-Separated Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  
  # v5_std
  output$v5_std_img_ct = renderPlot({
    hist(eye_v5_std$Avg_image_fix_count, breaks = seq(0, 130, by = 10), xlim = c(0, 100), ylim = c(0, 16),
         main = "Version 5 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v5_std_img_pct = renderPlot({
    hist(eye_v5_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 5 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v5_std_txt_ct = renderPlot({
    hist(eye_v5_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 5 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v5_std_txt_pct = renderPlot({
    hist(eye_v5_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 8),
         main = "Version 5 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v5_std_saccade_ct = renderPlot({
    hist(eye_v5_std$Avg_saccade_count, breaks = seq(0, 210, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v5_std_txt_img = renderPlot({
    hist(eye_v5_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 5 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v5_std_s
  output$v5_std_img_ct_s = renderPlot({
    hist(eye_v5_std$Avg_image_fix_count, breaks = seq(0, 150, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v5_std_img_pct_s = renderPlot({
    hist(eye_v5_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v5_std_txt_ct_s = renderPlot({
    hist(eye_v5_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v5_std_txt_pct_s = renderPlot({
    hist(eye_v5_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v5_std_saccade_ct_s = renderPlot({
    hist(eye_v5_std$Avg_saccade_count, breaks = seq(0, 210, by = 15), xlim = c(0,150), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v5_std_txt_img_s = renderPlot({
    hist(eye_v5_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 5 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v5_cln
  output$v5_cln_img_ct = renderPlot({
    hist(eye_v5_cln$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 16),
         main = "Version 5 Clean Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v5_cln_img_pct = renderPlot({
    hist(eye_v5_cln$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 5 Clean Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v5_cln_txt_ct = renderPlot({
    hist(eye_v5_cln$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 5 Clean Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v5_cln_txt_pct = renderPlot({
    hist(eye_v5_cln$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 8),
         main = "Version 5 Clean Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })

  output$v5_cln_saccade_ct = renderPlot({
    hist(eye_v5_cln$Avg_saccade_count, breaks = seq(0, 150, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 5 Clean Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v5_cln_txt_img = renderPlot({
    hist(eye_v5_cln$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 5 Clean Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v6_std
  output$v6_std_img_ct = renderPlot({
    hist(eye_v6_std$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 16),
         main = "Version 6 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v6_std_img_pct = renderPlot({
    hist(eye_v6_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 6 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v6_std_txt_ct = renderPlot({
    hist(eye_v6_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 6 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v6_std_txt_pct = renderPlot({
    hist(eye_v6_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 8),
         main = "Version 6 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v6_std_saccade_ct = renderPlot({
    hist(eye_v6_std$Avg_saccade_count, breaks = seq(0, 150, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v6_std_txt_img = renderPlot({
    hist(eye_v6_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 6 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v6_std_s
  output$v6_std_img_ct_s = renderPlot({
    hist(eye_v6_std$Avg_image_fix_count, breaks = seq(0, 150, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v6_std_img_pct_s = renderPlot({
    hist(eye_v6_std$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v6_std_txt_ct_s = renderPlot({
    hist(eye_v6_std$Avg_text_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v6_std_txt_pct_s = renderPlot({
    hist(eye_v6_std$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v6_std_saccade_ct_s = renderPlot({
    hist(eye_v6_std$Avg_saccade_count, breaks = seq(0, 210, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v6_std_txt_img_s = renderPlot({
    hist(eye_v6_std$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 6 Standard Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v6_cln
  output$v6_cln_img_ct = renderPlot({
    hist(eye_v6_cln$Avg_image_fix_count, breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 16),
         main = "Version 6 Clean Condition \nAverage Image Fix Count", xlab = "Average Image Fix Count")
  })
  
  output$v6_cln_img_pct = renderPlot({
    hist(eye_v6_cln$Avg_image_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 25),
         main = "Version 6 Clean Condition \nAverage Image Fix Time Percent", xlab = "Average Image Fix Time Percent")
  })
  
  output$v6_cln_txt_ct = renderPlot({
    hist(eye_v6_cln$Avg_text_fix_count, breaks = seq(0, 180, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 6 Clean Condition \nAverage Text Fix Count", xlab = "Average Text Fix Count")
  })
  
  output$v6_cln_txt_pct = renderPlot({
    hist(eye_v6_cln$Avg_text_fix_time_pct, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 8),
         main = "Version 6 Clean Condition \nAverage Text Fix Time Percent", xlab = "Average Text Fix Time Percent")
  })
  
  output$v6_cln_saccade_ct = renderPlot({
    hist(eye_v6_cln$Avg_saccade_count, breaks = seq(0, 200, by = 10), xlim = c(0,100), ylim = c(0, 15),
         main = "Version 6 Clean Condition \nAverage Saccade Count", xlab = "Average Saccade Count")
  })
  
  output$v6_cln_txt_img = renderPlot({
    hist(eye_v6_cln$Avg_Text_Image, breaks = seq(0, 100, by = 10), xlim = c(0,100), ylim = c(0, 35),
         main = "Version 6 Clean Condition \nAverage Text to Image Alternation", xlab = "Average Text to Image Alternation")
  })
  
  
  # v1_2 combine v1 and v2 by condition
  output$v1_2_std_img_ct = renderPlot({
    hist(c(eye_v1_std$Avg_image_fix_count, eye_v2_std$Avg_image_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 1 & 2 \nUnder Standard Condition", xlab = "Average Image Fix Count")
  })
  
  output$v1_2_spt_img_ct = renderPlot({
    hist(c(eye_v1_spt$Avg_image_fix_count, eye_v2_spt$Avg_image_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 1 & 2 \nUnder Fully-Separated Condition", xlab = "Average Image Fix Count")
  })
  
  output$v1_2_std_img_pct = renderPlot({
    hist(c(eye_v1_std$Avg_image_fix_time_pct, eye_v2_std$Avg_image_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 1 & 2 \nUnder Standard Condition", xlab = "Average Image Fix Time Percent")
  })
  
  output$v1_2_spt_img_pct = renderPlot({
    hist(c(eye_v1_spt$Avg_image_fix_time_pct, eye_v2_spt$Avg_image_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 20),
         main = "Version 1 & 2 \nUnder Fully-Separated Condition", xlab = "Average Image Fix Time Percent")
  })
  
  output$v1_2_std_txt_ct = renderPlot({
    hist(c(eye_v1_std$Avg_text_fix_count, eye_v2_std$Avg_text_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 14),
         main = "Version 1 & 2 \nUnder Standard Condition", xlab = "Average Text Fix Count")
  })
  
  output$v1_2_spt_txt_ct = renderPlot({
    hist(c(eye_v1_spt$Avg_text_fix_count, eye_v2_spt$Avg_text_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 14),
         main = "Version 1 & 2 \nUnder Fully-Separated Condition", xlab = "Average Text Fix Count")
  })
  
  output$v1_2_std_txt_pct = renderPlot({
    hist(c(eye_v1_std$Avg_text_fix_time_pct, eye_v2_std$Avg_text_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 1 & 2 \nUnder Standard Condition", xlab = "Average Text Fix Time Percent")
  })
  
  output$v1_2_spt_txt_pct = renderPlot({
    hist(c(eye_v1_spt$Avg_text_fix_time_pct, eye_v2_spt$Avg_text_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 1 & 2 \nUnder Fully-Separated Condition", xlab = "Average Text Fix Time Percent")
  })
  
  output$v1_2_std_saccade_ct = renderPlot({
    hist(c(eye_v1_std$Avg_saccade_count, eye_v2_std$Avg_saccade_count), breaks = seq(0, 170, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 1 & 2 \nUnder Standard Condition", xlab = "Average Saccade Count")
  })
  
  output$v1_2_spt_saccade_ct = renderPlot({
    hist(c(eye_v1_spt$Avg_saccade_count, eye_v2_spt$Avg_saccade_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 1 & 2 \nUnder Fully-Separated Condition", xlab = "Average Saccade Count")
  })
  
  output$v1_2_std_txt_img = renderPlot({
    hist(c(eye_v1_std$Avg_Text_Image, eye_v2_std$Avg_Text_Image), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 35),
         main = "Version 1 & 2 \nUnder Standard Condition", xlab = "Average Text to Image Alternation")
  })
  
  output$v1_2_spt_txt_img = renderPlot({
    hist(c(eye_v1_spt$Avg_Text_Image, eye_v2_spt$Avg_Text_Image), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 35),
         main = "Version 1 & 2 \nUnder Fully-Separated Condition", xlab = "Average Text to Image Alternation")
  })
  
  
  # v3_4 combine v3 and v4 by condition
  output$v3_4_std_img_ct = renderPlot({
    hist(c(eye_v3_std$Avg_image_fix_count, eye_v4_std$Avg_image_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 3 & 4 \nUnder Standard Condition", xlab = "Average Image Fix Count")
  })
  
  output$v3_4_ptl_img_ct = renderPlot({
    hist(c(eye_v3_ptl$Avg_image_fix_count, eye_v4_ptl$Avg_image_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 3 & 4 \nUnder Partially-Separated Condition", xlab = "Average Image Fix Count")
  })
  
  output$v3_4_std_img_pct = renderPlot({
    hist(c(eye_v3_std$Avg_image_fix_time_pct, eye_v4_std$Avg_image_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 3 & 4 \nUnder Standard Condition", xlab = "Average Image Fix Time Percent")
  })
  
  output$v3_4_ptl_img_pct = renderPlot({
    hist(c(eye_v3_ptl$Avg_image_fix_time_pct, eye_v4_ptl$Avg_image_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 3 & 4 \nUnder Partially-Separated Condition", xlab = "Average Image Fix Time Percent")
  })
  
  output$v3_4_std_txt_ct = renderPlot({
    hist(c(eye_v3_std$Avg_text_fix_count, eye_v4_std$Avg_text_fix_count), breaks = seq(0, 120, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 & 4 \nUnder Standard Condition", xlab = "Average Text Fix Count")
  })
  
  output$v3_4_ptl_txt_ct = renderPlot({
    hist(c(eye_v3_ptl$Avg_text_fix_count, eye_v4_ptl$Avg_text_fix_count), breaks = seq(0, 120, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 & 4 \nUnder Partially-Separated Condition", xlab = "Average Text Fix Count")
  })
  
  output$v3_4_std_txt_pct = renderPlot({
    hist(c(eye_v3_std$Avg_text_fix_time_pct, eye_v4_std$Avg_text_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 & 4 \nUnder Standard Condition", xlab = "Average Text Fix Time Percent")
  })
  
  output$v3_4_ptl_txt_pct = renderPlot({
    hist(c(eye_v3_ptl$Avg_text_fix_time_pct, eye_v4_ptl$Avg_text_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 & 4 \nUnder Partially-Separated Condition", xlab = "Average Text Fix Time Percent")
  })
  
  output$v3_4_std_saccade_ct = renderPlot({
    hist(c(eye_v3_std$Avg_saccade_count, eye_v4_std$Avg_saccade_count), breaks = seq(0, 250, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 & 4 \nUnder Standard Condition", xlab = "Average Saccade Count")
  })
  
  output$v3_4_ptl_saccade_ct = renderPlot({
    hist(c(eye_v3_ptl$Avg_saccade_count, eye_v4_ptl$Avg_saccade_count), breaks = seq(0, 250, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 3 & 4 \nUnder Partially-Separated Condition", xlab = "Average Saccade Count")
  })
  
  output$v3_4_std_txt_img = renderPlot({
    hist(c(eye_v3_std$Avg_Text_Image, eye_v4_std$Avg_Text_Image), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 35),
         main = "Version 3 & 4 \nUnder Standard Condition", xlab = "Average Text to Image Alternation")
  })
  
  output$v3_4_ptl_txt_img = renderPlot({
    hist(c(eye_v3_ptl$Avg_Text_Image, eye_v4_ptl$Avg_Text_Image), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 35),
         main = "Version 3 & 4 \nUnder Partially-Separated Condition", xlab = "Average Text to Image Alternation")
  })
  
  
  # v5_6 combine v5 and v6 by condition
  output$v5_6_std_img_ct = renderPlot({
    hist(c(eye_v5_std$Avg_image_fix_count, eye_v6_std$Avg_image_fix_count), breaks = seq(0, 130, by = 10), xlim = c(0, 100), ylim = c(0, 16),
         main = "Version 5 & 6 \nUnder Standard Condition", xlab = "Average Image Fix Count")
  })
  
  output$v5_6_cln_img_ct = renderPlot({
    hist(c(eye_v5_cln$Avg_image_fix_count, eye_v6_cln$Avg_image_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 16),
         main = "Version 5 & 6 \nUnder Clean Condition", xlab = "Average Image Fix Count")
  })
  
  output$v5_6_std_img_pct = renderPlot({
    hist(c(eye_v5_std$Avg_image_fix_time_pct, eye_v6_std$Avg_image_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 5 & 6 \nUnder Standard Condition", xlab = "Average Image Fix Time Percent")
  })
  
  output$v5_6_cln_img_pct = renderPlot({
    hist(c(eye_v5_cln$Avg_image_fix_time_pct, eye_v6_cln$Avg_image_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 25),
         main = "Version 5 & 6 \nUnder Clean Condition", xlab = "Average Image Fix Time Percent")
  })
  
  output$v5_6_std_txt_ct = renderPlot({
    hist(c(eye_v5_std$Avg_text_fix_count, eye_v6_std$Avg_text_fix_count), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 5 & 6 \nUnder Standard Condition", xlab = "Average Text Fix Count")
  })
  
  output$v5_6_cln_txt_ct = renderPlot({
    hist(c(eye_v5_cln$Avg_text_fix_count, eye_v6_cln$Avg_text_fix_count), breaks = seq(0, 200, by = 10), xlim = c(0, 100), ylim = c(0, 10),
         main = "Version 5 & 6 \nUnder Clean Condition", xlab = "Average Text Fix Count")
  })
  
  output$v5_6_std_txt_pct = renderPlot({
    hist(c(eye_v5_std$Avg_text_fix_time_pct, eye_v6_std$Avg_text_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 8),
         main = "Version 5 & 6 \nUnder Standard Condition", xlab = "Average Text Fix Time Percent")
  })
  
  output$v5_6_cln_txt_pct = renderPlot({
    hist(c(eye_v5_cln$Avg_text_fix_time_pct, eye_v6_cln$Avg_text_fix_time_pct), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 8),
         main = "Version 5 & 6 \nUnder Clean Condition", xlab = "Average Text Fix Time Percent")
  })
  
  output$v5_6_std_saccade_ct = renderPlot({
    hist(c(eye_v5_std$Avg_saccade_count, eye_v6_std$Avg_saccade_count), breaks = seq(0, 210, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 5 & 6 \nUnder Standard Condition", xlab = "Average Saccade Count")
  })
  
  output$v5_6_cln_saccade_ct = renderPlot({
    hist(c(eye_v5_cln$Avg_saccade_count, eye_v6_cln$Avg_saccade_count), breaks = seq(0, 200, by = 10), xlim = c(0, 100), ylim = c(0, 15),
         main = "Version 5 & 6 \nUnderClean Condition", xlab = "Average Saccade Count")
  })
  
  output$v5_6_std_txt_img = renderPlot({
    hist(c(eye_v5_std$Avg_Text_Image, eye_v6_std$Avg_Text_Image), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 35),
         main = "Version 5 & 6 \nUnder Standard Condition", xlab = "Average Text to Image Alternation")
  })
  
  output$v5_6_cln_txt_img = renderPlot({
    hist(c(eye_v5_cln$Avg_Text_Image, eye_v6_cln$Avg_Text_Image), breaks = seq(0, 100, by = 10), xlim = c(0, 100), ylim = c(0, 35),
         main = "Version 5 & 6 \nUnder Clean Condition", xlab = "Average Text to Image Alternation")
  })

  
} # end server function
