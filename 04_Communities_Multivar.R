# This code is for multivariate analysis of species x plot data in communities
# First we install the package vegan from CRAN  
install.packages("vegan")
library(vegan)

# Let's load the dune dataset, which contains vegetation data
# In particular it contains observations of 30 species and 20 sites
data(dune) # I obtain the matrix 

# To see the structure of the dataset I display the first 6 rows with head()
head(dune) 

# To see the whole table i use View() with a capital letter
View(dune) 


# In the package vegan we will use the function "decorana", which give us the "Detrended Correspondance Analysis" 
# DCA is a multivariate statistical technique that is very useful when the range is quite spread out and wide,
# since it compacts the data mathemathically, reducing its dimensions 

# Analysis
multivar <- decorana(dune) # AS always we assing it to an object 

# The original set is compressed in 4 new axis 
# And we want to know the lenght of each new axis since the lenght is the amount of range rapresented
# by each axis (also we have to remember that 3 is the maximum number of axis
# that we can use since our brain works in 3 dimensions)
# The aim is to see the percentage of the original range which is incorporated in 2 axes. 

# First of all let's see the lenghts obtained with the decorana plot
dca1 = 3.7004
dca2 = 3.1166
dca3 = 1.30055
dca4 = 1.47888
total = dca1 + dca2 + dca3 + dca4 

# Now let's obtain proportions and then percentages:

# Proportion of coontribution of each DCA axis to the tootal variation
prop1 = dca1/total
prop2 = dca2/total
prop3 = dca3/total
prop4 = dca4/total

# Percetanges
perc1 = prop1*100
perc2 = prop2*100
perc3 = prop3*100
perc4 = prop4*100


# Now let's check how much of the variability of the dataset is explained by the first two DCA axis
perc1 + perc2 # We find out that they explain the 71% of the variability

# In this way I "loose" more or less 29% of the original information but
# I have still most of the informations in just one plot

# Now, by plotting the results I can visualize the relationship between species and samples
plot(multivar)
