# MedHacks2015
MedHacks 1.0 Project


### Overall scope of project ###
User Inputs:
Family composition and desired food/grocery items. 

Output:
Create a low cost, healthy grocery plan for the week 

### Files and Explanation ###
1) server.R 
contains the optimization code

2) ui.r
contains code to design user interface for user inputs 

3) fooddata.py
Imports food data from government database (USDA)
http://ndb.nal.usda.gov/ndb/foods


### Details of Algorithm ###
Linear program (simplex method) is used.

1) Males, Females, and children each have recommended daily values of macronutrients (fat, protein, carbohydrates)
2) Every food item (e.g rice or chicken) contributes a certain number of grams of protein, fat, and carbohydrates per unit of the item.  
3) Cost/unit of each food item is known

The optimization algorithm minimizes the cost of feeding a user-specified family structure with user specified types of foods while meeting minimum macro-nutrional requirements.

Software Components:
Backend optimization is done in R. Front-end web application is built using R Shiny.
1) server.R 
contains the optimization code

2) ui.r
contains code to design user interface for user inputs 
