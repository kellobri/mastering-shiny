library(shiny)

# Initialize Bootstrap 4 with Bootstrap 3 compatibility shim
theme <- bs_theme(version = 4, bg = "black", fg = "white")

ui <- fluidPage(
    theme = theme,
    h1("Heading 1"),
    h2("Heading 2"),
    p(
        "Paragraph text;",
        tags$a(href = "https://www.rstudio.com", "a link")
    ),
    p(
        actionButton("cancel", "Cancel"),
        actionButton("continue", "Continue", class = "btn-primary")
    ),
    tabsetPanel(
        tabPanel("First tab",
                 "The contents of the first tab"
        ),
        tabPanel("Second tab",
                 "The contents of the second tab"
        )
    )
)

if (interactive()) {
    run_with_themer(shinyApp(ui, function(input, output) {}))
}