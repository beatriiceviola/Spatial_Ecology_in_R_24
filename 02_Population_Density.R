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


# Now we want to plot multiple graphics or images to visualize them together
# To do so we can use the "par()mfrow=" function
# In it's argument, adding the concatenate function "c()" we will firstly put the number of the rows
# and secondly the number of the columns that we ant

par(mfrow=c(1,2)) # 1 and 2 are elements of the same arrow, so we have one row and two columns

# Now we tell the software what we want to plot

plot(elevation2)
plot(densitymap)

# If I want one above the other I'd have 2 rows and 1 coloumn
 par(mfrow=c(2,1))

# When I want to delete a plot I can use the "dev.off()" function

dev.off()

# To change the colors I can use the "colorRampPalette()" function
# This one alow me to create a custom color palette, so firstly I have to specify the colors that I want
# An then I specify a number that states the gradient
# Since R is a sensitive case software it's important to write this function with the R and the P in capital letters
# And again we're using the concatenate function since we have more elements in the argument

cl <- colorRampPalette(c("red", "orange", "yellow")) (3)

# Now we plot the graphic with the new colors

plot(densitymap, col=cl)

# To increase the smoothness of the plot I can add more gradient
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)

# To find all available colours, one can search in browser for "colors in R" 
# R colors cheat-sheet by Dr. Ying Wei: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Exercise: change the color ramp palette using different colors 

col <- colorRampPalette(c("azure3", "darkorchid", "mediumaquamarine", "salmon"))(100)
plot(densitymap, col=cln)


# Exercise: build a multiframe and plot the densitymapmwith two different color ramp palette
par(mfrow=c(1,2))
cl <- colorRampPalette(c("darkseagreen1", "purple3", "tan1")) (100)
plot(densitymap, col=cl)
cl <- colorRampPalette(c("forestgreen", "sienna1", "red3")) (100)
plot(densitymap, col=cl)

# dev.off() to kill everything
