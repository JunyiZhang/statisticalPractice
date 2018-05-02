# ui for Reading & Attention Project EDA

library(shiny)
library(shinyjs, warn.conflicts=FALSE, quietly=TRUE)


# This is the user interface function, and it's value
# is the return value of sourcing this file.
fluidPage(
  
  useShinyjs(),
  # Application title
  titlePanel("Exploratory Data Analysis Results for Reading & Attention Project"),
  
  # Sidebar with inputs (typically)
  sidebarLayout(
    sidebarPanel(width = 3,
                 
                 radioButtons("dataset", "Dataset:",
                              choices=c("Whole Dataset", "One Experiment", "Standard Condition"),
                              inline=FALSE),
                 
                 p(br()),
                 
                 shinyjs::hidden(
                   radioButtons("experiment", "Experiment:",
                                choices=c("Standard vs. Separated", "Standard vs. Partial",
                                          "Standard vs. Clean"),
                                inline=FALSE)
                 ),
                 
                 shinyjs::hidden(
                   radioButtons("version", "Version:",
                                choices=c("Standard First", "Standard Second"),
                                inline=FALSE)
                 ),
                 
                 p(br(), "( 'Whole dataset' is the entire dataset which is not separated by experiment, and EDA result of each variable will be presented upon your choice"),
                 p("'One Experiment' will show you the comparison between the two counterbalanced versions of one experiment, and also the comparison between the two layout conditions in one experiment"),
                 p("'Standard Condition' will show you the comparison among standard conditions of different experiments and counterbalanced versions)")
                 
    ),
    
    # Main Panel with outputs (typically)
    mainPanel(
      tabsetPanel(
        
        # comprehension dataset
        tabPanel("Comprehension Data",
                 sidebarLayout(
                   
                   sidebarPanel(width = 3,
                                
                                conditionalPanel(
                                  condition = "input.dataset == 'Whole Dataset'",
                                  uiOutput("compre_dropdown"),
                                  p(br(), "E1_5: Number of Correct Events Retelled from Event 1-5 (out of 5)"),
                                  p("E6_10: Number of Correct Events Retelled from Event 6-10 (out of 5)"),
                                  p("E_total: Total Number of Correct Events Retelled (out of 10)"),
                                  p("Q1_3: Total Score for Question 1-3 (out of 7)"),
                                  p("Q4_6: Total Score for Question 4-6 (out of 7)"),
                                  p("Q_total: Total Score for Questions (out of 14)")
                                  
                                ), 
                                
                                conditionalPanel(
                                  condition = "input.dataset == 'One Experiment' || input.dataset == 'Standard Condition'",
                                  selectInput("questions_events", "Questions OR Events",
                                              choices=c("Questions", "Events")),
                                  p(br(), "Questions: Question Score"),
                                  p("Events: Events-Retelling Score")
                                )
                                
                                
                   ),
                   
                   mainPanel(width = 9,
                             conditionalPanel(
                               condition = "input.dataset == 'Whole Dataset'",
                               verbatimTextOutput("compre_summary"), plotOutput("compre_plot")
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.questions_events == 'Events'",
                               fluidRow(
                                 column(6, plotOutput("plot_V1_E1_5")),
                                 column(6, plotOutput("plot_V2_E1_5")),
                                 column(6, plotOutput("plot_V1_E6_10")),
                                 column(6, plotOutput("plot_V2_E6_10")),
                                 column(6, plotOutput("plot_V12_E_std")),
                                 column(6, plotOutput("plot_V12_E_sep"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.questions_events == 'Questions'",
                               fluidRow(
                                 column(6, plotOutput("plot_V1_Q1_3")),
                                 column(6, plotOutput("plot_V2_Q1_3")),
                                 column(6, plotOutput("plot_V1_Q4_6")),
                                 column(6, plotOutput("plot_V2_Q4_6")),
                                 column(6, plotOutput("plot_V12_Q_std")),
                                 column(6, plotOutput("plot_V12_Q_sep"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.questions_events == 'Events'",
                               fluidRow(
                                 column(6, plotOutput("plot_V3_E1_5")),
                                 column(6, plotOutput("plot_V4_E1_5")),
                                 column(6, plotOutput("plot_V3_E6_10")),
                                 column(6, plotOutput("plot_V4_E6_10")),
                                 column(6, plotOutput("plot_V34_E_std")),
                                 column(6, plotOutput("plot_V34_E_part"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.questions_events == 'Questions'",
                               fluidRow(
                                 column(6, plotOutput("plot_V3_Q1_3")),
                                 column(6, plotOutput("plot_V4_Q1_3")),
                                 column(6, plotOutput("plot_V3_Q4_6")),
                                 column(6, plotOutput("plot_V4_Q4_6")),
                                 column(6, plotOutput("plot_V34_Q_std")),
                                 column(6, plotOutput("plot_V34_Q_part"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.questions_events == 'Events'",
                               fluidRow(
                                 column(6, plotOutput("plot_V5_E1_5")),
                                 column(6, plotOutput("plot_V6_E1_5")),
                                 column(6, plotOutput("plot_V5_E6_10")),
                                 column(6, plotOutput("plot_V6_E6_10")),
                                 column(6, plotOutput("plot_V56_E_std")),
                                 column(6, plotOutput("plot_V56_E_cln"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.questions_events == 'Questions'",
                               fluidRow(
                                 column(6, plotOutput("plot_V5_Q1_3")),
                                 column(6, plotOutput("plot_V6_Q1_3")),
                                 column(6, plotOutput("plot_V5_Q4_6")),
                                 column(6, plotOutput("plot_V6_Q4_6")),
                                 column(6, plotOutput("plot_V56_Q_std")),
                                 column(6, plotOutput("plot_V56_Q_cln"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.questions_events == 'Events'",
                               fluidRow(
                                 column(6, plotOutput("exp1_std1_E")),
                                 column(6, plotOutput("exp2_std1_E")),
                                 column(6, plotOutput("exp3_std1_E"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.questions_events == 'Questions'",
                               fluidRow(
                                 column(6, plotOutput("exp1_std1_Q")),
                                 column(6, plotOutput("exp2_std1_Q")),
                                 column(6, plotOutput("exp3_std1_Q"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.questions_events == 'Events'",
                               fluidRow(
                                 column(6, plotOutput("exp1_std2_E")),
                                 column(6, plotOutput("exp2_std2_E")),
                                 column(6, plotOutput("exp3_std2_E"))
                               )
                             ),
                             
                             conditionalPanel(
                               condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.questions_events == 'Questions'",
                               fluidRow(
                                 column(6, plotOutput("exp1_std2_Q")),
                                 column(6, plotOutput("exp2_std2_Q")),
                                 column(6, plotOutput("exp3_std2_Q"))
                               )
                             )
                             
                   )
                 )
        ),
        
        # eye tracking dataset
        tabPanel("Eye Tracker Data",
                 sidebarLayout(
                   
                   sidebarPanel(
                     uiOutput("eye_dropdown"),
                     p(br(), "Avg_image_fix_count: Average Image Fixation Count across All Pages"),
                     p("Avg_image_fix_time_pct: Average Image Fixation Time Percent across All Pages"),
                     p("Avg_text_fix_count: Average Image Fixation Count across All Pages"),
                     p("Avg_text_fix_time_pct: Average Text Fixation Time Percent across All Pages"),
                     p("Avg_saccade_count: Average Saccade Count across All Pages"),
                     p("Avg_Text_Image: Average Text-to-Image Alternation across All Pages")
                   ),
                   
                   mainPanel(
                     # whole dataset
                     conditionalPanel(
                       condition = "input.dataset == 'Whole Dataset' && input.eye_vars == 'Avg_image_fix_count'",
                       verbatimTextOutput("avg_img_fix_ct_sum"), plotOutput("avg_img_fix_ct_plot")
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Whole Dataset' && input.eye_vars == 'Avg_text_fix_count'",
                       verbatimTextOutput("avg_txt_fix_ct_sum"), plotOutput("avg_txt_fix_ct_plot")
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Whole Dataset' && input.eye_vars == 'Avg_image_fix_time_pct'",
                       verbatimTextOutput("avg_img_fix_pct_sum"), plotOutput("avg_img_fix_pct_plot")
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Whole Dataset' && input.eye_vars == 'Avg_text_fix_time_pct'",
                       verbatimTextOutput("avg_txt_fix_pct_sum"), plotOutput("avg_txt_fix_pct_plot")
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Whole Dataset' && input.eye_vars == 'Avg_saccade_count'",
                       verbatimTextOutput("avg_saccade_ct_sum"), plotOutput("avg_saccade_ct_plot")
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Whole Dataset' && input.eye_vars == 'Avg_Text_Image'",
                       verbatimTextOutput("avg_text_img_alt_sum"), plotOutput("avg_text_img_alt_plot")
                     ),
                     
                     
                     # one experiment exp1
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.eye_vars == 'Avg_image_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v1_std_img_ct")),
                         column(6, plotOutput("v2_spt_img_ct")),
                         column(6, plotOutput("v1_spt_img_ct")),
                         column(6, plotOutput("v2_std_img_ct")),
                         column(6, plotOutput("v1_2_std_img_ct")),
                         column(6, plotOutput("v1_2_spt_img_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.eye_vars == 'Avg_image_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v1_std_img_pct")),
                         column(6, plotOutput("v2_spt_img_pct")),
                         column(6, plotOutput("v1_spt_img_pct")),
                         column(6, plotOutput("v2_std_img_pct")),
                         column(6, plotOutput("v1_2_std_img_pct")),
                         column(6, plotOutput("v1_2_spt_img_pct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.eye_vars == 'Avg_text_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v1_std_txt_ct")),
                         column(6, plotOutput("v2_spt_txt_ct")),
                         column(6, plotOutput("v1_spt_txt_ct")),
                         column(6, plotOutput("v2_std_txt_ct")),
                         column(6, plotOutput("v1_2_std_txt_ct")),
                         column(6, plotOutput("v1_2_spt_txt_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.eye_vars == 'Avg_text_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v1_std_txt_pct")),
                         column(6, plotOutput("v2_spt_txt_pct")),
                         column(6, plotOutput("v1_spt_txt_pct")),
                         column(6, plotOutput("v2_std_txt_pct")),
                         column(6, plotOutput("v1_2_std_txt_pct")),
                         column(6, plotOutput("v1_2_spt_txt_pct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.eye_vars == 'Avg_saccade_count'",
                       fluidRow(
                         column(6, plotOutput("v1_std_saccade_ct")),
                         column(6, plotOutput("v2_spt_saccade_ct")),
                         column(6, plotOutput("v1_spt_saccade_ct")),
                         column(6, plotOutput("v2_std_saccade_ct")),
                         column(6, plotOutput("v1_2_std_saccade_ct")),
                         column(6, plotOutput("v1_2_spt_saccade_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Separated' && input.eye_vars == 'Avg_Text_Image'",
                       fluidRow(
                         column(6, plotOutput("v1_std_txt_img")),
                         column(6, plotOutput("v2_spt_txt_img")),
                         column(6, plotOutput("v1_spt_txt_img")),
                         column(6, plotOutput("v2_std_txt_img")),
                         column(6, plotOutput("v1_2_std_txt_img")),
                         column(6, plotOutput("v1_2_spt_txt_img"))
                       )
                     ),
                     
                     
                     # one experiment exp2
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.eye_vars == 'Avg_image_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v3_std_img_ct")),
                         column(6, plotOutput("v4_ptl_img_ct")),
                         column(6, plotOutput("v3_ptl_img_ct")),
                         column(6, plotOutput("v4_std_img_ct")),
                         column(6, plotOutput("v3_4_std_img_ct")),
                         column(6, plotOutput("v3_4_ptl_img_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.eye_vars == 'Avg_image_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v3_std_img_pct")),
                         column(6, plotOutput("v4_ptl_img_pct")),
                         column(6, plotOutput("v3_ptl_img_pct")),
                         column(6, plotOutput("v4_std_img_pct")),
                         column(6, plotOutput("v3_4_std_img_pct")),
                         column(6, plotOutput("v3_4_ptl_img_pct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.eye_vars == 'Avg_text_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v3_std_txt_ct")),
                         column(6, plotOutput("v4_ptl_txt_ct")),
                         column(6, plotOutput("v3_ptl_txt_ct")),
                         column(6, plotOutput("v4_std_txt_ct")),
                         column(6, plotOutput("v3_4_std_txt_ct")),
                         column(6, plotOutput("v3_4_ptl_txt_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.eye_vars == 'Avg_text_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v3_std_txt_pct")),
                         column(6, plotOutput("v4_ptl_txt_pct")),
                         column(6, plotOutput("v3_ptl_txt_pct")),
                         column(6, plotOutput("v4_std_txt_pct")),
                         column(6, plotOutput("v3_4_std_txt_pct")),
                         column(6, plotOutput("v3_4_ptl_txt_pct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.eye_vars == 'Avg_saccade_count'",
                       fluidRow(
                         column(6, plotOutput("v3_std_saccade_ct")),
                         column(6, plotOutput("v4_ptl_saccade_ct")),
                         column(6, plotOutput("v3_ptl_saccade_ct")),
                         column(6, plotOutput("v4_std_saccade_ct")),
                         column(6, plotOutput("v3_4_std_saccade_ct")),
                         column(6, plotOutput("v3_4_ptl_saccade_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Partial' && input.eye_vars == 'Avg_Text_Image'",
                       fluidRow(
                         column(6, plotOutput("v3_std_txt_img")),
                         column(6, plotOutput("v4_ptl_txt_img")),
                         column(6, plotOutput("v3_ptl_txt_img")),
                         column(6, plotOutput("v4_std_txt_img")),
                         column(6, plotOutput("v3_4_std_txt_img")),
                         column(6, plotOutput("v3_4_ptl_txt_img"))
                       )
                     ),
                     
                     
                     
                     # one experiment exp3
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.eye_vars == 'Avg_image_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v5_std_img_ct")),
                         column(6, plotOutput("v6_cln_img_ct")),
                         column(6, plotOutput("v5_cln_img_ct")),
                         column(6, plotOutput("v6_std_img_ct")),
                         column(6, plotOutput("v5_6_std_img_ct")),
                         column(6, plotOutput("v5_6_cln_img_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.eye_vars == 'Avg_image_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v5_std_img_pct")),
                         column(6, plotOutput("v6_cln_img_pct")),
                         column(6, plotOutput("v5_cln_img_pct")),
                         column(6, plotOutput("v6_std_img_pct")),
                         column(6, plotOutput("v5_6_std_img_pct")),
                         column(6, plotOutput("v5_6_cln_img_pct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.eye_vars == 'Avg_text_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v5_std_txt_ct")),
                         column(6, plotOutput("v6_cln_txt_ct")),
                         column(6, plotOutput("v5_cln_txt_ct")),
                         column(6, plotOutput("v6_std_txt_ct")),
                         column(6, plotOutput("v5_6_std_txt_ct")),
                         column(6, plotOutput("v5_6_cln_txt_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.eye_vars == 'Avg_text_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v5_std_txt_pct")),
                         column(6, plotOutput("v6_cln_txt_pct")),
                         column(6, plotOutput("v5_cln_txt_pct")),
                         column(6, plotOutput("v6_std_txt_pct")),
                         column(6, plotOutput("v5_6_std_txt_pct")),
                         column(6, plotOutput("v5_6_cln_txt_pct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.eye_vars == 'Avg_saccade_count'",
                       fluidRow(
                         column(6, plotOutput("v5_std_saccade_ct")),
                         column(6, plotOutput("v6_cln_saccade_ct")),
                         column(6, plotOutput("v5_cln_saccade_ct")),
                         column(6, plotOutput("v6_std_saccade_ct")),
                         column(6, plotOutput("v5_6_std_saccade_ct")),
                         column(6, plotOutput("v5_6_cln_saccade_ct"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'One Experiment' && input.experiment == 'Standard vs. Clean' && input.eye_vars == 'Avg_Text_Image'",
                       fluidRow(
                         column(6, plotOutput("v5_std_txt_img")),
                         column(6, plotOutput("v6_cln_txt_img")),
                         column(6, plotOutput("v5_cln_txt_img")),
                         column(6, plotOutput("v6_std_txt_img")),
                         column(6, plotOutput("v5_6_std_txt_img")),
                         column(6, plotOutput("v5_6_cln_txt_img"))
                       )
                     ),
                     
                     
                     # std condition, std first
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.eye_vars == 'Avg_image_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v1_std_img_ct_s")), 
                         column(6, plotOutput("v3_std_img_ct_s")),
                         column(6, plotOutput("v5_std_img_ct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.eye_vars == 'Avg_text_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v1_std_txt_ct_s")), 
                         column(6, plotOutput("v3_std_txt_ct_s")),
                         column(6, plotOutput("v5_std_txt_ct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.eye_vars == 'Avg_image_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v1_std_img_pct_s")), 
                         column(6, plotOutput("v3_std_img_pct_s")),
                         column(6, plotOutput("v5_std_img_pct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.eye_vars == 'Avg_text_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v1_std_txt_pct_s")), 
                         column(6, plotOutput("v3_std_txt_pct_s")),
                         column(6, plotOutput("v5_std_txt_pct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.eye_vars == 'Avg_saccade_count'",
                       fluidRow(
                         column(6, plotOutput("v1_std_saccade_ct_s")), 
                         column(6, plotOutput("v3_std_saccade_ct_s")),
                         column(6, plotOutput("v5_std_saccade_ct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard First' && input.eye_vars == 'Avg_Text_Image'",
                       fluidRow(
                         column(6, plotOutput("v1_std_txt_img_s")), 
                         column(6, plotOutput("v3_std_txt_img_s")),
                         column(6, plotOutput("v5_std_txt_img_s"))
                       )
                     ),
                     
                     
                     # std condition, std second
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.eye_vars == 'Avg_image_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v2_std_img_ct_s")), 
                         column(6, plotOutput("v4_std_img_ct_s")),
                         column(6, plotOutput("v6_std_img_ct_s"))
                       )
                     ),
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.eye_vars == 'Avg_text_fix_count'",
                       fluidRow(
                         column(6, plotOutput("v2_std_txt_ct_s")), 
                         column(6, plotOutput("v4_std_txt_ct_s")),
                         column(6, plotOutput("v6_std_txt_ct_s"))
                       )
                     ),
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.eye_vars == 'Avg_image_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v2_std_img_pct_s")), 
                         column(6, plotOutput("v4_std_img_pct_s")),
                         column(6, plotOutput("v6_std_img_pct_s"))
                       )
                     ),
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.eye_vars == 'Avg_text_fix_time_pct'",
                       fluidRow(
                         column(6, plotOutput("v2_std_txt_pct_s")), 
                         column(6, plotOutput("v4_std_txt_pct_s")),
                         column(6, plotOutput("v6_std_txt_pct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.eye_vars == 'Avg_saccade_count'",
                       fluidRow(
                         column(6, plotOutput("v2_std_saccade_ct_s")), 
                         column(6, plotOutput("v4_std_saccade_ct_s")),
                         column(6, plotOutput("v6_std_saccade_ct_s"))
                       )
                     ),
                     
                     conditionalPanel(
                       condition = "input.dataset == 'Standard Condition' && input.version == 'Standard Second' && input.eye_vars == 'Avg_Text_Image'",
                       fluidRow(
                         column(6, plotOutput("v2_std_txt_img_s")), 
                         column(6, plotOutput("v4_std_txt_img_s")),
                         column(6, plotOutput("v6_std_txt_img_s"))
                       )
                     )
                     
                   )
                 )
        )
      )  # end tabsetPanel
    )  # end (main) Main Panel
  )
) # End fluidPage()
