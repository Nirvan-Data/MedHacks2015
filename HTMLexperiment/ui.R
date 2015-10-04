shinyUI(bootstrapPage(
  div(
    div(
      # You can use a string value as HTML by wrapping it with the HTML 
      # function. If you didn't do that, then the string would be treated as 
      # plain text and the HTML tags would be escaped. See ?HTML.
      HTML("Here is <strong>one</strong> way to insert <em>arbitrary</em> HTML.")
    ),
    
    div(
      # Another way is to use the builder functions; see ?tags.
      "Here is",
      tags$span(      # Creates an HTML span.
        class="foo",  # Any named args become attributes.
        
        tags$strong("another"),  # Unnamed args become children of the tag.
        "way"
      ),
      "to do it."
    ),
    
    # The third way is to include a separate HTML file.
    includeHTML("static.html")
  )
))
