# Why populations disperse over the landscape in a certain manner?

# Let's install two new packages "terra" and "sdm"
# We're going to need again the install.packages() function
# Recall that when we install new packages that are outside of R we need to use the quotes
# The package sdm is used for species distribution modelling while
# terra is used to manipulate spatial data and to read files
install.packages("sdm") 
install.packages("terra")

# To make sure that they are now installed we use library()
library(sdm)
library(terra) 

# To check file's names inside an R folder we use "system.file()" function
#Specifying the name of the folder, the name of the file and then the package
system.file("external")

# In the external folder I have many dataset but I want one of them called species.shp
system.file("external/species.shp")  # shp is an extension meaning shape file extension 

# Since external is used to be in all folders let's write which package we want the external from:
file <- system.file("external/species.shp", package="sdm")

# Now let's translate the shp file in a type of file R can use in vector
# This function is essential since shp cannot be read by R and it's inside the terra package
vect(file) 

# As always to make thing clearer we assign the function to an object
rana <- vect(file)
rana 

# We obtain a series of info class spatvect, geometry (I could have points, vectors or polygones)
# In the file there's a table: for each point I have data occurance (1)/not occurance (0) for each species
# I know whether in point i, j, n, rana is present or not

# Display the occurence data
rana$Occurrence # always maintain capital letter 
plot(rana) # points representing presence or absence of rana

# We obtaain 0 if the species is absent, 1 if it is present
# 0 means absent and it's an uncertain data, it could be a mistake
# In this case it could happen the data collector misses the species due to a mistake (many reasons possible)

# Let's plot only the points where the species is present
# To do so we use the previoulsy formed link (rana$occurance) as equal (==) to the
# elements that we want to extrapolate (1 since in this occurance 1 means presence)
# To end the input we use ;
pres <- rana[rana$Occurrence==1 ;]

# Exercise: build a multiframe: first image is rana, second image is pres 
par(mfrow=c(1,2))
plot(rana)
plot(pres)

# Exercise: select data from rana with only absences
# Uncertainity is higher for absences due to observer bias (I dont' know if the species is actually
# missing or if it was just not seen)
abs <- rana[rana$Occurrence==0]
plot(abs) 

# Exercise: plot in a multiframe presence beside absences 
par(mfrow=c(1,2))
plot(pres)
plot(abs)

# Exercise: the same but one above the other 
par(mfrow=c(2,1))
plot(pres)
plot(abs)

# Exercise plot presences in blue together with absences in red 
plot(pres, col="blue") # First I open the plot with presence and then 
points(abs, col="red", pch=19, cex=2) # I use points to highlight the absences in blue

# How to import an image as a file from outside R?
# We always use the system.file() function but this time we want the file elevation.asc
# "asc" is a type of file like .jpeg
elev <- system.file("external/elevation.asc", package="sdm") # this time it's not vector file in .shp but a raster file in .asc

# To make it usable to R we won't use vect() but rast()
# rast() function in terra is used to read raster objects
elevmap <- rast(elev)

# Exercise: change colors of the elevamap with the colorRampPalette function
cln<- colorRampPalette(c("purple2", "orange1", "darkmagenta")) (100)
plot(elevmap, col=cln)

# Exercise: plot the presence together with elevetion map
plot(elevmap, col=cln) # First plot the elevation map
points(pres, pch=19) # And then we add the points of the presence
