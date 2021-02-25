#
#

library(shiny)
library(gitlink)

ui <- fluidPage(
    ribbon_css("https://github.com/kellobri/mastering-shiny", text = "Link to the code"),
    tags$head(HTML('<script async defer src="https://buttons.github.io/buttons.js"></script>')),
    
    titlePanel("Auto-Bookmarking (URL) Example"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("omega", "omega", value = 1, min = -2, max = 2, step = 0.01),
            sliderInput("delta", "delta", value = 1, min = 0, max = 2, step = 0.01),
            sliderInput("damping", "damping", value = 1, min = 0.9, max = 1, step = 0.001),
            numericInput("length", "length", value = 100),
            hr(),
            tags$p(tags$strong('Report a problem:')),
            tags$a(HTML('<a class="github-button" href="https://github.com/kellobri/mastering-shiny/issues" data-color-scheme="no-preference: light; light: light; dark: light;" data-size="large" data-show-count="true" aria-label="Issue kellobri/mastering-shiny on GitHub">Issue</a>'))
        ),
        mainPanel(
            plotOutput("fig"),
            hr(),
            tags$a(href="https://mastering-shiny.org/action-bookmark.html", "Code Example from Mastering Shiny, Hadley Wickham"),
            p('The code samples in this book are licensed under Creative Commons CC0 1.0 Universal (CC0 1.0), 
              i.e. public domain.')
        )
    )
)
server <- function(input, output, session) {
    t <- reactive(seq(0, input$length, length.out = input$length * 100))
    x <- reactive(sin(input$omega * t() + input$delta) * input$damping ^ t())
    y <- reactive(sin(t()) * input$damping ^ t())
    
    output$fig <- renderPlot({
        plot(x(), y(), axes = FALSE, xlab = "", ylab = "", type = "l", lwd = 2)
    }, res = 96)
    
    # Automatically bookmark every time an input changes
    observe({
        reactiveValuesToList(input)
        session$doBookmark()
    })
    # Update the query string
    onBookmarked(updateQueryString)
}

# Run the application 
shinyApp(ui = ui, server = server, enableBookmarking = "url")
