#Layout---
fluidPage(
    
    #Spacing--- 
    div(style = "padding: 1px 0px; width: '100%'",
        titlePanel(title="", windowTitle="InvestNow")),
    
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
                
                box(
                    width = 4,
                    pickerInput(
                        inputId = "name",
                        label = "Name",
                        choices = list(
                            "Team A" = c("Cut","Fafil", "Ina", "Tria", "Yosia", "Victor"),
                            "Team B" = c("Dwi", "Kevin", "Lita", "Nabiilah", "Risman", "Wulan"),
                            "Veteran" = c("Ajeng", "David", "Handoyo", "Tomy")),
                        selected = unique(df$Nama),
                        multiple = TRUE,
                        options = list("actions-box" = TRUE,
                                       "selected-text-format" = "count"),
                        inline = TRUE,
                        width = "540px")
                ),
                
                box(
                    width = 4,
                    pickerInput(
                        inputId = "tools",
                        label = "Tools",
                        choices = list(
                            "Main Tools" = c("Python", "R", "SQL"),
                            "Other Tools" = c("CSS", "MongoDB", "Spark", "Tableau", "Postman")),
                        selected = c("Python", "R", "SQL"),
                        multiple = TRUE,
                        options = list("actions-box" = TRUE,
                                       "selected-text-format" = "count"),
                        inline = TRUE,
                        width = "540px")
                ),
                
                box(
                    width = 4,
                    pickerInput(
                        inputId = "topic",
                        label = "Topic",
                        choices = unique(df$sub_sub_spec),
                        selected = unique(df$sub_sub_spec),
                        multiple = TRUE,
                        options = list("actions-box" = TRUE,
                                       "selected-text-format" = "count"),
                        inline = TRUE,
                        width = "540px")
                ),
                
                column(
                    width = 12,
                    sankeyNetworkOutput(outputId = "sankey",
                                        height = "1300px")
                )
            )
        )
        
    )
    
)






















