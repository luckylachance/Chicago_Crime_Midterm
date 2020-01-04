library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
dropdowns <- unique(crime[c("PRIMARY", "SECONDARY")])
dropdowns <- dropdowns[order(dropdowns$PRIMARY,dropdowns$SECONDARY),]
options(scipen=999,width=65)


shinyServer(function(session,input, output) {
    
    observe({
        print(input$Cat1)
        x <- dropdowns %>% 
            filter(PRIMARY == input$Cat1) %>% select(SECONDARY) 
            print(x)
    updateSelectInput(session,'Cat2',"Select Secondary Offense",choices = unique(x))
    })
    
    
    output$bar <- renderPlot({
        crime_f <- crime_wk %>% 
           filter(PRIMARY== input$Cat1)
       
        ggplot(crime_f, aes(x=WEEK,y=INCIDENTS)) +
            geom_bar(stat = 'identity')+
            theme(axis.text.x=element_text(angle = 90,hjust=1))
            #coord_flip()
     })
    output$map <- renderPlot({
        mapPrimaryData <- crime %>% filter(PRIMARY == input$Cat1)
    
            qmplot(LON, LAT, data = mapPrimaryData, geom = "blank", 
             zoom = 11, maptype = "watercolor", darken = .1, legend = "Top_Right'"
                ) +
             stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = .1, color = NA) +
             scale_fill_gradient2(input$Cat1, low = "white", mid = "yellow", high = "red")
        
    })
    
})


