#Importing data from external sources 

# First let's recall the packages
library(terra)

# Now download an image from Nasa Earth Observatory, save it in your folder

# Now let's explain to the system in which folder of my PC it has to extract the data that I want to use
# setwd means "set working directory"
# The argument of this function, that has to be always between the quotes since we get out of R,
# is the path of the folder
setwd("/Users/macbookairair/Downloads/Cartella")
# The path to the folder will depend on the OS of your computer
# Note that in windows, the path you get from windows explorer has opposite slashes that you need to change


# In the package terra there is the function rast() that allow us to import data
emi1 <- rast("1.jpg")

# Now let's do a RGB plot assigning r, g and b according your image bands
plotRGB(emi1, r=1, g=2, b=3) # Let's use the natural colors

# Exercise: Download a second image from the same site and import it in R
# After downloading the file, load the file using "rast" function
emi2 <- rast("2.jpg")
plotRGB(emi2, r=1, g=2, b=3) # RGB plot in natural colors

# Create a multi-frame plot to compare the two images
par(mfrow=c(2,1)) # 2 rows and 1 column
plotRGB(emi1, r=1, g=2, b=3) # First image
plotRGB(emi2, r=1, g=2, b=3) # Second image

# Exercise: Multitemporal change detection
emidif = emi1[[1]] - emi2[[1]] # Calculate the difference between the 2 images on the first band
cl <- colorRampPalette(c("lightgreen", "darkmagenta", "orange")) (100) # Create a new color palette for plotting the difference
plot(emidif, col=cl) # Plot the difference with the new color palette

# The Mato Grosso image can be downloaded directly from the NASA Earth Observatory website
mato <- rast("matogrosso_l5_1992219_lrg.jpg") # Load the image
# Plot the different RGB band combinations
plotRGB(mato, r=1, g=2, b=3) 
plotRGB(mato, r=2, g=1, b=3) 
