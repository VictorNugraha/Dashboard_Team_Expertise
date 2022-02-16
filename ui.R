fluidPage(
    
    div(style = "padding: 1px 0px; width: '100%'",
        titlePanel(title="", windowTitle="")),
    
    introjsUI(),
    useShinyjs(),
    
    navbarPage(
        
        #Title---
        title = div(img(src="logo.png", 
                        height = '45px', 
                        width = '150px'), 
                    style="text-align:justify;
                           font-size: 30px;
                           color:gray;"),
        
        theme = bs_theme(bootswatch = "litera",
                         base_font = font_google("Prompt"),
                         code_font = font_google("JetBrains Mono")),
        
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
                                    font-size : 125%;
                                    background-color: black;
                                    border-color: black"), 
                
                actionButton(inputId = "capstone",
                             label = strong("CAPSTONE"),
                             style = "color: white;
                                    font-size : 125%;
                                    background-color: black;
                                    border-color: black"),
                
                align = "center",
                style = "margin-bottom: 10px;",
                style = "margin-top: -10px;",
                br(),
                br(),
                
                uiOutput("picker_input")
                
                )
            ),
                
                fluidPage(
                    fluidRow(
                        
                    column(
                        width = 12,
                        uiOutput("sankey_output")
                    )    
                )
            )
        )
    )
)






















