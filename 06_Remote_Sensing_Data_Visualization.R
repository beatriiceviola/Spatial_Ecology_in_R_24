# Code for managing and visualizing remote sensing data

# Let's install devtools, a package in CRAN that we need to create a connetcion with Github

install.packages("devtools")
library(devtools) # Then we check if it was correctly installed

# Now, to install a package from GitHub we will need the function "install_github("")"
# that is contained in devtools
# Inside this function I'll put the name of the user and the naame of the package that I want
# in our case the user is "ducciorocchini" and the package is "imageRy"

install_github("ducciorocchini/imageRy")
library(imageRy)

# To let everyone who's reading my code know frome where I tookthis package I can write it down like this:

devtools:: install_github("ducciorocchini/imageRy") 

# Every time I open up R again I won't need to reinstall the packages that I need
# But I'll always need to recall them with "library()"


# Another package that we need to install is "ggplot2" 
# This alows me to make more beautiful graphic

install.packages("ggplot2")
library(ggplot2)

# Let's make a list of all the images contained in the package imageRy
# Every function in this package starts wit im.

im.list()

# To import a specific image we use "im.import("")"
# In particular we want the image b2 from Sentinel-2 which correspond to the band of blue
# So working in 490nm, very short wavelenght, all the objects reflecting blue will be visible

b2 <-im.import("sentinel.dolomites.b2.tif" )

# As always we can chenge the colors using the colorRampPalette function
# Every color in this function needs to be under quotes and 
# we have to specify the number of shades that we want

cl <- colorRampPalette(c("cyan4","magenta","cyan", "chartreuse"))(100)
plot(b2,col=cl)

# Let's now import other images corresponding to other bands:
# In particular
# green band:
b3<- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl)

# red band
b4<- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

# near infrared band (NIR)
b8<- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

# We dont't use b5,b6,b7 for the different resolution of 20 m instead of 10m

# Let's create a multiframe that will alow us to see all the four images together
# We will use the par() function and we need 2 rows and 2 columns
# the rows always go before the columns, and, since it's an array, we always use the concatenate function

par(mfrow=c(2,2))

# This function creates the frame (2x2 in our case)
# But now we have to plot again the images to put them inside the frame

plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# As we can see the first 3 images are pretty similar between each other, the only one
# which is significatly different is the NIR

# STACKSENT
# Thanks to the stack I'm able to overlap the different layers (4 bands) to obtain one satellite image
# Now it's easier to manipulate it as a single object containing all the infos
# Firstly we create an array with our four bands thanks to the function concatenate 
# and then we assign it to an object

stacksent<- c(b2, b3, b4, b8)
plot(sentstack, col=cl)

# It's faster then the multiframe but in this case the frame is always 2x2 and I can't choose it
# To cancel my plot I'll always use
dev.off()

# If I want to visualize only one of the bands in my stack I have to
# specify that from my array I just want, for example, the first object by using  [[]]
# I use two squared parenthesis because it's a double dimensional image

plot(stacksent[[1]], col=cl) 

# Since it will be useful in the future let's create an index to summarize to which
# element of the stacksent correspond which band
# stacksent[[1]]= b2= blue
# stacksent[[2]]= b3= green
# stacksent[[3]]= b4= red
# stacksent[[4]]= b8= nir

# Exercise: do a multiframe with different color palette
# Note: if I plot only a band, as b2, range blue-yellow can be read by daltonics as well
par(mfrow=c(2,2))

cl<- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=cl)

# Exercise: plot the same for the  band b3, b4, b8
# b3= green band
cl<- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=cl)

# b4= red band
cl<- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=cl)

# b8= nir band
cl<- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cl)


# RGB plotting
# RGB are three filters: Red, Green, Blue
# To plot an RGB image we'll use the function from imageRy im.plotRGB()
# Inside the parenthesis I'll specify the object and the bands associated
# In our case the object is stacksent and then I specify which filter to apply to each band

# For example by plotting im.plotRGB(stacksent, r=3, g=2, b=1) I'll obtain an image in real colors
# since I know that in my stacksent 3 is the red band that I leave on the red filter
# 2 is the green band that I leave on the green filter and
# 1 is the blue band that I leave on the blue filter

im.plotRGB(stacksent, 3, 2, 1) # I can also avoid to write down r=, g= and b=

# As we've seen RGB has 3 component but we have 4 bands
# So, since the red green and blue bands give me similar informations
# I can also choose to put the NIR band on the red filter instead of the red band
# In this way everything that reflects the near infrared will appear red and I'll gain new informations
# Especially on vegetation because this one reflects a lot in NIR

im.plotRGB(stacksent, 4, 3, 2) 

# Let's try to put NIR on top of green band 

im.plotRGB(stacksent, 3, 4, 2)

# or NIR on top of blue band

im.plotRGB(stacksent, 3, 2, 4)

# We can now do a multiframe with these new images
# Final multiframe
par(mfrow=c(2,2))
im.plotRGB(stacksent, 3, 2, 1 ) # natural oclors
im.plotRGB(stacksent, 4, 2, 1 ) # nir on red
im.plotRGB(stacksent, 3, 4, 2 ) # nir on green
im.plotRGB(stacksent, 3, 2, 4 ) # nir on blue

dev.off()

# Additional:
# correlations of information
pairs(stacksent)
# It show us that NIR is not correlated to the other bands
# While blue, green and red are stricly correlated between each other
# Thi show us why the NIR band add so many informations
