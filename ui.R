library(shiny)

shinyUI(pageWithSidebar( #gives page format as page with sidebar
                      ### Application title ###
                headerPanel(strong("What's for Dinner?")),
                
                     ### Side Bar Panel ###
                sidebarPanel( 
                        
                        numericInput('numAdultm', 'Adult Male',0),
                        numericInput('numAdultf', 'Adult Female',0),
                        numericInput('numChild', 'Child',0),
                        numericInput('budget','Food Budget ($/wk)',40),
                        checkboxGroupInput('food','food choices (choose 2): ', c('bread'='bread','rice'= 'rice',
                                                                      'pasta'='pasta','cereals'='cereals',
                                                                      'bagels'='bagels','apple'='apple',
                                                                      'orange'='orange','banana'='banana',
                                                                      'broccoli'='broccoli','corn'='corn',
                                                                      'carrot'='carrot','potato'='potato',
                                                                      'lettuce'='lettuce','onion'='onion',
                                                                      'tomato'='tomato','green beans'='green beans',
                                                                      'bologna'='bologna','chicken'='chicken',
                                                                      'pork'='pork','ground beef'='ground beef',
                                                                      'tuna'='tuna','egg'='egg','turkey'='turkey',
                                                                      'canned beans'='canned beans','nuts'='nuts',
                                                                      'cream cheese'='cream cheese','tomato sauce'='tomato sauce',
                                                                      'cheese'='cheese','peanut butter'='peanut butter',
                                                                      'milk'='milk')
                        ), 
                        actionButton('action','Enter')
                        ),
                        
                
                    ### Main Panel ###
                mainPanel( 
                        #h3('Mai                                                                                                                                                                                                 n Panel text'),
                        #code('some code'),
                        h2('An app to help you eat healthy while on a budget!'),
                        h4('Here\'s what you picked:'),
                        verbatimTextOutput("inputValue3"),
                        h3("Recommended Meal Plan:"),
                        #h4("You entered..."),
                        #verbatimTextOutput("inputValue"),
                        #verbatimTextOutput("inputValue2"),
                        
                        #h4("Which resulted in a prediction of "),
                        verbatimTextOutput("prediction")
                        #verbatimTextOutput("prediction2")

#                         h4('You Entered...'),
#                         verbatimTextOutput("oid2"),
#                         h4('You Entered...'),
#                         verbatimTextOutput("odate")
                        
                )                
                                
                )
                
                
                
        )