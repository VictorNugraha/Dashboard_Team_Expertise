function(input, output, session) {
  
  output$sankey <- renderSankeyNetwork({
    
    links <-
      df %>%
      filter(Nama %in% input$name,
             Bahasa %in% input$tools,
             Expertise_In_Algortima_Specialization %in% input$specialization,
             Expertise_In_Algortima_Mastery %in% input$matery) %>% 
      select(-Active) %>% 
      select(Nama, Bahasa,everything()) %>% 
      mutate(row = row_number()) %>%
      mutate(traveler = .[[1]],
             traveler2 = .[[2]],
             traveler3 = .[[3]],
             traveler4 = .[[4]],
             traveler5 = .[[5]]) %>%
      gather("column", "source", -row, -traveler, -traveler2, -traveler3, -traveler4, -traveler5) %>%
      mutate(column = match(column, names(df))) %>%
      arrange(row, column) %>%
      group_by(row) %>%
      mutate(target = lead(source)) %>%
      ungroup() %>%
      filter(!is.na(target)) %>%
      select(source, target, traveler, traveler2, traveler3, traveler4, traveler5) %>%
      group_by(source, target, traveler, traveler2, traveler3, traveler4, traveler5) %>%
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
    sn$x$links$traveler4 <- links$traveler4
    sn$x$links$traveler5 <- links$traveler5
    
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
  
}
  
  

    