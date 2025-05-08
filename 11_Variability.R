# Measuring spatial variability 


# The higher the complexity, the higher the potential biodiversity 
# rasterdiv() function to measure variability 
# st. dev. of reflectance values helps in measuring variability over an image, complexity of a landscape

# Let's recall the packages 
library(imageRy) # For image import and manipulation
library(terra) # For raster data processing

# Let's do the list of the images available
im.list()

# We'll use an image from Sentinel
sent <- im.import("sentinel.png")

# Let's plot it without changing the order of the bands
im.plotRGB(sent, r=1, g=2, b=3) # The vegetation reflects the NIR band and it appears red

# bands:
# 1 = NIR
# 2 = red 
# 3 = green 

# Now we can try to change the order to get even more details,
# NIR on green
im.plotRGB(sent, 2,1,3) 


# Let's measure the standard deviation on a self chosen band
# let's associate the first band to an object
nir <- sent[[1]]
cl <- colorRampPalette(c("red","orange","yellow"))(100) # changing the color palette
plot(nir, col=cl) # plotting the image

# To calculate the standard deviation we use the function "focal()" that uses a moving window
# Inside this function we specify:
# The image with the band of interest (in our case the first band)
# Then the matrix, which is an array in 2 dimensions, that is used to create the moving window
# In our case we want a 3x3 pixels moving window 
# Then inside the matrix() function we'll specify:
# 1/9 means that we'll use all of the nine pixels of the window
# then 3 is the number of rows and 3 of the columns
# Finally we state the function that we'll use, in this case standard deviation "sd"
stdev3 <- focal(nir, matrix(1/9, 3,3), fun=sd)
plot(stdev3)

# Now let's install a new package called viridis
# This package allow us to always use colors visible also for color blind people
install.packages("viridis")
library(viridis) 

# We now create a colorRampPalette,
# But we don't need to specify the colors since they are already present in viridis
viridisc <- colorRampPalette(viridis(7))(256) 
#7 is the seventh block which is the one that we're interested in, and that we always need to specify
plot(stdev3, col= viridisc) # Let's plot the standard deviation with these new colors
# Also I can do the same thing without using a colorRampPalette by writing
# plot (stdev3, col=viridis(100)) for example

# Exercise: create a matrix of 7x7 
stdev7 <- focal(nir, matrix(1/49, 7,7), fun=sd) # we have 7 rows and 7 columns, so we have a 49 pixels window
# The bigger the window the bigger the standard deviation (since we're taking a bigger area)

# multiframe to show difference between the variabilities calculated with two differently built windows
par(mfrow=c(1,2))
plot(stdev3)
plot(stdev7)

# alternative using stack to plot two images together
stdevstack <- c(stdev3, stdev7) 
plot(stdevstack)  

# Notes: when we have bigger windows it means that we have a lower resolution
# So how do I know how to choose the dimension of the matrix?
# There's no right or wrong, we just try with different windows and choose the best 
