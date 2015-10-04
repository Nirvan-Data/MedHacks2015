library(shiny)

shinyServer(
        function(input,output) {

                #output$inputValue <- renderPrint({input$sizeFamily})
                #output$inputValue2 <- renderPrint(2*{input$numChild})
                #output$inputValue3 <- renderPrint({input$food})
                output$prediction <- renderPrint(cat('Heehee\nhe'))
                #output$prediction2 <- renderPrint('Heehee2')
                #output$oid2 <- renderPrint({input$id2})
                #output$odate <- renderPrint({input$date})
        }
)