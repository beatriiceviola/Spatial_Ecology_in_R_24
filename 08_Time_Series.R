# Time series analysis in R

# We start from recalling the packages that we are going to use
library(terra)
library(imageRy)

# Then let's do the list of the images available in imageRy
im.list()

# Importing data from European Nitrogen (it shows the amount of nitrogen in Europe before the COVID lockdown) 
EN01 <- im.import("EN_01.png") # This first image is from Jenuary 2020

# Then we import the same image during the lockdown, in march 2020
EN13 <- im.import("EN_13.png")

# Even though the rainbow color isn't the best we cannot change it becuase these are already elaborated images

# Now I can calculate the difference between the same band of the two images (for every pixel of the images)
# We want to calculate the difference between the first band of EN01 and the first band of EN13
# Even in this case, since it's a mathematical operation, I can use = instead of <-
difEN=EN01[[1]] - EN13[[1]]

# By creating a new colorRampPalette I can put red as the maximum so that it correspond to the highest temperature
cl<- colorRampPalette(c("blue", "white", "red"))(100)

# Now I plot the difference calculated before with the new color palette
# In this way I'll obtain a quantification of the change between january and march
# Since these are images in 8 bit, it will variate from -255 to +255
plot(difEN, col=cl)

## Ice melting in Greenland 
# We take the datas from Copernicus, which are images in 16 bit so with many informations
# But the range in this case doesn't arrive to 65000 but around 15000
# Let's use a proxy for ice melting, not directly ice
# in particular we'll use a parameter that rapresents it which is: soil temperature

# "greenland" is  the name of 4 different files
gr <- im.import("greenland") # We always associate it to an object

# In this way we obtain one object that represents the four datas
# To plot a single level, for example the image from 2005, which is the second data
# We can always use the squared parenthesis
plot(gr[[2]])

# Let's do a multiframe: plot 1st and last elements of gr
par(mfrow=c(1,2)) # one row and two columns
plot(gr[[1]]) # first image from 2000
plot(gr[[4]]) # last image from 2015

# Now we add a new color ramp palette where the color black rapresents the lowest temperature
clg<-colorRampPalette(c("black", "blue", "white", "red"))(100) 

# With this new palette I can plot the images with new colors
plot(gr[[1]], col=clg) # 2000
plot (gr[[4]], col=clg) #2015

# I can clearly see that in 2015 there are very low temperatures only in the internal area, more ice melting 

# Now, as we seen before, we can quantify the change between 2000 and 2015
difgr = gr[[1]]-gr[[4]] # I obtain the difference

# Then I can create a new palette where red rapresents where the temperature got higher
clgreen<-colorRampPalette(c("red", "white", "blue"))(100) 
plot(difgr, col=clgreen) # I plot the difference

# Now we can associate every image to one filter of the RGB (so I can use maximum three images out of four)
# We put 2000 on the red filter, 2005 on the green one and 2015 on the blue filter
im.plotRGB(gr, 1,2,3)

# So with red I see the highest temperature in 2000, with green the highest temperature in 2005
# And with blue the highest temperature in 2015
