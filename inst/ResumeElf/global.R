require(shiny)


# App functions ======

generateUI <- function(data, idPrefix = "") {
    uiElements <- lapply(names(data), function(name) {
        item <- data[[name]]

        # Generate an ID for the UI element
        elementId <- paste(idPrefix, name, sep = "_")

        if (is.data.frame(item) || is.list(item) && !all(sapply(item, is.atomic))) {
            # Recursive case: item is a list or data frame with more complex structures
            nestedUI <- lapply(seq_along(item), function(i) {
                generateUI(item[i], paste(elementId, i, sep = "_"))
            })
            return(do.call(tagList, nestedUI))
        } else {
            # Base case: item is simple or a flat list/vector
            if (is.character(item)) {
                return(textInput(inputId = elementId, label = name, value = item))
            } else if (is.list(item) && all(sapply(item, is.atomic))) {
                # Handle flat lists (e.g., keywords)
                value <- paste(unlist(item), collapse = ", ")
                return(textInput(inputId = elementId, label = name, value = value))
            }
        }
    })
    do.call(tagList, uiElements)
}

