## Wildfires in Manitoba, Canada
# This projects aims to value the area damaged by fire during the month of May 2025 in the region of Manitoba, Canada.
# The data were taken from Copernicus Browser and later manipulated

# First let's import the libraries that we will need:
library(terra) # For Spatial Analysis
library(imageRy) # To manipulate and share raster images in R
library(viridis) # For color palettes that are visible also for color blind people
library(ggplot2) # To create graphics
library(patchwork) # For coupling graphics

# Let's specify how I installed the package "imageRy" 
devtools:: install_github("ducciorocchini/imageRy")

# Then I set the working directory on R, this is the folder from which R will take all the datas
#setwd("/Users/macbookairair/Downloads/Cartella")?????????????????????????????????????????????????????????????????????????

# Loading the images
# The first images were taken by Sentinel-2 and are in true color
# All the bands were already decided and are disposed in this way:
# First band: R = red
# Second band: G = green
# Third band: B = blue
suppressWarnings({
tc_may4 <- rast("begmay.jpeg")
})
suppressWarnings({
tc_may19 <- rast("endmay.jpeg")
})

# Then I wanted to visualize these images all together so, thanks to the par(mfrow=) function
# I arranged them in one row and three columns
par(mfrow=c(1,2))
plot(tc_may4)
title("May 4", line = -6, cex=2) 
plot(tc_may19)
title("May 19", line = -6, cex=2)  
dev.off() 

# Loading the images
# Other important datasets to import were the "Swir" images
# First band: R = SWIR 
# Second Band: G = NIR
# Third Band: B = red
suppressWarnings({
swir_may4 <- rast("begmay_swir.jpeg")
})
suppressWarnings({
swir_may19 <- rast("endmay_swir.jpeg")
})

# And then again put them together to visualize them alligned
par(mfrow=c(1,2))
plot(swir_may4)
title("May 4", line = -6, cex=2) 
plot(swir_may19)
title("May 19", line = -6, cex=2) 
dev.off()

#Then I created a color palette where the greens rapresent the vegetation and the oranges rapresent the area of fire
# The number 100, instead, rapresent the number of shades that I want for my palette
fire <- colorRampPalette(c("darkolivegreen3", "darkolivegreen", "darkorange1", "darkorange4"))(100)

# Now to have an idea about the damages brought by these wildfires I used the index NBR (Normalized Burn Ratio)
# This index, similarly to the NDVI, is normalized and is given by the band of NIR minus the band of SWIR
# all divided by the addiction of the same two bands.
# SWIR stand for Short-wave infrared and, contrary to NIR, shows an high reflectance of burnt areas and low
# reflectance of healthy vegetation.
# So an high NBR value indicates healthy vegetation, a low one indicates recently burned areas.
#NBR May 4
plot(swir_may4[[2]], col= fire) # Band of NIR
plot(swir_may4[[1]], col= fire) # Band of SWIR
diff.may4 = swir_may4[[2]] - swir_may4[[1]] 
sum.may4 = swir_may4[[1]] + swir_may4[[2]]
NBR_may4 = (diff.may4) / (sum.may4) 
plot(NBR_may4, col = inferno(100))  # Inferno is a color Palette taken from the viridis package

#NBR May 19
plot(swir_may19[[2]], col= fire) # Band of NIR
plot(swir_may19[[1]], col= fire) # Band of SWIR
diff.may19 = swir_may19[[2]] - swir_may19[[1]] 
sum.may19 = swir_may19[[1]] + swir_may19[[2]]
NBR_may19 = (diff.may19) / (sum.may19) 
plot(NBR_may19, col = inferno(100)) 

# Now I create a stacksent, which is an array, and similarly to the par(mfrow=) function
# it alows me to visualize the images together but always with 2 columns and 2 rows
# It's faster than the par and used to overlap different bands to create a satellite image.
stack <- c(NBR_may4, NBR_may19, NBR_june12)
names(stack) <- c("NBR May 4th", "NBR May 19th", "NBR June 12th")
plot(stack, col= inferno(100))

# Let's now calculate the delta NBR, so the difference between the pre-fire and the post-fire
# used to estimate burn severity.
# Our burned area has values that goes from 0.5 to 1.5 which indicates low severity
dNBR = (NBR_may4) - (NBR_may19)
plot(dNBR, col = inferno(100), main="dNBR")

# Since in these images there are some water bodies, I decided to optimize the results aand use another index
# which is the NBR plus (NBR+), that uses also the green and blue band, giving us
# back a less uncertain outcome

#NBR+ May 4
difNBR2_may4= (swir_may4[[2]] - swir_may4[[1]] - tc_may4[[2]] - tc_may4[[3]])
sumNBR2_may4= (swir_may4[[2]] + swir_may4[[1]] + tc_may4[[2]] + tc_may4[[3]])
NBR2_may4= (difNBR2_may4) / (sumNBR2_may4)
plot(NBR2_may4, col=inferno(100))

#NBR+ May 19
difNBR2_may19= (swir_may19[[2]] - swir_may19[[1]] - tc_may19[[2]] - tc_may19[[3]])
sumNBR2_may19= (swir_may19[[2]] + swir_may19[[1]] + tc_may19[[2]] + tc_may19[[3]])
NBR2_may19= (difNBR2_may19) / (sumNBR2_may19)
plot(NBR2_may19, col=inferno(100))

# Once again I calculated the delta
dNBR2 = (NBR2_may4) - (NBR2_may19)
plot(dNBR2, col = inferno(100), main="dNBR+") # And then I plotted it

# Now let's classify these results thanks to the function im.classify from imageRy
# NBR Delta Claffication
class <- im.classify(dNBR, num_clusters = 2)
class.names <- c("Healthy vegetation", "Burned areas")
plot(class, main= "Damaged area's classification", type="classes", levels= class.names, col= fire)

# To quantify the percentages of healthy vegetation and burned area I first obtained the frequencies:
freq <- freq(class)

# Then calculated the total number of pixels
tot <- ncell (class)

# Then did a proportion
prop = freq/tot
      
# To finally obtain the percentages
#Healthy vegetation = 88.7%
#Burned areas = 11.3%
perc = prop*100
perc

# Now let's do the same thing for the NBR+ delta
# Starting with classification
class2 <- im.classify(dNBR2, num_clusters = 2)
class.names <- c("Healthy vegetation", "Burned areas")
plot(class2, main= "Damaged area's classification", type="classes", levels= class.names, col= fire)

# Quantifiyng the pixels
# Frequency:
freq2 <- freq(class2)

# Total number
tot2 <- ncell (class2)

#Proportion
prop2 = freq2/tot2

#Percentages
#Healthy vegetation = 85.7%
#Burned areas= 14.3%
perc2 = prop2*100
perc2

# Let's visualize them together
par(mfrow=c(1,2))
plot(class, main= "Damaged area's classification", type="classes", levels= class.names, col= fire)
plot(class2, main= "Damaged area's classificatiobn", type="classes", levels= class.names, col= fire)

# As we can see from the two images obtained, with the first classification the water bodies were considered
# as part of the burned areas, while with the second one as part of the healthy vegetation.
# Since our interest is to have a better idea of the damages of fire, the second classification is bettter
# because it gives me back the correct amount of pixels for the fire zones.

# Always from Copernicus Browser I imported the NDVI images
# based on (B8-B4)/(B8+B4). This index is used to quantify the state of vegetation.
# I imported images from June of 2017 and 2024 to verify if the vegetation went under any differences
suppressWarnings({
ndvi2017 <- rast("ndvi2017.jpeg")
})
suppressWarnings({
ndvi2024 <- rast("ndvi2024.jpeg")
})

# Let's classify them
# June 2017
class2017 <- im.classify(ndvi2017, num_clusters=3)
class.names <- c("Damaged vegetation", "Healthy vegetation", "Water Bodies")
plot(class2017, main= "Classification 2017", type="classes", levels=class.names, col= c("darkkhaki","darkolivegreen","darkblue"))

# June 2024
class2024 <- im.classify(ndvi2024, num_clusters=3)
class.names <- c("Damaged vegetation", "Healthy vegetation", "Water Bodies")
plot(class2024, main= "Classification 2024", type="classes", levels=class.names, col= c("darkkhaki","darkolivegreen","darkblue"))

# Pixels quantification
# Percentages 2017: 
# Damaged vegetation = 4.9%
# Healthy vegetation = 89.5%
# Water bodies = 5.6%
freq17 <- freq(class2017)
tot17 <- ncell (class2017)
prop17 = freq17/tot17
perc17 = prop17*100
perc17

# Percentages 2024: 
# Damaged vegetation = 15.5%
# Healthy vegetation = 79.1%
# Water bodies = 5.4%
freq24 <- freq(class2024)
tot24 <- ncell (class2024)
prop24 = freq24/tot24
perc24 = prop24*100
perc24

# From these results we can clarluy see a difference in the vegetation's state during time,
# so this is probably one of the reasons why wildfires are becoming more and more frequent and destructive.
