# Spectral indices

# As always let's recall the packages that I'll need
library(imageRy)
library(terra)

# And then let's see the images that are available in imageRy
im.list()

# Import data: we'll import the matogrosso image from 2006 with im.import()
im.import("matogrosso_ast_2006209_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") # We always assigned it to an object to make things easier

# To see data digit 
m2006

# For this image the bands were already build like this:
# band 1 = NIR = R
# band 2 = red = G
# band 3 = green = B

# Use them for RGB image
# With NIR on red so that the vegetation will appear red
im.plotRGB(m2006, r=1, g=2, b=3)

# we can plot single bands
# 2 and 3 don't make much difference. To test:
plot(m2006[[2]])
plot(m2006[[3]])

# NIR on blue: the vegetation will appear blue while the bare soil will appear yellowish
# To do so I switch the Nir band (1) on the blue filter
im.plotRGB(m2006, r=3, g=2, b=1)

# NIR on green: the vegetation will appear green while the bare soil pink

# I change the NIR band on the green filter
im.plotRGB(m2006, r=3, g=1, b=2)

# Let's now import the same image from 1992 to see how the vegetation was before the human intervention
m1992<- im.import("matogrosso_l5_1992219_lrg.jpg") 
im.plotRGB(m1992, r=1, g=2, b=3)

# And also for this image we'll see:
# nir on red
im.plotRGB(m1992, r=1, g=2, b=3)

# nir on green
im.plotRGB(m1992, r=2, g=1, b=3)

# nir on blue
im.plotRGB(m1992, r=2, g=3, b=1)


# Multiframe: let's compare the two images from 1992 and 2006 with NIR on red
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)


# Exercise: make a multiframe with 6 images in pairs with Nir on the same component
# First row: the three images from m1992 
# Second row: the three images from 2006
# In this way I can easily appreciate the differences between the different years
par(mfrow=c(2,3))
im.plotRGB(m1992, r=1, g=2, b=3) #1992 on red
im.plotRGB(m1992, r=2, g=1, b=3) #1992 on green
im.plotRGB(m1992, r=2, g=3, b=1) #1992 on blue
im.plotRGB(m2006, r=1, g=2, b=3) #2006 on red
im.plotRGB(m2006, r=2, g=1, b=3) #2006 on green
im.plotRGB(m2006, r=2, g=3, b=1) #2006 on blue


# DVI (Different Vegetation Index) 
# this index is fundamental since our eyes can evaluate just qualitatively the loss of vegetation
# while with this index we can see it quantitatively 
# For every pixel in the NIR band it subtracts the same pixel of the red band
# and since the image is in 8 bit, our DVI can change from 255 (if NIR is max and red is 0)
# to -255 (if NIR is 0 and red is max)
dvi1992 = m1992[[1]] - m1992[[2]]

# Here the = symbol is the same as an association
# But since is a mathematical operation I cans use =

# Let's plot the DVI with a color palette
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# Let's do the same thing for 2006 
dvi2006 = m2006[[1]] - m2006[[2]]

# Plot it with the same colo palette
plot(dvi2006, col=cl)

# We obtain a  very low DVI, so there is not much vegetation left since the NIR is close to zero

# Multiframe: let's compare these results by plotting them together 
par(mfrow=c(1,2)
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

dev.off()
    
# NDVI (Normalize Different Vegetation Index)
# same of DVI (NIR - RED) but divided by NIR+red as a denominator 
# with NDVI you can compare every images even if they have different bits
# it's always better to use NDVI instead on DVI, but if you have images of same bit you can use DVI
# calcualte NDVI 1992 and 2006
ndvi1992 = dvi1992 / (m1992[[1]]+m1992[[2]]) # NDVI of 1992
ndvi2006 = dvi2006 / (m2006[[1]]+m2006[[2]]) # NDVI of 2006

# ANd again we compare them by putting them in a multiframe
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
