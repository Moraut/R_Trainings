################################################################
# Creater: Mohit Raut
# Title : Onc Pod R Exercise Solution Script Data Visualization in R
# Date : 6/11/2018
################################################################

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

#Option 1:
plot(mtcars$mpg~mtcars$cyl, 
     xlab="# of Cylinders", ylab="Miles per Gallon",
     main="Distribution of miles per gallon by # of cylinders in vehciles",
     col=mtcars$cyl,pch="-",cex=2.5
     )

#Option 2:
ggplot(mtcars,aes(x=mtcars$cyl,y=mtcars$mpg,col=mtcars$cyl))+
geom_point(cex=3,pch="x")+
xlab("# of Cylinders")+
ylab("Miles per Gallon")+
ggtitle("Distribution of Miles per Gallon by Number of cylinders")

#---------------------------------------------------------------------------------------#
#Consider the Batting data in the Lahman data set.3. More questions on the Batting data
#set. Make sure to take into account stint in these problems.										
#---------------------------------------------------------------------------------------#

#---------------------------------------------------------------------------------------#
#a. Create a scatterplot of the number of doubles hit in each year from 1871-2015.										
#---------------------------------------------------------------------------------------#

require(Lahman)
str(Batting)

year_data=Batting%>%
            group_by(yearID)%>% 
              summarise(num_of_doubles=sum(X2B))
                  

#Option 1:
plot(year_data$num_of_doubles~year_data$yearID, 
     xlab="Year", ylab="# of double hits",
     main="# of Double hits by Year",
     col=year_data$yearID,pch=".",cex=3.0
     )

#Option 2:
ggplot(year_data,aes(x=year_data$yearID,y=year_data$num_of_doubles,col=year_data$yearID))+
geom_point(cex=4.0,pch="o")+
xlab("Year")+
ylab("# of double hits")+
ggtitle("# of Double hits by Year")

#---------------------------------------------------------------------------------------#
#b. Create a scatterplot of the number of doubles hit in each year from 1871-2015 in 
#each league. Color the NL blue and the AL red.
#---------------------------------------------------------------------------------------#

year_data=Batting%>%
            filter(yearID>1870 & yearID<2016)
            group_by(yearID,lgID)%>% 
              summarise(num_of_doubles=sum(X2B))

group.colors=c("AA"="Green","AL"="red", "FL"="turquoise","NA" = "grey",
               "NL"="blue", "PL"="maroon", "UA"="black")

ggplot(year_data,aes(x=year_data$yearID,y=year_data$num_of_doubles,col=year_data$lgID))+
geom_point(cex=5.0,pch="O")+
xlab("Year")+
ylab("# of double hits")+
labs(col="Major Baseball Leagues")+
ggtitle("# of Double hits by Year")+ 
theme(legend.position="left")

#---------------------------------------------------------------------------------------#
#c. Create boxplots for total runs scored per year in the AL and the NL from 1969-2015.										
#---------------------------------------------------------------------------------------#

year_tot_runs=Batting%>%
            filter(lgID %in% c("AL","NL") & yearID>=1969 & yearID <2016)%>%
              group_by(yearID,lgID)%>% 
                summarise(Runs_scored=sum(R))

ggplot(year_tot_runs,aes(x=year_tot_runs$lgID,y=year_tot_runs$Runs_scored,col=year_tot_runs$lgID))+
geom_boxplot()+
xlab("League")+
ylab("# of Runs Scored")+
ggtitle("# of Runs Scores by Year (in AL and NL)")+ 
labs(col="Major Baseball Leagues")+
theme(legend.position="bottom")+
scale_colour_manual(values = group.colors)

#---------------------------------------------------------------------------------------#
#d. Create a histogram of lifetime batting averages (H/AB) for all players who have at 
#   least 1000 career AB's.
#---------------------------------------------------------------------------------------#

player_data=Batting%>%
              group_by(playerID)%>%
                  summarise(tot_AB=sum(AB),tot_H=sum(H))%>%
                      filter(tot_AB>=1000)%>%
                        mutate(H_to_AB=tot_H/tot_AB)
min(player_data$H_to_AB)
max(player_data$H_to_AB)
                        
ggplot(player_data,aes(x=H_to_AB))+
geom_histogram(bins=20,fill="darkcyan",col="white")+
xlab("H to AB ratio")+
ylab("# of Players (with Minimum 1000 Carrer ABs")+
ggtitle("# of Players by H to AB ratio")

#---------------------------------------------------------------------------------------#
#e. In your histogram from (d), color the NL blue and the AL red. (If a player played in 
#   both the AL and NL, count their batting average in each league if they had more than 
#   1000 AB's in that league.)
#---------------------------------------------------------------------------------------#

player_data=Batting%>%
              group_by(playerID,lgID)%>%
                  summarise(tot_AB=sum(AB),tot_H=sum(H))%>%
                      filter(tot_AB>=1000)%>%
                        mutate(H_to_AB=tot_H/tot_AB)

unique(player_data$lgID)

hist_colors=c("AA"="Green","AL"="red", "FL"="turquoise","NA" = "grey",
               "NL"="blue")
                        
ggplot(player_data,aes(x=H_to_AB,fill=lgID))+
geom_histogram(position='identity',bins=50)+  
xlab("H to AB ratio")+
ylab("# of Players (with Minimum 1000 Carrer ABs")+
ggtitle("# of Players by H to AB ratio")+
scale_fill_manual(values = hist_colors)

#---------------------------------------------------------------------------------------#
#f. Using the Master data, create a barplot of the birthmonths of all players.
#   (Hint: geom_bar())
#---------------------------------------------------------------------------------------#
str(Master)
ggplot(Master, aes(Master$birthMonth))+
geom_bar(binwidth=0.5,bins=24)+
xlab("Calendar Month")+
ylab("# of Players born")+
ggtitle("# of Players by birth month")

#---------------------------------------------------------------------------------------#
#g. Create a barplot of the birth months of the players born in the USA after 1970.
#---------------------------------------------------------------------------------------#

player_usa=Master%>%
              filter(birthCountry=="USA" & birthYear>1970)

ggplot(player_usa, aes(x=birthMonth))+
geom_bar(binwidth=0.5,bins=24)+
xlab("Calendar month")+
ylab("# of USA Players born after 1970")+
ggtitle("# of Players by birth month")

#########################################################################################
# Create a plot of the locations of these earthquakes, showing depth with color and 
# magnitude with size
#########################################################################################

str(babynames)

#---------------------------------------------------------------------------------------#
#a. Make a line graph showing the total number of babies of each sex, plotted over time.
#---------------------------------------------------------------------------------------#

data=babynames%>%
        group_by(sex,year)%>%
          summarise(count=sum(n))

ggplot(data,aes(x=year,y=count,group=sex))+
geom_line(aes(color=sex))+
geom_line(aes(linetype=sex))+
geom_point(aes(shape=sex))+
xlab("Birth Year")+
ylab("Count of babies born with same name and birth year")+
ggtitle("Count of babies born with same name and birth year by year")
  
#---------------------------------------------------------------------------------------#
#b. Make a line graph showing the number of different names used for each sex, plotted
#   over time.
#---------------------------------------------------------------------------------------#

data=babynames%>%
            distinct(name,sex,year)%>%
              group_by(sex,year)%>%
                    summarise(num_distinct_names=n())

ggplot(data,aes(x=year,y=num_distinct_names,group=sex))+
geom_line(aes(color=sex),size=1.8)+
geom_line(aes(linetype=sex))+
geom_point(aes(shape=sex),size=3)+
xlab("Count of distinct names of babies")+
ylab("Birth Year")+
ggtitle("Count of distinct names of babies by birth year")

#---------------------------------------------------------------------------------------#
#c. Make a line graph comparing the number of boys named Bryan and the number of boys
#   named Brian from 1920 to the present.
#---------------------------------------------------------------------------------------#

data=babynames%>%
      filter(sex=="M")%>%  
        select(year,name,n)%>%
          filter((name %in% c("Brian","Bryan")) & year>1919)


ggplot(data,aes(x=year,y=n,group=name))+
geom_line(aes(color=name),size=1.8)+
geom_line(aes(linetype=name))+
geom_point(aes(shape=name),size=3)+
xlab("Count of babies")+
ylab("Birth Year")+
ggtitle("Count of male babies (named Bryan and Brian) by birth year")

#---------------------------------------------------------------------------------------#
#d. Make a line graph showing how many babies of your gender have your name, 
#   plotted over time.
#---------------------------------------------------------------------------------------#

data=babynames%>%
    group_by(year)%>%
      summarise(num_of_babies=sum(n))
        
ggplot(data,aes(x=year,y=num_of_babies))+
geom_line(size=0.5)+
geom_point(size=2)+
xlab("Count of babies")+
ylab("Birth Year")+
ggtitle("Count of male babies with same name and birth year by year")
