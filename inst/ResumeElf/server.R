server <- function(input, output, session) {
    # Sample resume data structure
    resume_data <- list(
        basics = list(
            name = "John Doe",
            label = "Programmer",
            email = "john@gmail.com",
            phone = "(912) 555-4321",
            url = "https://johndoe.com"
        ),
        work = data.frame(
            name = "Company",
            position = "President",
            url = "https://company.com",
            startDate = "2013-01-01",
            endDate = "2014-01-01",
            summary = "Description…",
            highlights = I(list("Started the company"))
        )
    )

    # Update selectInput choices
    updateSelectInput(session, "section_select", choices = names(resume_data))

    output$section_ui <- renderUI({
        # Current section selected by the user
        section <- input$section_select

        # Retrieve the section data
        section_data <- resume_data[[section]]

        # Generate UI elements for the section
        ui_elements <- lapply(names(section_data), function(field) {
            value <- section_data[[field]]

            # Handle different data types here if necessary
            if (is.character(value)) {
                textInput(inputId = paste("input", section, field, sep = "_"),
                          label = field,
                          value = value)
            } else if (is.data.frame(value) || is.list(value)) {
                # Placeholder for complex structures - adjust as needed
                h4(paste("Complex field:", field))
            }
        })

        do.call(tagList, ui_elements)
    })
}
