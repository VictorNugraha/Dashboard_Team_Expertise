function(input, output, session) {
  
  observeEvent(input$skill,{
    
    output$sankey_output <- renderUI({
      
      sankeyNetworkOutput("sankey",
                          height = "750px")
      
    })
    
    output$picker_input <- renderUI({
      
      fluidRow(
        
        box(
          width = 3,
          tags$head(tags$script(picker_in)),
          pickerInput(
            inputId = "name",
            label = HTML(paste("<b>Name</b>")),
            choices = name_choice,
            selected = unique(df$Nama),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "270px")
        ),
        
        box(
          width = 3,
          pickerInput(
            inputId = "tools",
            label = HTML(paste("<b>Tools</b>")),
            choices = list(
              "Main Tools" = main_tools,
              "Other" =  setdiff(all_tools, main_tools)
            ),
            selected = c("Python", "R", "SQL"),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "270px")
        ),
        
        box(
          width = 3,
          pickerInput(
            inputId = "specialization",
            label = HTML(paste("<b>Specialization</b>")),
            choices = list("Specialization" = c("Data Analytics Specialization", "Data Visualization Specialization", "Machine Learning Specialization", "Other")),
            selected = c("Data Analytics Specialization", "Data Visualization Specialization", "Machine Learning Specialization", "Other"),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "270px")
        ),
        
        box(
          width = 3,
          pickerInput(
            inputId = "matery",
            label = HTML(paste("<b>Course</b>")),
            choices = list(
              "Data Analytics Specialization" = c("P4DA", "Exploratory Data Analysis", "Data Wrangling & Visualization", "SQL Query"),
              "Data Visualization Specialization" = c("P4DS", "Practical Statistics", "Data Visualization", "Interactive Plotting"),
              "Machine Learning Specialization" = c("Regression Model", "Classification", "Unsupervised Learning", "Time Series", "Neural Network"),
              "Other" = c("API", "Cloud Platform", "Dashboard", "Survival Analysis", "Web Scraping", "Other")
            ),
            selected = c("P4DA", "Exploratory Data Analysis", "Data Wrangling & Visualization", "SQL Query", "P4DS", "Practical Statistics", "Data Visualization", "Interactive Plotting", "Regression Model", "Classification", "Unsupervised Learning", "Time Series", "Neural Network"),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "270px")
        )
      )  
    })
    
  }, ignoreNULL = FALSE, ignoreInit = FALSE, once = F)
  
  output$sankey <- renderSankeyNetwork({
    
    links <-
      df %>%
      select(-Active) %>% 
      filter(Nama %in% input$name,
             Bahasa %in% input$tools,
             Expertise.In.Algortima.Specialization %in% c(input$specialization, NA), 
             Expertise.In.Algortima.Mastery %in% c(input$matery, NA)
      ) %>% 
      mutate(row = row_number()) %>%
      mutate(traveler = .[[1]],
             traveler2 = .[[2]],
             traveler3 = .[[3]],
             traveler4 = .[[4]],
             traveler5 = .[[5]],
             traveler6 = .[[6]]) %>%
      gather("column", "source", -row, -traveler, -traveler2, -traveler3, -traveler4, -traveler5, -traveler6) %>%
      mutate(column = match(column, names(df))) %>%
      arrange(row, column) %>%
      group_by(row) %>%
      mutate(target = lead(source)) %>%
      ungroup() %>%
      filter(!is.na(target)) %>%
      select(source, target, traveler, traveler2, traveler3, traveler4, traveler5, traveler6) %>%
      group_by(source, target, traveler, traveler2, traveler3, traveler4, traveler5, traveler6) %>%
      summarise(count = n()) %>%
      mutate_all(list(~na_if(.,""))) %>% 
      ungroup()
    
    nodes <- data.frame(name = unique(c(links$source, links$target)))
    links$source <- match(links$source, nodes$name) - 1
    links$target <- match(links$target, nodes$name) - 1
    
    sn <- sankeyNetwork(
      Links = links,
      Nodes = nodes,
      Source = 'source',
      Target = 'target',
      Value = 'count',
      NodeID = 'name',
      fontSize = 12,
      sinksRight = FALSE
    )
    
    # add origin back into the links data because sankeyNetwork strips it out
    sn$x$links$traveler <- links$traveler
    sn$x$links$traveler2 <- links$traveler2
    sn$x$links$traveler3 <- links$traveler3
    sn$x$links$traveler4 <- links$traveler4
    sn$x$links$traveler5 <- links$traveler5
    sn$x$links$traveler6 <- links$traveler6
    
    # add onRender JavaScript to set the click behavior
    htmlwidgets::onRender(
      sn,
      '
      function(el, x) {
    
                  var nodes = d3.selectAll(".node");
                  var links = d3.selectAll(".link");
                  var default_opacity = 0.15; 
                  var highlighted_opacity = 0.8;
                              
                  // cursor
                  nodes.select("rect").style("cursor", "pointer");
                              
                  // link color
                  links.style("stroke", "grey");
                              
                  // text color
                  nodes.select("text").style("fill", "black");
                              
                  // EVENT: remove the drag ability
                  nodes.on("mousedown.drag", null);
                
                  nodes.select("rect").style("cursor", "pointer");
                
                  nodes.on("mousedown.drag", null);
                  
                  nodes.on("mouseover", hover);
                
                  function hover(a, b) {
                    links
                      .style("stroke-opacity", function(a1) {
                          if(a1.traveler == a.name || a1.traveler2 == a.name || a1.traveler3 == a.name || a1.traveler4 == a.name || a1.traveler5 == a.name) {
                            return 0.6
                          }
                            return 0.1
                        });
                  };
      
                  // EVENT: nodes mouse out, change link to default opacity
                  nodes.on("mouseout", function(d) {
                      links.style("stroke-opacity", default_opacity);
                  });
                  
                  // EVENT: nodes click, get node name
                  nodes.on("click", function(d) {
                      Shiny.onInputChange("clicked_node", d.name);
                  });
    }
    '
    )
  })
  
  observeEvent(input$capstone,{
    
    output$sankey_output <- renderUI({
      
      sankeyNetworkOutput("sankey2",
                          height = "750px")
      
    })
    
    output$picker_input <- renderUI({
      
      fluidRow(
        
        box(
          width = 4,
          tags$head(tags$script(picker_in)),
          pickerInput(
            inputId = "name",
            label = HTML(paste("<b>Name</b>")),
            choices = name_choice,
            selected = unique(df$Nama),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "370px")
        ),
        
        box(
          width = 4,
          pickerInput(
            inputId = "specialization",
            label = HTML(paste("<b>Specialization</b>")),
            choices = list("Specialization" = c("Data Analytics Specialization", "Data Visualization Specialization", "Machine Learning Specialization")),
            selected = c("Data Analytics Specialization", "Data Visualization Specialization", "Machine Learning Specialization"),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "370px")
        ),
        
        box(
          width = 4,
          pickerInput(
            inputId = "matery",
            label = HTML(paste("<b>Topic </b>")),
            choices = list(
              "Data Analytics Specialization" = c("Flask API", "Flask UI", "Telebot", "Web Scraping"),
              "Data Visualization Specialization" = c("Shiny Dashboard"),
              "Machine Learning Specialization" = c("Image Classification", "Non-Purr Forecasting", "Purrr Forecasting", "Tabular Classification", "Text Classification")
            ),
            selected = c("Flask API", "Flask UI", "Telebot", "Web Scraping", "Shiny Dashboard", "Image Classification", "Non-Purr Forecasting", "Purrr Forecasting", "Tabular Classification", "Text Classification"),
            multiple = TRUE,
            options = list("actions-box" = TRUE,
                           "selected-text-format" = "count"),
            inline = TRUE,
            width = "370px")
        )
        
      )
      
    })
    
  })
  
  output$sankey2 <- renderSankeyNetwork({
    
    links <-
      df2 %>%
      select(-Active) %>% 
      filter(Nama %in% input$name,
             Capstone.Specialization %in% input$specialization,
             Capstone.Topic %in% input$matery) %>% 
      mutate(row = row_number()) %>%
      mutate(traveler = .[[1]],
             traveler2 = .[[2]],
             traveler3 = .[[3]]) %>%
      gather("column", "source", -row, -traveler, -traveler2, -traveler3) %>%
      mutate(column = match(column, names(df2))) %>%
      arrange(row, column) %>%
      group_by(row) %>%
      mutate(target = lead(source)) %>%
      ungroup() %>%
      filter(!is.na(target)) %>%
      select(source, target, traveler, traveler2, traveler3) %>%
      group_by(source, target, traveler, traveler2, traveler3) %>%
      summarise(count = n()) %>%
      ungroup()
    
    nodes <- data.frame(name = unique(c(links$source, links$target)))
    links$source <- match(links$source, nodes$name) - 1
    links$target <- match(links$target, nodes$name) - 1
    
    sn <- sankeyNetwork(
      Links = links,
      Nodes = nodes,
      Source = 'source',
      Target = 'target',
      Value = 'count',
      NodeID = 'name',
      fontSize = 16
    )
    
    # add origin back into the links data because sankeyNetwork strips it out
    sn$x$links$traveler <- links$traveler
    sn$x$links$traveler2 <- links$traveler2
    sn$x$links$traveler3 <- links$traveler3
    
    # add onRender JavaScript to set the click behavior
    htmlwidgets::onRender(
      sn,
      '
    function(el, x) {
    
      var nodes = d3.selectAll(".node");
      var links = d3.selectAll(".link");
                      var default_opacity = 0.15; 
                  var highlighted_opacity = 0.8;
                  
                  // cursor
                  nodes.select("rect").style("cursor", "pointer");
                  
                  // link color
                  links.style("stroke", "grey");
                  
                  // text color
                  nodes.select("text").style("fill", "black");
                  
                  // EVENT: remove the drag ability
                  nodes.on("mousedown.drag", null);
    
      nodes.select("rect").style("cursor", "pointer");
    
      nodes.on("mousedown.drag", null);
      
      nodes.on("mouseover", hover);
    
      function hover(a, b) {
        links
          .style("stroke-opacity", function(a1) {
              if(a1.traveler == a.name || a1.traveler2 == a.name || a1.traveler3 == a.name || a1.traveler4 == a.name || a1.traveler5 == a.name) {
                return 0.6
              }
                return 0.1
            });
      };
      
                      // EVENT: nodes mouse out, change link to default opacity
                  nodes.on("mouseout", function(d) {
                      links.style("stroke-opacity", default_opacity);
                  });
                  
                  // EVENT: nodes click, get node name
                  nodes.on("click", function(d) {
                      Shiny.onInputChange("clicked_node", d.name);
                  });
      
    }
    '
    )
  })
  
  observeEvent(input$group_select, {
    req(input$group_select)
    updatePickerInput(session, "name", 
                      selected = name_choice[[input$group_select]])
  })
  
}

  

    