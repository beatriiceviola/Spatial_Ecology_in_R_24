## Wildfires in Manitoba, Canada
# This projects aims to value the area damaged by fire during the month of May in 2025 in the region of Manitoba, Canada.
# The data were taken from Copernicus Browser 

# First let's import the libraries that we will need:
library(terra) # For Spatial Analysis
library(imageRy) # To manipulate and share raster images in R
library(viridis) # For color palettes that are visible also for color blin people
library(ggplot2) # To create graphics
library(patchwork) # For coupling graphics

# Let's specify how I installed the package "imageRy"
devtools:: install_github("ducciorocchini/imageRy")

# Then I set the working directory on R, this is the folder from which R will take all the datas
setwd("/Users/macbookairair/Downloads/Cartella")

# Loading the images
# The first images were taken by Sentinel-2 and are in true color
# All the bands were already decided by decided and are disposed in this way:
# First band: R = red
# Second band: G = green
# Third band: B = blue
suppressWarnings({
tc_may4 <- rast("begmay.jpeg")
})
suppressWarnings({
tc_may19 <- rast("endmay.jpeg")
})
suppressWarnings({
tc_june12 <- rast("june.jpeg")
})

# Then I wanted to visualize these images all together so, thanks to the par(mfrow=) function
# I arranged them in one row and three columns
par(mfrow=c(1,3))
plot(tc_may4)
title("May 4", line = -6, cex=2) 
plot(tc_may19)
title("May 19", line = -6, cex=2) 
plot(tc_june12)
title("June 12", line = -6, cex=2) 
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
suppressWarnings({
swir_june12 <- rast("june_swir.jpeg")
})

# And then again put them together to visualize them alligned
par(mfrow=c(1,3))
plot(swir_may4)
title("May 4", line = -6, cex=2) 
plot(swir_may19)
title("May 19", line = -6, cex=2) 
plot(swir_june12)
title("June 12", line = -6, cex=2) 
dev.off()

fire <- colorRampPalette(c("darkolivegreen3", "darkolivegreen", "darkorange1", "darkorange4"))(100)

#NBR May 4
plot(swir_may4[[2]], col= fire)
plot(swir_may4[[1]], col= fire)
diff.may4 = swir_may4[[2]] - swir_may4[[1]] 
plot(diff.may4, col = viridis(100))
sum.may4 = swir_may4[[1]] + swir_may4[[2]]
plot(sum.may4, col = viridis(100))
NBR_may4 = (diff.may4) / (sum.may4) 
plot(NBR_may4, col = viridis(100)) 

#NBR May 19
plot(swir_may19[[2]], col= fire)
plot(swir_may19[[1]], col= fire)
diff.may19 = swir_may19[[2]] - swir_may19[[1]] 
plot(diff.may19, col = viridis(100))
sum.may19 = swir_may19[[1]] + swir_may19[[2]]
plot(sum.may19, col = viridis(100))
NBR_may19 = (diff.may19) / (sum.may19) 
plot(NBR_may19, col = viridis(100)) 

#NBR June 12
plot(swir_june12[[2]], col= fire)
plot(swir_june12[[1]], col= fire)
diff.june12 = swir_june12[[2]] - swir_june12[[1]] 
plot(diff.june12, col = viridis(100))
sum.june12 = swir_june12[[1]] + swir_june12[[2]]
plot(sum.june12, col = viridis(100))
NBR_june12 = (diff.june12) / (sum.june12) 
plot(NBR_june12, col = viridis(100)) 

#Stacksent
stack <- c(NBR_may4, NBR_may19, NBR_june12)
names(stack) <- c("NBR May 4th", "NBR May 19th", "NBR June 12th")
plot(stack, col= inferno(100))

#delta
dNBR = (NBR_may4) - (NBR_may19)
plot(dNBR, col = fire, main="dNBR")

# classificazione su tutta l'immagine forse da togliere
class <- im.classify(swir_may19, num_clusters = 4)
plot(class, col= c("blue","darkolivegreen","darkorange2","darkolivegreen2"))

#NBR+ May 4
par(mfrow = c(1,3))
difNBR2_may4= (swir_may4[[2]] - swir_may4[[1]] - tc_may4[[2]] - tc_may4[[3]])
plot(difNBR2_may4, col=inferno(100))
sumNBR2_may4= (swir_may4[[2]] + swir_may4[[1]] + tc_may4[[2]] + tc_may4[[3]])
plot(sumNBR2_may4, col=inferno(100))
NBR2_may4= (difNBR2_may4) / (sumNBR2_may4)
plot(NBR2_may4, col=inferno(100))

#NBR+ May 19
par(mfrow = c(1,3))
difNBR2_may19= (swir_may19[[2]] - swir_may19[[1]] - tc_may19[[2]] - tc_may19[[3]])
plot(difNBR2_may19, col=inferno(100))
sumNBR2_may19= (swir_may19[[2]] + swir_may19[[1]] + tc_may19[[2]] + tc_may19[[3]])
plot(sumNBR2_may19, col=inferno(100))
NBR2_may19= (difNBR2_may19) / (sumNBR2_may19)
plot(NBR2_may19, col=inferno(100))

#Delta
dNBR2 = (NBR2_may4) - (NBR2_may19)
plot(dNBR2, col = fire, main="dNBR+")

#classificazione delta 1
class <- im.classify(dNBR, num_clusters = 2)
class.names <- c("healthy vegetation", "burned areas")
plot(class, main= "Damaged area's classificatiobn", type="classes", levels= class.names, col= fire)

freq <- freq(class)
freq

#Calcoliamo il totale dei pixel
tot <- ncell (class)
tot

#Proporzione
prop = freq/tot
prop
      
#Percentuale 
#Healthy vegetation = 88.7%
#Burned areas = 11.3%
perc = prop*100
perc

#classificazione delta 2
class2 <- im.classify(dNBR2, num_clusters = 2)
class.names <- c("healthy vegetation", "burned areas")
plot(class2, main= "Damaged area's classificatiobn", type="classes", levels= class.names, col= fire)

freq2 <- freq(class2)
freq2
#Calcoliamo il totale dei pixel
tot2 <- ncell (class2)
tot2
#Proporzione
prop2 = freq2/tot2
prop2
#Percentuale 
#Healthy vegetation = 85.7%
#Burned areas= 14.3%
perc2 = prop2*100
perc2

suppressWarnings({
fc2017 <- rast("fc2017.jpeg")
})
suppressWarnings({
fc2024 <- rast("fc2024.jpeg")
})

class2017 <- im.classify(fc2017, num_clusters=3)
class.names <- c("Damaged vegetation", "Healthy vegetation", "Water Bodies")
plot(class2017, main= "Classification 2017", type="classes", levels=class.names, col= c("darkkhaki","darkolivegreen","darkblue"))

class2024 <- im.classify(fc2024, num_clusters=3)
class.names <- c("Damaged vegetation", "Healthy vegetation", "Water Bodies")
plot(class2024, main= "Classification 2024", type="classes", levels=class.names, col= c("darkkhaki","darkolivegreen","darkblue"))

#Percentages 2017: 
# Damaged vegetation = 4.9%
# Healthy vegetation = 89.5%
# Water bodies = 5.6%
freq17 <- freq(class2017)
tot17 <- ncell (class2017)
prop17 = freq17/tot17
perc17 = prop17*100
perc17

#Percentages 2024: 
# Damaged vegetation = 15.5%
# Healthy vegetation = 79.1%
# Water bodies = 5.4%
freq24 <- freq(class2024)
tot24 <- ncell (class2024)
prop24 = freq24/tot24
perc24 = prop24*100
perc24
