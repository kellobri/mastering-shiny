#

library(shiny)

# A knowledgeable attacker can open up a JavaScript console in their browser 
# and run Shiny.setInputValue("x", "c") to see my SSN.
# To be safe, you need to check all user inputs from your R code:
# https://mastering-shiny.org/scaling-security.html#data

secrets <- list(
    a = "my name",
    b = "my birthday",
    c = "my social security number", 
    d = "my credit card"
)

allowed <- c("a", "b")
ui <- fluidPage(
    selectInput("x", "x", choices = allowed),
    textOutput("secret")
)
server <- function(input, output, session) {
    output$secret <- renderText({
        secrets[[input$x]]
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
