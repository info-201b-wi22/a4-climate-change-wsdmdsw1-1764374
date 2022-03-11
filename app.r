co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
library(shiny)
library(dplyr)
library(plotly)
ui <- fluidPage(
  tabsetPanel(
    tabPanel("Introduction",
             h2("This is a header"),
             br(),
             p("This is a paragraph")),
    tabPanel("Visualization",
             sidebarLayout(
               sidebarPanel(
                 selectInput("Variable", "Select the Variable", c("co2", "co2_per_capita")),
                 selectInput("Country", "Select Country", sort(unique(co2_data$country)))
              
               ),
               mainPanel(
                 plotlyOutput("Plot")
               )
             )),
    tabPanel("Value Sensitive Design",
             h2("This is a header"),
             br(),
             p("This is a paragraph")))
    
  )
  
server <- function(input, output) {
  output$Plot <- renderPlotly({
    ylab <- setNames(c("CO2 in Millions of Tons", "CO2 in Tons Per Capita"),
                     c("co2", "co2_per_capita"))
    df <- co2_data %>%
      filter(country == input$Country)
    plot_ly() %>%
      add_trace(
        type = "scatter", mode = "markers+lines+text", 
        x = df$year, y = df[,input$Variable]
        
      ) %>%
      layout(title = "CO2 Change Over Time", xaxis = list(title = "Year"), yaxis = list(title = ylab[input$Variable]))
  })
  
}
shinyApp(ui, server)
