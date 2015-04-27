library(shiny)
# Define UI for Kruskal Test Demo
shinyUI(fluidPage(
    # Application title
  titlePanel("Krusal Test Demo for Airquality Data"),
    # Sidebar with controls to select the factor variable
  #  and the numeric variable
  sidebarLayout(
    sidebarPanel(
      selectInput("factvariable", "Factor Variable:",
                  c("Month of Year" = "Month",
                    "Day of Month" = "Day")),
      selectInput("numbvariable", "Numeric Variable:",
                  c("Solar Radiation - Langley" = "Solar.R",
                    "Avg Wind Speed - MPH"  =  "Wind", 
                    "Ozone Level - PPB"= "Ozone",
                    "Temperature - F" = "Temp")),
  
      checkboxInput("outliers", "Show outliers", FALSE)
    ),
    
	 # Three tabs show:
   # (1) Boxplot of the data by user choice of factor variable and numeric variable.
   # (2) The Result of the kruskal test test of difference in distribution.
	 # (3) The data table.

	 mainPanel(
	   tabsetPanel(type = "tabs", 
	               tabPanel(h4("Box Plot"), plotOutput("ktplot"),h4("Kruskal Wallis is a non-parametric test for difference in distribution, the boxplot chart visualizes it.")), 
	               tabPanel(h4("Kruskal Test"), verbatimTextOutput("ktresult"),
                    h4("Note p-values around .05 or less indicate one or more groups have different distributions.")), 
	               tabPanel(h4("Table"), h5("Source of airquality data is the R Stat Package. The data was collected to study environmental conditions affecting harmful ozone levels. 
                                          This Shiny project allows the user to study other variables in the data."), tableOutput("table"))
	   )
	 ))
))