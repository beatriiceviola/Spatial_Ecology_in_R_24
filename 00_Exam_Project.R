
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


#NBR May 4
diff.may4 = swir_may4[[2]] - swir_may4[[1]] 
plot(diff.may4, col = viridis(100))
sum.may4 = swir_may4[[1]] + swir_may4[[2]]
plot(sum.may4, col = viridis(100))
NBR_may4 = (diff.may4) / (sum.may4) 
plot(NBR_may4, col = viridis(100)) 

#NBR May 19
diff.may19 = swir_may19[[2]] - swir_may19[[1]] 
plot(diff.may19, col = viridis(100))
sum.may19 = swir_may19[[1]] + swir_may19[[2]]
plot(sum.may19, col = viridis(100))
NBR_may19 = (diff.may19) / (sum.may19) 
plot(NBR_may19, col = viridis(100)) 

#NBR June 12
diff.june12 = swir_june12[[2]] - swir_june12[[1]] 
plot(diff.june12, col = viridis(100))
sum.june12 = swir_june12[[1]] + swir_june12[[2]]
plot(sum.june12, col = viridis(100))
NBR_june12 = (diff.june12) / (sum.june12) 
plot(NBR_june12, col = viridis(100)) 
