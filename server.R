library(shiny)
library(datasets)
data(airquality)

# User must select the factor variable and the numeric variable.
# The barplot visualizes data distributions for different levels of the factor variable
# The program runs a kruskal test to determine if distributions of the levels
# Are likely to be different.
# application
ktdata <- airquality
# Next line replaces 5 - 9 with names of months for user convenience.
ktdata$Month <- factor(ktdata$Month, labels = c("May","June","July","Aug","Sept"))


# Define server logic required to plot various variables
#
shinyServer(function(input, output) {
  
  # Following lines compute the formula text in a reactive expression since 
  # it is shared by the output$caption and output$ktplot functions
  formulaText <- reactive({
    paste(input$numbvariable,"~", input$factvariable)
  })
   
    
  # Generate a plot of the requested numeric variable with factor variable and
  # only include outliers if requested
  output$ktplot <- renderPlot({
    boxplot(as.formula(formulaText()),
       data = ktdata, main = "Kruskal Test Visualization for Airquality Data",
            xlab = input$factvariable,ylab = input$numbvariable,outline = input$outliers)
  
  })
  # generate output of the kruskal test
  output$ktresult <- renderPrint({
   kruskal.test(as.formula(formulaText()), 
       data = ktdata)
})
  # output of the data as a table
output$table <- renderTable({
  as.data.frame(ktdata)

})
})