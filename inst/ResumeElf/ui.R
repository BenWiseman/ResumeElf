ui <- fluidPage(
    titlePanel("Resume Editor"),
    sidebarLayout(
        sidebarPanel(
            selectInput("section_select", "Select Section", choices = NULL)  # To be updated in server
        ),
        mainPanel(
            uiOutput("section_ui")
        )
    )
)
