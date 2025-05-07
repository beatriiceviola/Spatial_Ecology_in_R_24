# Under the hashtag the software R will not detect the code. So this is how we can comment our script

# Exercise
# We will use R as a simple calculator
2 + 3 

# Now we can assign our value to an object by adding the symbol <-
# In this way we create a new variable with an assigned value
cato <- 2 + 3 
cato # By plotting "cato" we will diretcly have the result 5

# Let's do another example
beatrice <- 4 + 2
beatrice 

# Now we can do many more operations by using our new variables
cato + beatrice
cato ^ beatrice
(cato + beatrice) ^ cato 


# Arrays or vectors: a series of info coded all together
# We concatenate all the data by using the "c" function
# In this way we can create an array, the objects inside are all called arguments
luca <- c(10, 20, 30, 40, 50) 
luca # Let's run the code

# Now let's add some data
# This is going to be our second variable
sofia <- c(100, 200, 300, 400, 500)

# Now we can correlate the two variables by creating a plot
# To create a plot we use the "plot" function
# Eg. reationship between amount of CO2 and fruits
plot(sofia, luca) # By plotting these two variables together we observe a direct correlation between them

# Now I can make my plot look better by changing the symbols in it
# To modify the symbols we use "pch=" in the plot's argument
# To know which one I want to use I can google "symbols in R" 
# or I can check the site https://www.datanovia.com/en/blog/pch-in-r-best-tips/
plot(sofia, luca, pch=19) 

# Another change that we can make is the dimension of our symbol
# To do so we use "cex=" in the argument of the plot
plot(sofia, luca, pch=19, cex=2) # In this way we make the fots bigger 
plot(sofia, luca, pch=19, cex=0.5) # In this way we make them smaller

# Then we can modify the color by using "col=" in the argument
# To choose which color we either google "colors in R"
# or check this link https://r-graph-gallery.com/42-colors-names.html
plot(sofia, luca, pch=19, cex=2, col="blue") 

# One last change that I can m,ake is to add the labels in the plot
# To do so we use "xlab=" to add a label to the x axis and "ylab=" to add a label in the y axis
plot(sofia, luca, pch=19, cex=2, col="blue", xlab="C02", ylab="amount of fruits") 
