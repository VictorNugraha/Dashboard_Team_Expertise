#Layout---
fluidPage(
    
    #Spacing--- 
    div(style = "padding: 1px 0px; width: '100%'",
        titlePanel(title="", windowTitle="")),
    
    introjsUI(),
    useShinyjs(),
    
    #Navbar---
    navbarPage(
        
        #Title---
        title = div(img(src="logo.png", 
                        height = '45px', 
                        width = '150px'), 
                    style="text-align:justify;
                           font-size: 30px;
                           color:gray;"),
        
        #Theme bootswatch---
        theme = bs_theme(bootswatch = "litera",
                         base_font = font_google("Prompt"),
                         code_font = font_google("JetBrains Mono")),
        
        #MainID---
        id = "inTabset",
        header = tagList(useShinydashboard()),
        
        #Menu home screen---
        tabPanel(
            title = "",
            fluidRow(
                
                
                column(width = 12,
                
                br(),
                       
                actionButton(inputId = "skill",
                            label = strong("SKILL"),
                            style = "color: white;
                                    background-color: black;
                                    border-color: black"), 
                
                actionButton(inputId = "capstone",
                             label = strong("CAPSTONE"),
                             style = "color: white;
                                    font : 50;
                                    background-color: black;
                                    border-color: black"),
                
                align = "center",
                style = "margin-bottom: 10px;",
                style = "margin-top: -10px;",
                br(),
                br(),
                
                uiOutput("picker_input")
                
                )#,
                
                # box(
                #     width = 3,
                #     pickerInput(
                #         inputId = "name",
                #         label = HTML(paste("<b>Name</b>")),
                #         choices = list(
                #             "Team A" = c("Cut","Fafil", "Ina", "Tria", "Yosia", "Victor"),
                #             "Team B" = c("Dwi", "Kevin", "Lita", "Nabiilah", "Risman", "Wulan"),
                #             "Veteran" = c("Ajeng", "David", "Handoyo", "Tomy")),
                #         selected = unique(df$Nama),
                #         multiple = TRUE,
                #         options = list("actions-box" = TRUE,
                #                        "selected-text-format" = "count"),
                #         inline = TRUE,
                #         width = "390px")
                # ),
                # 
                # box(
                #     width = 3,
                #     pickerInput(
                #         inputId = "tools",
                #         label = HTML(paste("<b>Tools</b>")),
                #         choices = list(
                #             "Main Tools" = c("Python", "R", "SQL"),
                #             "Other Tools" = c("CSS", "MongoDB", "Spark", "Tableau", "Postman")
                #         ),
                #         selected = c("Python", "R", "SQL"),
                #         multiple = TRUE,
                #         options = list("actions-box" = TRUE,
                #                        "selected-text-format" = "count"),
                #         inline = TRUE,
                #         width = "390px")
                # ),
                # 
                # box(
                #     width = 3,
                #     pickerInput(
                #         inputId = "specialization",
                #         label = HTML(paste("<b>Specialization</b>")),
                #         choices = list("Specialization" = c("Data Analytics Specialization", "Data Visualization Specialization", "Machine Learning Specialization", "Other")),
                #         selected = c("Data Analytics Specialization", "Data Visualization Specialization", "Machine Learning Specialization", "Other"),
                #         multiple = TRUE,
                #         options = list("actions-box" = TRUE,
                #                        "selected-text-format" = "count"),
                #         inline = TRUE,
                #         width = "390px")
                # ),
                # 
                # box(
                #     width = 3,
                #     pickerInput(
                #         inputId = "matery",
                #         label = HTML(paste("<b>Course</b>")),
                #         choices = list(
                #             "Data Analytics Specialization" = c("P4DA", "Exploratory Data Analysis", "Data Wrangling & Visualization", "SQL Query"),
                #             "Data Visualization Specialization" = c("P4DS", "Practical Statistics", "Data Visualization", "Interactive Plotting"),
                #             "Machine Learning Specialization" = c("Regression Model", "Classification", "Unsupervised Learning", "Time Series", "Neural Network"),
                #             "Other" = c("API", "Cloud Platform", "Dashboard", "Survival Analysis", "Web Scraping")
                #         ),
                #         selected = c("P4DA", "Exploratory Data Analysis", "Data Wrangling & Visualization", "SQL Query", "P4DS", "Practical Statistics", "Data Visualization", "Interactive Plotting", "Regression Model", "Classification", "Unsupervised Learning", "Time Series", "Neural Network"),
                #         multiple = TRUE,
                #         options = list("actions-box" = TRUE,
                #                        "selected-text-format" = "count"),
                #         inline = TRUE,
                #         width = "390px")
                # )
            ),
                
                fluidPage(
                    fluidRow(
                        
                    column(
                        width = 12,
                        uiOutput("sankey_output")
                    )    
                        
                    # column(
                    #     width = 12,
                    #     uiOutput("sankey_output"),
                    #     uiOutput("sankey_output2")
                    # ),
                    
                    # column(
                    #     width = 12,
                    #     uiOutput("sankey_output2")
                    # )
                        
                # column(
                #     width = 12,
                #     sankeyNetworkOutput(outputId = "sankey",
                #                         height = "1300px"),
                #     
                #     sankeyNetworkOutput(outputId = "sankey2",
                #                         height = "1300px")
                #         
                #     )
                )
            )
        )
    )
)






















