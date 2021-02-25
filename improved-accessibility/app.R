#
# Shiny 1.6 Improved Accessibility
# Feature test (Blog examples)
#

library(shiny)

ui <- fluidPage(
    titlePanel("Reactive Alt Text Example"),
    
    sidebarPanel(
        sliderInput("obs", "Number of observations:", min = 1, max = 1000, value = 500)
    ),
    
    mainPanel(plotOutput("plot"))
)

server <- function(input, output, session) {
    vals <- reactive(rnorm(input$obs))
    # A textual description of the histogram of values. Also checkout the BrailleR 
    # package to easily generate description(s) of common statistical objects
    # https://github.com/ajrgodfrey/BrailleR
    alt_text <- reactive({
        bins <- hist(vals(), plot = FALSE)
        bin_info <- glue::glue_data(bins, "{round(100*density, 1)}% falling around {mids}")
        paste(
            "A histogram of", input$obs, "random values with ",
            paste(bin_info, collapse = "; ")
        )
    })
    output$plot <- renderPlot({
        hist(vals())
    }, alt = alt_text)
}

shinyApp(ui, server)
