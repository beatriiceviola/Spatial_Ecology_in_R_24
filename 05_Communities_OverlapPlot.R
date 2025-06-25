# Let's investigate the relation among sepcies in time
# Code to estimate temporal activity patterns of different species and their overlap 
# First of all we're gonna need the package "overlap" from CRAN
install.packages("overlap")
library(overlap) #Load required library

# Let's load the dataset "kerinci" of this package from Kerinci-Sablat National Park in Sumatra, Indonesia
data(kerinci)

# Displays the first six rows of the dataset and check the names of the columns
head(kerinci) # Already with "head()" it shows the name of the columns but to be sure I can use "names()"
names(kerinci) # This just show me the names and nothiing else

# Summarize the dataset to understand its contents and to have an idea about the statistics of field
summary(kerinci)

# Now it's important to note that the unit of time in this dataset is the day where values go from 0 to 1 
# Time is linear dimension but we want circular dimension since overlap uses radians
# To convert it we will just need to multiplly our time for  pi
kerinci$Time * 2 * pi 

# It's probably better to create a new column and link it to the group kerinci
kerinci$Timecirc <- kerinci$Time * 2 * pi

# To check that the new column appeared we use head again
head(kerinci)

# Now let's focus on the first species: tiger
# to do so we will specify that we are just going to use the species "tiger"
# by writing kerinci[kerinci$Sps="tiger",]
# So in this way from the columns of species it will only take the tigers
# Since == means "equal" while != means "not equal"
# And then we assign this function to a new object
tiger <- kerinci[kerinci$Sps=="tiger",]

# We proceed by selecting the circular time data just for the tigers
# and then by plotting the density of tiger activity
# To do so we use densityPlot() , remember that R is case sensitive and the P is in capital letters
tigertime <- tiger$Timecirc
densityPlot(tigertime)

# We can see two main peaks in the graphics
# The first one is at 6am, probably to search for food
# while the second one is around 6pm to probably search for a repair for the night

# Now we're gonna do the same thing for a different species of the dataset
# Firstly, like before, we just want to select the species, the macaque this time
macaque <- kerinci[kerinci$Sps=="macaque",]

# Then we select the circular time data for the macaques
# And assigned it to an object
macaquetime <- macaque$Timecirc

# After we plot the density of the macaques's activity
densityPlot(macaquetime)

# Now we can use overlap to check how the two sepcies are related in time
# By controlling the activity patterns of tigers and macaques together
# This, for example, can be useful to see when the predator could potentially hunt their preys like macaques
# To do so we will plot the overlapping density of tiger and macaque activity together
overlapPlot(tigertime, macaquetime) # the mainly overlap in activity is between 6am and 6pm

# Note: as we said befor == means equal and != means not equal
# so, if for example we wanted all the species but the macaques we coul have wrote:
nomacaque <- kerinci[kerinci$Sps!="macaque",]
summary(nomacaque)
