co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
library(shiny)
library(dplyr)
library(plotly)
ui <- fluidPage(
  tabsetPanel(
    tabPanel("Introduction",
             h2("Overview"),
             br(),
             p("This is a paragraph. In this assignment I have chosen to look at the change in CO2 over time in comparison to country. I chose to use CO2 in millions of tons and CO2 per capita based on the country. 
               The line graph shows a trend from when the data was first collected until 2020. The dataset consists of many features regarding the different ways CO2 is encountered in our world. The data is collected
               and maintined by Our World in Data, which is a publication that is tasked with finding the largest global problems
               (in this case CO2 emission) and how pwerful changes can reshape the world. As per the About page on their website, Our World In Data 
               uses both a small team and the works and research from a community of scholars around the world.
               They do this so that they can get multiple persepctives and post the best available research and data in an understandable way.
               Further, the publication collects the data so that there is available information about CO2 emissions for the public to educate themselves with. 
               They design their work in an effort to create an impact that goes beyond what they themselves as a company can fulfill directly.Because the dataset is so large and contains
               data from countries all over the world, one limitation could be that the data is skewed in countries that are not super open about their CO2 emissions. 
               In addition, another problem with the data could be that it has periods of time where there is no data present, making a variable's trend seem steeper in either way."),
             br(),
             p("Some relevant values in the data are: 2005 is the largest amount of CO2 emitted by the United states in history at a staggering 6,134 million tons. This is in comparison
               to when it was at its lowest in 1800 at .253 million tons. Over the past 10 years, CO2 emissions in America has dropped by 853 million tons. Currently, the United States
               is putting out about 4,712 million tons of CO2 (in 2020). Lastly, since the start of when the data was recorded for America, the median amount is 2,356.51 million tons."),
            
             ),
         
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
             h2("Value Sensitive Design"),
             br(),
             p("Envision your system in use by a single stakeholder. Now imagine 100 such individuals interacting with the system. 
               Then 1,000 individuals. Then 100,00. What new interactions might emerge from widespread use? Find three synergistic benefits of widespread 
               use and three potential breakdowns."),
             br(),
             p("Three benefits of widespread use can include the following: More people are educated on why a certain topic it matters.
               Another is that, as I stated before, people can act upon something that is widespread that has come across their path in ways that others
               before could not have. An example of this is that an issue like this comes to the attention of a large company and they get involved to 
               improve the sitaution. Lastly, this eliminates the questions about certain phenomenons such as CO2 emissions by widespreading the data
               thereby making it a fact knwon by all."),
             br(),
             p("Three potential breakdowns of widespread use are as follows: Creation of tensions between those who collect data such as researchers and companies due 
               to different findings. In addition, widespread use of real-world data can also get into the hands of those who intend to intentionally misuse it to 
               push an agenda. This was seen a lot during the COVID-19 pandemic. Lastly, when data is released widespread it is the raw form of the data, so it
               is hard for an everyday person to interpret the data unles they know how to."),
            
             ))
    
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
