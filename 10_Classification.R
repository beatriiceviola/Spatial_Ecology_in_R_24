# Classification process in R using imageRy

# In remote sensing pixel classification alows me to classify image pixels into groups, based on their reflectance
# This is very important to identify geographical features such as water bodies, vegetation, snow...

# For example: if I have 3 pixels that are stricly related to each other beacause of their similar reflectance 
# then the distance between these 3 pixels belonging to the same class is shorter than the distance from 
# a pixel with a very different reflectance value
# This is called classification of landcover classes
# When we've finished with the classification we will calculate how many pixels belong to one class
# and how many to the other classes
 
# Let's import the required libraries
library(terra) 
library(imageRy)
library(ggplot2)

# Let's make a list with the available images
im.list() 

# From the dataset we select an image of the sun from the satellite Solar Orbiter
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# To classify an object we use the "im.classify()" function from imgeRy
# The first object of the function is the name of the image that I want to classify
# The second object is the number of classes that i want for this image
# Since some pixels are not immediatly attributable to one class or another
# It could happen that replotting the function again the result image will change a bit

# In this image of the sun, just with our own eyes, we can detect at least 3 classes, high energy, low energy and medium energy
im.classify(sun, num_clusters=3) 
#the algorithm decides when to start the operation, so the first class could be "medium energy" for example

# Let's classify Mato grosso to quantify the changes in terms of cover % of forest in 1992 and 2006
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #1992
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") #2006

# 2 clusters represent forest and not forest
m1992c <- im.classify(m1992,num_clusters=2) 

# Since the clusters that are obtain are random, I'll write down which class correspond to what 
# Class 1 = human releted areas + water 
# Class 2 = forest

# We also divde the image from 2006 in 2 clusters
m2006c <- im.classify(m2006,num_clusters=2) 

# For example in this case the clusters are inverted compared to before
# Class 1 = forest
# Class 2 = human related areas + water 

# Now we calculate the frequency of forest and of human related areas
# With this function I can calculate how many pixels I have for one class and how many for the other
f1992 <- freq(m1992c)
f1992 # By recalling the object I'll obtain the number of pixels for the two clusters

# Then we can calculate the proportion
# To do so we'll need the total number of pixel of the image and we obtain it thanks to the function ncell()
# Total of pixels in the image of Mato Grosso 1992
tot1992 <- ncell(m1992c)
tot1992
# tot = 180000 pixels

# Now that I have the total number I can obtain the proportion by dividing the frequencies by the total number of pixels
prop1992 = f1992/tot1992
prop1992 # The column "count" is the one that we're intrested in

# Then I can also obtain the percentages by multiplying the proportions for 100
perc1992 = prop1992 * 100
perc1992
# class 1 = human related areas + water = 17% cover
# class 2 = forest = 83% cover

# Let's do the same thing for 2006:
# Frequencies
f2006 <- freq(m2006c)
f2006

# Total amount
tot2006 <- ncell(m2006c)
tot2006
# tot = 7200000 pixels

# Proportion:
prop2006 = f2006/tot2006
prop2006

# Percentages
perc2006 = prop2006 * 100
perc2006
# class 1 = forest = 45%
# class 2 = human related areas + water = 55%

# Now let's build a dataframe with 3 columns to be clumped together
# In particular we will create three arrays, each of them will become one of the columns of the dataframe
class <- c("Forest", "Human related areas") # The first column rapresents the classes
y1992 <- c(83, 17) # The second one is the percentage values from 1992 for each class
y2006 <- c(45, 55) # The third one are the percentage values from 2006 for each class

# Now we create the proper dataframe with the function "data.frame()"
# Inside this function we'll specify the three arrays just created
tabout <- data.frame(class, y1992, y2006) 
tabout # If we recall it we will see the dataframe

# To finish we'll create a graphic thanks to the package ggplot2
# Starting from the image of 1992
# The first object of the function "ggplot()" is the name of the dataframe, in our case "tabout"
# The second objects are the aestetiics, so  what is axis x (classes),
# and what is axis y (percentage values of 1992) and the color 
# Then we state which type of graphic we want by using + and geom_bar() function
# inside the function "geom_bar" we put: stat="identity" that means that it takes the exact value 
# while fill="" to fill it with a specified color 
#1992
ggplot (tabout, aes(x=class, y=y1992, color=class))+ geom_bar(stat="identity", fill="white")
#2006
ggplot (tabout, aes(x=class, y=y2006, color=class))+ geom_bar(stat="identity", fill="white")

# It's a quantitative graphic!

# To glue two graphics together in a single image
# We'll need "patchwork" package 
install.packages("patchwork")
library(patchwork)

# Now I assign each one of the graphics just created to an object
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2 # By adding the two objects I'll see them one next to the other
# If I want to have them one above the other I'll write p1/p2

# There's a graphical error to change: the scale is different between the two
# To correct it  we add another element to the array: ylim()
# Inside it's argument I'll put the first number and the last one of the y axis 
# Since we are using percentages we will start from 0 and end to 100
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2 # Now I can clearly value the loss of forest in this area
