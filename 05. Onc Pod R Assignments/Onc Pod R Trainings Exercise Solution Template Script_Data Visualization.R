################################################################
# Creater: Employee Name & [ Employee ID]
# Title : Onc Pod R Exercise Solution Template Data Visualization in R
###############################################################

library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(babynames)

########################################################################################
# Create a plot of the locations of these earthquakes, showing depth with color and magnitude
# with size
#########################################################################################

#=======================================================================================#
#mtcars Data
str(mtcars)
#=======================================================================================#

#---------------------------------------------------------------------------------------#
#Create a graphic that displays the distribution in mpg between 4,6, and 8 cylinder cars
#in the built-in data set mtcars
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#Consider the Batting data in the Lahman data set.3. More questions on the Batting data
#set. Make sure to take into account stint in these problems.										
#---------------------------------------------------------------------------------------#

#---------------------------------------------------------------------------------------#
#a. Create a scatterplot of the number of doubles hit in each year from 1871-2015.										
#---------------------------------------------------------------------------------------#

require(Lahman)
str(Batting)

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#b. Create a scatterplot of the number of doubles hit in each year from 1871-2015 in 
#each league. Color the NL blue and the AL red.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#c. Create boxplots for total runs scored per year in the AL and the NL from 1969-2015.										
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#d. Create a histogram of lifetime batting averages (H/AB) for all players who have at 
#   least 1000 career AB's.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#e. In your histogram from (d), color the NL blue and the AL red. (If a player played in 
#   both the AL and NL, count their batting average in each league if they had more than 
#   1000 AB's in that league.)
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#f. Using the Master data, create a barplot of the birthmonths of all players.
#   (Hint: geom_bar())
#---------------------------------------------------------------------------------------#
str(Master)

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#g. Create a barplot of the birth months of the players born in the USA after 1970.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#########################################################################################
# Create a plot of the locations of these earthquakes, showing depth with color and 
# magnitude with size
#########################################################################################

str(babynames)

#---------------------------------------------------------------------------------------#
#a. Make a line graph showing the total number of babies of each sex, plotted over time.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
  
#---------------------------------------------------------------------------------------#
#b. Make a line graph showing the number of different names used for each sex, plotted
#   over time.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#c. Make a line graph comparing the number of boys named Bryan and the number of boys
#   named Brian from 1920 to the present.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

#---------------------------------------------------------------------------------------#
#d. Make a line graph showing how many babies of your gender have your name, 
#   plotted over time.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
