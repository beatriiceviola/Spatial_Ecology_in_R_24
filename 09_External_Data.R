#Importing data from external sources da finire di correggere

# First let's recall the packages
library(terra)

# Now download an image from Nasa Earth Observatory, save it in your folder

# Now let's explain to the system in which folder of my PC it has to extract the data that I want to use
# setwd means "set working directory"
# The argument of this function, that has to be always between the quotes since we get out of R,
# is the path of the folder
setwd("/Users/macbookairair/Downloads/Cartella 1/1.png")
getwd()

# In the package terra there is the function rast() that allow us to import data
scotland <- rast("scotland_outerhebrides_oli_20240918_lrg.jpg")
plotRGB(scotland, r=1, g=2, b=3) # Let's use the natural colors

# alternative function to plot for library terra
plot(scotland)


# Exercise: dowload an image from Earth Observatory and upload it in R
Patagonian_Shelf_Waters_Abloom <- rast("bloom_pace_20241130_lrg.jpg")
plot(Patagonian_Shelf_Waters_Abloom)


# for Windows users: 
# working directory works with / not \
# you should add manually the extension of the image (eg: .jpg)
