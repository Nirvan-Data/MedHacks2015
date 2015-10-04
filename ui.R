library(shiny)

shinyUI(pageWithSidebar( #gives page format as page with sidebar
                
                ####################################
                      ### Application title ###
                ####################################
                headerPanel(strong("What's for Dinner?")),
                
                
                ################################
                     ### Side Bar Panel ###
                ################################
                sidebarPanel( 
                        
                        numericInput('numAdultm', 'Adult Male',0),
                        numericInput('numAdultf', 'Adult Female',0),
                        numericInput('numChild', 'Child',0),
                        numericInput('budget','Food Budget ($/wk)',10),
                        checkboxGroupInput('food','food choices: ', c('bread'='bread','rice'= 'rice',
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
                        #conditionalPanel(
                        #  condition="input.==true"
                          #, 
                          #numericInput("myinput", "My Input:", 0)
                        #),
                        submitButton('Enter')
                        ),
                        
                
                ##########################
                    ### Main Panel ###
                ##########################
                mainPanel( 
                        #h3('Main Panel text'),
                        #code('some code'),
                        h3('An app to help you eat healthy while on a budget.'),
                        
                        h3("Recommended Meal Plan"),
                        #h4("You entered..."),
                        #verbatimTextOutput("inputValue"),
                        #verbatimTextOutput("inputValue2"),
                        #verbatimTextOutput("inputValue3"),
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