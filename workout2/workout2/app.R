
library(shiny)
library(ggplot2)

ui <- fluidPage(
  
   titlePanel("Savings Simulations"),
   fluidRow(
      column(4,
         sliderInput("initial",
                     "Initial Amount:",
                     min = 0, max = 100000 ,value = 1000,step = 500 , pre = "$"),
         sliderInput("contri",
                     "Annual Contribution:",
                     min = 0, max = 50000,value = 2000,step = 500, pre = "$")
         ),
      column( 4, 
              
        sliderInput( "return",
                     "Return Rate(in %):",
                      min = 0, max = 20,value = 5,step = 0.1),
        sliderInput("growth",
                    "Growth Rate (in %):",
                    min = 0, max = 20,value = 2,step = 0.1)
        ),
      column(4, 
         sliderInput("years",
                      "Years:",
                      min = 0, max = 50,value = 20, step = 1),
         selectInput("facet",
                     "Facet?",
                     c("No","Yes"))
      )),
      
        hr(),
      
        h4("Timelines"),
      
        plotOutput("timeline"),
      
        h4("Balances"),
      
        tableOutput("balance")

   )




#1) Future Value Function
#' @title Future Value Function
#' @description Caculate the future value of the invesment
#' @param rate  annual rate of return
#' @param years  time (in years)
#' @param amount  present value amount (i.e. how much you invest)
#' @return future value

future_value <- function(amount,rate,years){
  fv <- amount*(1+rate)^years
  return(fv)
}


#2) Future Value of Annuity

#' @title Future Value of Annuity
#' @description Caculate the future value of Annuity
#' @param rate  annual rate of return
#' @param years  time (in years)
#' @param contrib contributed amount
#' @return Future Value of Annuity

annuity <- function(contrib,rate,years){
  fva <- contrib*(((1+rate)^years-1)/rate)
  return(fva)
}


#3) Future Value of Growing Annuity

#' @title Future Value of Growing Annuity
#' @description Caculate the Future Value of Growing Annuity
#' @param rate  annual rate of return
#' @param years  time (in years)
#' @param contrib contributed amount
#' @param growth  annual growth rate
#' @return Future Value of Growing Annuity

growing_annuity <- function(contrib, rate, growth, years){
  fvga <- contrib*(((1+rate)^years-(1+growth)^years)/(rate-growth))
  return(fvga)
}


server <- function(input, output) {
  
dat <- reactive({
  
  year = input$years
  no_contrib <- rep(0, year + 1)
  for(i in 0:year){
    no_contrib[i+1] = future_value(input$initial,input$return/100,i)
  }
  
  year = input$years
  fixed_contrib <- rep(0, year + 1)
  for(i in 0:year){
    fixed_contrib[i+1] = future_value(input$initial,input$return/100,i) + annuity(input$contri,input$return/100,i)
  }
  
  growing_contrib <- rep(0, year + 1)
  for(i in 0:year){
    growing_contrib[i+1] = future_value(input$initial,input$return/100,i) + growing_annuity(input$contri,input$return/100,input$growth/100,i)
  }
  
  dat <- data.frame(
    year = rep(c(0: input$years),3),
    value = c(no_contrib,fixed_contrib,growing_contrib),
    mode = rep(c("no_contrib","fixed_contrib","growing_contrib"),each = input$years+1)
  )
  
  return(dat)
})

bal <- reactive({
  year = input$years
  no_contrib <- rep(0, year + 1)
  for(i in 0:year){
    no_contrib[i+1] = future_value(input$initial,input$return/100,i)
  }
  
  year = input$years
  fixed_contrib <- rep(0, year + 1)
  for(i in 0:year){
    fixed_contrib[i+1] = future_value(input$initial,input$return/100,i) + annuity(input$contri,input$return/100,i)
  }
  
  growing_contrib <- rep(0, year + 1)
  for(i in 0:year){
    growing_contrib[i+1] = future_value(input$initial,input$return/100,i) + growing_annuity(input$contri,input$return/100,input$growth/100,i)
  }
  bal <- data.frame(
    year = 0: input$years,
    no_contrib,
    fixed_contrib,
    growing_contrib)
  
  return(bal)
})

output$timeline <- renderPlot({
  if(input$facet == "No"){
    color = c("no_contrib","fixed_contrib","growing_contrib")
    ggplot(data = dat(),aes(year,value,goup = mode,color = mode))+
    geom_line(size = 0.8)+
    geom_point()+
    labs(title = "Three modes of investing", year = "year", y = "Value")+
    theme_bw()}
  else(ggplot(data = dat(),aes(year,value,color = mode,))+
         geom_line(size = 0.8)+
         geom_point()+
         geom_area(aes(fill = mode),alpha = 0.5, linetype = 0)+
         facet_wrap(~mode)+
         labs(title = "Three modes of investing", year = "year", y = "Value")+
         theme_bw()
       )
   })

output$balance <- renderTable({
  head(bal(),11)
})
}


# Run the application 
shinyApp(ui = ui, server = server)

