
#Import libraries
library(terra) #to use satellite images
library(imageRy) #for manipulating raster images in R
library(viridis) #for color palettes
library(ggplot2) #to create graphs
library(patchwork) #for coupling ggplot2 graphs

#devtools:: install_github("ducciorocchini/imageRy")

setwd("/Users/macbookairair/Downloads/Cartella")

suppressWarnings({
tc_may4 <- rast("begmay.jpeg")
})
suppressWarnings({
tc_may19 <- rast("endmay.jpeg")
})
suppressWarnings({
tc_june12 <- rast("june.jpeg")
})

par(mfrow=c(1,3))
plot(tc_may4)
title("May 4", line = -6, cex=2) 
plot(tc_may19)
title("May 19", line = -6, cex=2) 
plot(tc_june12)
title("June 12", line = -6, cex=2) 
dev.off()

suppressWarnings({
swir_may4 <- rast("begmay_swir.jpeg")
})
suppressWarnings({
swir_may19 <- rast("endmay_swir.jpeg")
})
suppressWarnings({
swir_june12 <- rast("june_swir.jpeg")
})

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
plot(class, col= c("blue","darkolive","darkorange2","darkolive2"))

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


#Deta
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






























































































