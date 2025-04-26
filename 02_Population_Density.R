# Code related to population ecology

# Let's install new packages in R
# To do so we use the function "install.packages("name of the package")"
# Since we're importing external data in R it's mandatory to quote the name of the package

# The first package that we're going to install is spatstat
# Spatstat is used for point pattern analysis

install.packages("spatstat") 

# To verify that the package has been installed we use the function "library()"
# To use this function the quotes won't be needed since the package has already been installed

library(spatstat)

# Now we will use the dataset bei, which is inside spatstat
# The dataset bei represent spatial point pattern data

bei

# Let's plot this dataset
# This plot is generated to visualize the spatial distribution of points
# All the points rapresent monitored trees in the Amazon rainforest

plot(bei) 

# Let's change the graphic since the points are too big
# To do so, as we've already seen, we use the functions "pch" and "cex"

plot(bei, pch=19, cex=0.2)

# Now we can explore additional dataset
# We use the "bei.extra" dataset, it gives us a list of pixel images (raster type)
bei.extra 
plot(bei.extra)

# We are gonna need just one the two elements of the dataset (elevation and gradient)
# Let's use only a part of the dataset: elevation
# The symbol $ links elevation to the dataset
bei.extra$elev

# Now we create a new object called elevation and we plot it
elevation <- bei.extra$elev
plot(elevation)

# Also instead of using the symbol $ I can also use [[1]] to select elements
# In this way R will select the first element of the dataset, which is elevation in this case
# We assign it to a new object and we plot it

elevation2 <- bei.extra[[1]]
plot(elevation2)  # [[]] is more powerful because I dont'have to remember the name of the element I need

# Now we want to create a density map, but how do we let R calculting the plots as a continuous image?
# By considering each group of dots as a single unit,
# where each unit is going to be more or less dense according to the number of dots present in that area.???????????????????'

# Now let's see other functions
# We need to pass from point to a continuous surface
# First of all we use the "density" function inside spatstat to create a density map and we rename it
density(bei) 
densitymap <- density(bei) # from points we are now dealing with pixels

# Now if we plot this new object we obtain the density of trees over the area
plot(densitymap) # blue is low density while yellow is high density


# Is there a possibility to show togheter the map of density and the original points?
# Yes, we can use the "points()" function
# This function allow us to add a plot to the current one without erasing this last
points(bei) # puts points on prevoius graphic (densitymap)
points(bei, col="green")

#?? da qui mancaaaaaa
# multiframe with par.function

par(mfrow=c(1,2)) # 1 and 2 are elements of the same arrow 

#now put sets in the elements

plot(elevation2)
plot(densitymap)
# the order is set like this sx elev2 a dx density
# if i want one above the other i'd have 2 rows and 1 coloumn
 par(mfrow=c(2,1))

#if i want again just one map at the centre of the screen and not above or at a side
# i use dev.off() control multiple devides. destroys the device null device

dev.off()

#changing colours to map
cl <- colorRampPalette(c("red", "orange", "yellow")) (3)
# watch out capital letters 
# elements of the same arrow so use c()
# stating (3) is for gradients but the gradients are written like taht in brakets
# assign it to an obj
plot(densitymap, col=cl)

# let's increase the amount of gradients 
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)

# exercise: change teh color ramp palette using different colors 
# search colors in R Columbia university for gradients

# exercise: build a multiframe and plot the densitymapwith two different color ramp palette
par(mfrow=c(1,2))
cl <- colorRampPalette(c("palegreen", "purple3", "orange3")) (100)
plot(densitymap, col=cl)
cl <- colorRampPalette(c("olivedrab2", "orange1", "red3")) (100)
plot(densitymap, col=cl)

# dev.off() to kill everything
