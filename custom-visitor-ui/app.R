#
# Custom Gitlink UI only for people in my Solutions Engineering group
# conditionalPanel() example
#

library(shiny)
library(gitlink)

# Define UI for application that draws a histogram
ui <- fluidPage(
    tags$head(HTML('<script async defer src="https://buttons.github.io/buttons.js"></script>')),

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            conditionalPanel(condition = "output.isCollab == true",
                             hr(),
                             tags$p(tags$strong('Report a problem:')),
                             tags$a(HTML('<a class="github-button" href="https://github.com/kellobri/mastering-shiny/issues" data-color-scheme="no-preference: light; light: light; dark: light;" data-size="large" data-show-count="true" aria-label="Issue kellobri/mastering-shiny on GitHub">Issue</a>'))
            )
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
    
    #outputOptions(output, "isCollab", suspendWhenHidden = FALSE)
    
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
