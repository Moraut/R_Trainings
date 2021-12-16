################################################################
# Creater: ARUN A MENON & [ 17801 ]
# Title : Onc Pod R Exercise Solution Template Data Visualization in R
###############################################################

library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(babynames)

########################################################################################
# Create a plot of the locations of these earthquakes, showing depth with color and magnitude
# with size ---- WHAT EARTHQUAKES?
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

mtcars <- mtcars %>% mutate(cylindertype = (ifelse(cyl ==4,"4 cylinder",ifelse(cyl ==6,"6 cylinder","8 cylinder"))))
ggplot(mtcars,aes(x =mpg, y= cyl,shape = cylindertype)) + geom_point()

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
doubles <- (batting %>% group_by(yearID) %>% summarise (doubles = sum(X2B))) %>% filter(yearID >=1871 & yearID <= 2015)

plot(doubles,main="Doubles scored from 1871 - 2015", col="violet", pch="*",cex=1.6)

#---------------------------------------------------------------------------------------#
#b. Create a scatterplot of the number of doubles hit in each year from 1871-2015 in 
#each league. Color the NL blue and the AL red.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

doubles <- (batting %>% group_by(yearID,lgID) %>% summarise (doubles = sum(X2B))) %>% filter(yearID >=1871 & yearID <= 2015)


ggplot(doubles,aes(x=yearID,y=doubles,shape=lgID,col = lgID))+geom_point() + scale_color_manual(values=c("cyan","red", "magenta", "green","blue","grey","black"))

#---------------------------------------------------------------------------------------#
#c. Create boxplots for total runs scored per year in the AL and the NL from 1969-2015.										
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

runs <- batting %>% filter((yearID >= 1969 & yearID <=2015) & (lgID == 'AL' | lgID =='NL')) %>% group_by(yearID,lgID) %>% summarise ( totalruns = sum( R))
boxplot(runs$totalruns~runs$yearID, xlab="Year", ylab="Runs scored", main="Runs scored in AL and NL", col=runs$lgID)


#---------------------------------------------------------------------------------------#
#d. Create a histogram of lifetime batting averages (H/AB) for all players who have at 
#   least 1000 career AB's.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

runs <- (batting %>% group_by(playerID) %>% summarise ( sumAB = sum(AB),sumH = sum(H),avg = sumH/sumAB)) %>% filter (sumAB >=1000)
ggplot(runs,aes(x=avg))+geom_histogram(bins=50,fill="palegreen4",col="darkcyan")

#---------------------------------------------------------------------------------------#
#e. In your histogram from (d), color the NL blue and the AL red. (If a player played in 
#   both the AL and NL, count their batting average in each league if they had more than 
#   1000 AB's in that league.)
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

runs <- (batting %>% group_by(playerID,lgID) %>% summarise ( sumAB = sum(AB),sumH = sum(H),avg = sumH/sumAB)) %>% filter (sumAB >=1000)

ggplot(data=runs, aes(x=avg,fill=lgID))+ geom_histogram(binwidth=0.01, col="black") + scale_fill_manual(values=c("cyan","red", "magenta", "green","blue","grey","black"))


#---------------------------------------------------------------------------------------#
#f. Using the Master data, create a barplot of the birthmonths of all players.
#   (Hint: geom_bar())
#---------------------------------------------------------------------------------------#
str(Master)

#YOUR CODE HERE

ggplot(data=master,aes(x=birthMonth,fill = factor(birthMonth)))+geom_bar(width = 0.8, color = "black")

#---------------------------------------------------------------------------------------#
#g. Create a barplot of the birth months of the players born in the USA after 1970.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

after1970<-master%>% filter(birthYear > 1970 & birthCountry=='USA')

ggplot(data=after1970,aes(x=birthMonth,fill = factor(birthMonth)))+geom_bar(width = 0.8, color = "black")


#########################################################################################
# Create a plot of the locations of these earthquakes, showing depth with color and 
# magnitude with size
#########################################################################################
?babynames
str(babynames)
babynames <- babynames

#---------------------------------------------------------------------------------------#
#a. Make a line graph showing the total number of babies of each sex, plotted over time.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

baby <- babynames %>% group_by(year,sex) %>% summarise( num = n())
ggplot(baby,aes(x=year,y=num,shape = sex,col = sex)) + geom_line() + geom_point()
  
#---------------------------------------------------------------------------------------#
#b. Make a line graph showing the number of different names used for each sex, plotted
#   over time.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
baby<- babynames %>% group_by(year,sex,name) %>% summarise( count = n())
ggplot(baby,aes(x=year,y=count,shape = sex,col = sex)) + geom_line() + geom_point()

#---------------------------------------------------------------------------------------#
#c. Make a line graph comparing the number of boys named Bryan and the number of boys
#   named Brian from 1920 to the present.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

baby <- ((babynames %>% filter(sex == 'M')) %>% group_by(year,name) %>% summarise ( count = n())) %>% filter(name == 'Brian' | name == 'Bryan')
baby <- baby %>% filter(year >=1920)
ggplot(baby,aes(x=year,y=count,shape = name,col = name)) + geom_line() + geom_point()

#---------------------------------------------------------------------------------------#
#d. Make a line graph showing how many babies of your gender have your name, 
#   plotted over time.
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
gender <- 'M'
awesome_name <- 'Arun'
baby <- (babynames %>% group_by(year,sex,name) %>% summarise ( count = n())) %>% filter( name == awesome_name & sex == gender)
ggplot(baby,aes(x=year,y=count,shape = name,col = name)) + geom_line() + geom_point()




