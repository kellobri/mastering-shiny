#
# Custom Gitlink UI only for people in my Solutions Engineering group
# conditionalPanel() example
#

library(shiny)
library(gitlink)

# Define UI for application that draws a histogram
ui <- fluidPage(
    conditionalPanel(condition = "output.isCollab == true",
                     ribbon_css("https://github.com/kellobri/mastering-shiny", text = "Link to the code")),

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    groups <- reactive({
        session$groups
    })
    
    # Determine whether or not the user is a solutions engineer.
    isCollab <- reactive({
        if ('Solutions Engineer' %in% groups()){
            return(TRUE)
        } else{
            return(FALSE)
        }
    })
    
    outputOptions(output, "isCollab", suspendWhenHidden = FALSE)
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
