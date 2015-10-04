library(shiny)

shinyServer(
        function(input,output) {
          ### 
          food <- c("bread", "rice", "pasta", "cereals", "bagels", "apple", "orange",
                    "bananas", "broccoli", "corn", "carrot", "potato", "lettuce",
                    "onion", "tomato", "green.beans", "bologna", "chicken", "pork", 
                    "ground.beef", "tuna", "eggs", "turkey", "canned.beans", "nuts", 
                    "cream.cheese", "tomato.sauce", "cheese", "peanut.butter", "milk")
          
          cost <- c(.5, .13, .85, .70, .33, .33, .29, .1, .39, .16, .17, .19, .83,
                    .6, .22, .44, 1.18, .52, .55, .94, .53, .49, 1.00, .15, 1.97,
                    .88, .19, .77, .39, .09) / 100
          
          ################################################################################
          ### INPUTS FROM USER INTERFACE
          #1) Which foods do you want to include in your list? 
          #*** what does this input look like on my end? checkBoxGroupInput?
          ################################################################################
          
          #example selection from user
          selected <- food
          #selected <- c("bananas", 
          #               "bagels", 
          #               "milk", 
          #               "eggs", 
          #               "cream.cheese", 
          #               "peanut.butter",
          #               "nuts")
          
          L <- length(selected) # number of food items selected
          
          #2) How many adult males, adult females, and children are you shopping for?
          #numericInput

          #example answers from user
          # mfc   <- reactiveValues(ppl = c(input$numAdultm,input$numAdultf,input$numChild))
#           adult.females <- input$numAdultf
#           children      <- input$numChild
          
          selected_indices <- food %in% selected
          selected_food <- food[selected_indices]
          
          ### Nutritional Requirements ###
          adult_male <- c(64, 67, 340, 3018)
          adult_female <- c(44, 50, 253, 2253)
          child <- c(29, 58, 236, 2097)
          
          nutritional_requirements <- 
            as.data.frame(
              rbind(adult_male,
                    adult_female,
                    child)
            )
          
          names(nutritional_requirements) <- c("protein", "fat", "carbohydrates", "calories")
          
          ### Nutritional Data for Food Items ###
          ### Download it and load it into R read.csv
          nutrition0 <- read.csv("nutrition.csv")
          #trim the trialing 70 empty rows
          nutrition  <- nutrition0[1:30,]
          #convert the "name" factor into a character vector
          nutrition$name <- as.character( nutrition$name )
          #remove everything but the nutrient data
          nutrition_numbers <- select(nutrition, protein, fat, carb, kcal)/100
          #assign food item to colnames
          rownames(nutrition_numbers) <- food
          
          A2full <- t(nutrition_numbers)
          
          
          
          
          ################################################################################
          ### Linear Program ###
          ### INPUTS FOR LP ###
          ################################################################################
          
          ### objective function value 
          obj.func <- cost[selected_indices]
          
          ### A2, coefficients for >= constraints
          nutrients <- A2full[,selected_indices] 
          
          ########################################
          ### Restrict the total amount of rice ###
          ### kcal_rice * grams_rice <= 0.4 * Calories
          ########################################
          # kcal_rice <- A2full["kcal","rice"]
          # rice_constraint <- rep(0, L)
          # rice_constraint[2] <- kcal_rice 
          # Amatrix <- rbind( nutrients, rice_constraint) 
          
          ### Restric the Calories from any one item to be at most 30% of the total calories
          ### NEED TO DO A VARIABLE SUBSTITUTION TO ENCAPSULATE THIS CONSTRAINT ###
          # kcal_foodItems <- A2full["kcal",]
          # limit_calories_all_foods_vector <- rep( 0.3 * Calories, 30)
          # limit_calories_all_foods_matrix <- sapply( as.data.frame( diag(L) ), function(x) x * kcal_foodItems )
          # 
          # Amatrix <- rbind( limit_calories_all_foods_matrix, nutrients)
          
          
          Amatrix <- nutrients
          
          ###############################
          ### b2, >= constraints, RHS ###
          ###############################
          
          Protein <- input$numAdultm*nutritional_requirements$protein[1] + 
            input$numAdultf*nutritional_requirements$protein[2] +
            input$numChild*nutritional_requirements$protein[3]
          
          Fat <- input$numAdultm*nutritional_requirements$fat[1] +
            input$numAdultf*nutritional_requirements$fat[2] +
            input$numChild*nutritional_requirements$fat[3]
          
          Carbohydrates <- input$numAdultm*nutritional_requirements$carbohydrates[1] +
            input$numAdultf*nutritional_requirements$carbohydrates[2] +
            input$numChild*nutritional_requirements$carbohydrates[3]
          
          Calories <- input$numAdultm*nutritional_requirements$calories[1] +
            input$numAdultf*nutritional_requirements$calories[2] +
            input$numChild*nutritional_requirements$calories[3]
          
          ####################################################
          min_req <- as.vector( c(Protein, Fat, Carbohydrates, Calories) ) 
          
          #Limit Rice calories to at most 20%
          #bvector <- c( min_req, 0.2 * Calories) 
          
          #Limit calories from all food items to at most 30% of the total calories
          #bvector <- c(min_req, limit_calories_all_foods_vector)
          
          bvector <- min_req
          
          ### const.dir
          inequality_directions <- c( rep( ">=", length( min_req ) ) )
          ####################################################
          
          library(linprog)
          LP <- solveLP( cvec = obj.func, bvec = bvector, Amat = nutrients, 
                         const.dir = inequality_directions ) 
          
          
          ############################################################################################
          ### OUTPUT ###               
          ############################################################################################
          LP$opt
          LP$solution
          ############################################################################################
          
          
          
          
          
          
          
          
          ### Convertin grams output to # of units to purchase ##
          ### unfinished

          ### Output total cost of weekly groceries
          ### price.per.g * g recommended (at selected_indices)
          
          ### Recode Output of Lin Prog
          #1) Convert grams back to original units (* by )
          #2) Convert original units into # of items to purchase and round UP/DOWN?
          #       -divide numeric amount of units by numeric amount of one item --># of items
          #       -then round 
          
          cost.units <-
            read.csv("Top-Food-Items-Cost-and-Nutritional-Facts-Cost-of-Food-Items-raw.csv")
          
          class(cost.units)
          names(cost.units)
          
          
          library(dplyr)
          outputConv <- select(cost.units, 
                               Food.Item, 
                               Price.per.g, 
                               Quantity, 
                               Unit, 
                               Conversion.to.g)
          
          head(outputConv)
          
          
          
          outputConv$Price.per.g      
          ### !!! if you update and load the updated dataset, this will be disasterous
          ### outputConv <- mutate( outputConv, Price.per.g = Price.per.g/100)
          
          #1) Cost per original unit
          #with(outputConv, Price.per.g * Conversion.to.g)
          
          LP$solution / outputConv$Conversion.to.g  



                #output$inputValue <- renderPrint({input$sizeFamily})
                #output$inputValue2 <- renderPrint(2*{input$numChild})
                output$inputValue3 <- renderPrint({input$food})

          output$prediction <- renderText('beep')
                # output$prediction <- renderPrint(cat('Heehee\nhe'))

        }
)