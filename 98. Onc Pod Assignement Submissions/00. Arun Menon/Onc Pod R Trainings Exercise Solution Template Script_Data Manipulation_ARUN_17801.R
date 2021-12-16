################################################################
# Creater: ARUN A MENON [17801]
# Title : Onc Pod R Exercise Solution Template Data Manipulation in R
################################################################

library(dplyr)
library(magrittr)

#########################################################################################
# 1. Consider the movieLensData.
#########################################################################################

#=======================================================================================#
#Movies Data
movies <- read.csv("http://stat.slu.edu/~speegle/_book_data/movieLensData", as.is = TRUE)								
str(movies)
#=======================================================================================#

#---------------------------------------------------------------------------------------#
#a. What is the movie with the highest mean rating that has been rated at least 30 times?


#---------------------------------------------------------------------------------------#

#YOUR CODE HERE


#Check if a any movie has not been rated(exclude that movie from dataset if required)
sum( is.na( movies$Rating ) ) == 0 # TRUE . Hence no NAs in Rating column

movie_rate <- movies  %>%  group_by(MovieID,Title)  %>% summarise(freq_rating = n(),mean_rating = mean(Rating))

movie_rate <- movie_rate %>% filter(freq_rating >= 30) %>% arrange(desc(mean_rating))


#---------------------------------------------------------------------------------------#
#b. Which genre has been rated the most? 
#   (For the purpose of this, consider Comedy and Comedy|Romance completely different genres,for example.)									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

movie_rate <- movies  %>%  group_by(Genres)  %>% summarise(freq_rating = n(),mean_rating = mean(Rating))%>% arrange(desc(freq_rating))


#---------------------------------------------------------------------------------------#
#c. Which movie in the genre Comedy|Romance that has been rated at least 75 times has the 
#   lowest mean rating? Which has the highest mean rating?									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

movie_rate <- movies  %>%  filter(Genres == "Comedy|Romance")  

movie_rate <- movie_rate  %>%  group_by(MovieID,Title)  %>% summarise(freq_rating = n(),mean_rating = mean(Rating))

movie_rate <- movie_rate %>% filter(freq_rating >= 75) %>% arrange((mean_rating))

#Which has the highest mean rating of all movies in the genre Comedy|Romance that has 
#been rated at least 75 times has the lowest mean rating? 

#ANSWER :Amelie (Fabuleux destin dAmélie Poulain, Le) (2001)

#Which has the highest mean rating in the genre Comedy|Romance? 

#ANSWER :Sexual Life of the Belgians, The (La Vie sexuelle des Belges 1950-1978) (1994)


#---------------------------------------------------------------------------------------#
#d. Which movie that has a mean rating of 4 or higher has been rated the most times?									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

movie_rate <- movies  %>%  group_by(MovieID,Title)  %>% summarise(freq_rating = n(),mean_rating = mean(Rating))

movie_rate <- movie_rate %>% filter(mean_rating >= 4) %>% arrange(desc(freq_rating))

#---------------------------------------------------------------------------------------#
#e. Which user gave the highest mean ratings?									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
    
user_rating <- movies%>% group_by(UserID) %>% summarise( mean_rating_of_user = mean(Rating)) %>% arrange(desc(mean_rating_of_user))

#########################################################################################
#2. Consider the Batting data set in the Lahman library.This gives the batting statistics 
#   of 101,332 players who have played baseball from 1871 through 2015.
#########################################################################################


#=======================================================================================#
#Batting and Pitching Datasets
require(Lahman)
str(Batting)
str(Pitching)
?Batting #data description
#=======================================================================================#

install.packages("Lahman")
library(Lahman)

#---------------------------------------------------------------------------------------#
#a. Which player has been hit-by-pitch the most number of times?									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

batting <- Batting
pitching <-Pitching
master <- Master

hitbypitch <- batting %>% group_by(playerID) %>% summarise( freq_HBP =sum(HBP)) %>% arrange(desc(freq_HBP))

name <- hitbypitch[1,1] 

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)

#---------------------------------------------------------------------------------------#
#b. How many doubles were hit in 1871?									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

sum(batting %>% filter( yearID == 1871 ) %>% select (X2B))

#---------------------------------------------------------------------------------------#
#c. Which team has the most number of home runs?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

homerunteam <- batting %>% group_by(teamID) %>% summarise( homerun = sum( HR )) %>% arrange(desc(homerun))
      
#---------------------------------------------------------------------------------------#
#d. Which player who has played in at least 500 games has scored the most number of runs
#   per game?									
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

player_with_max_runs <- ((batting %>% group_by(playerID)  %>% summarise( totalruns = sum(R), totalgames = sum(G))) %>% filter(totalgames >=500)) %>% mutate(runspergame = totalruns/totalgames  ) %>% arrange(desc(runspergame))

name <- player_with_max_runs[1,1] 

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#---------------------------------------------------------------------------------------#
#e. Which player has the most lifetime at bats without ever having hit a home run?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
sum(is.na(batting$HR))==0

player_with_max_home_runs <- (batting %>% group_by(playerID) %>% summarise( atbats = sum(AB), sumHR = sum(HR)) %>% arrange(desc(atbats))) %>% filter(sumHR == 0)

name <- player_with_max_home_runs [1,1] 

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#---------------------------------------------------------------------------------------#
#f. Which player who was active in 2015 has the most lifetime at bats without ever having 
#   hit a home run?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE


#I think this is a wrong question  - It should be : Who has the most lifetime at bats in 2015 without ever having to hit a home run?
# If so, the answer is below:

player_with_max_home_runs <-  ( batting %>% group_by(playerID,yearID) %>% summarise( atbats = sum(AB),sumHR = sum(HR)) %>% arrange(desc(atbats)) ) %>% filter( sumHR == 0)

player_with_max_home_runs <-  player_with_max_home_runs %>% filter( yearID == 2015)

name <- player_with_max_home_runs[1,1] 

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)

# If question is :Which player who was active in 2015 has the most lifetime at bats without ever having hit a home run?
# The answer is as follows:

player_with_max_home_runs <-  ( batting %>% group_by(playerID) %>% summarise( atbats = sum(AB),sumHR = sum(HR)) %>% arrange(desc(atbats)) ) %>% filter( sumHR == 0)

players_active_in_2015 <- batting %>% filter ( yearID == 2015 )

pos<-head(data.frame(Active_in_2015 = player_with_max_home_runs$playerID %in% players_active_in_2015$playerID , Index = c(1:nrow(player_with_max_home_runs ))) %>% filter( Active_in_2015 ==TRUE) ,1)

name <- player_with_max_home_runs[pos[1,2],1] 

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#########################################################################################
# 3. More questions on the Batting data set.
#########################################################################################

#---------------------------------------------------------------------------------------#
#a. Which player has hit the most triples in a single season since 1960?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

triple <- (batting %>% filter( yearID >= 1960))%>% arrange(desc(X3B))

name <- triple[1,1]

name_player <- master %>% filter ( playerID ==name[1,1] ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#---------------------------------------------------------------------------------------#
#b. In which season did the major league leader in triples have the fewest triples?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
levels(batting$lgID)

aa<-(batting%>% filter(lgID == 'AA'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))
al<-(batting%>% filter(lgID == 'AL'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))
fl<-(batting%>% filter(lgID == 'FL'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))
na<-(batting%>% filter(lgID == 'NA'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))
nl<-(batting%>% filter(lgID == 'NL'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))
pl<-(batting%>% filter(lgID == 'PL'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))
ua<-(batting%>% filter(lgID == 'UA'))  %>% group_by(playerID)%>% summarise( sumtriple = sum(X3B)) %>% arrange(desc(sumtriple))

cbind(aa[1,1],al[1,1],fl[1,1],na[1,1],nl[1,1],pl[1,1],ua[1,1])

player<-(batting %>% group_by(playerID,lgID) %>% summarise(triplesum = sum(X3B)) %>% arrange(desc(triplesum)))

triple <- (batting %>% filter(playerID == as.character(player[1,1]))) %>% arrange(X3B)
                                
#---------------------------------------------------------------------------------------#
#c. In which season was there the biggest difference between the major league leader in 
#   stolen bases (SB) and the player with the second most stolen bases?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

player <- (batting %>% group_by(playerID,lgID) %>% summarise(SBsum = sum(SB)) %>% arrange(desc(SBsum)))

a<-batting %>% filter( playerID == "henderi01" ) %>% group_by(yearID) %>% summarise ( total = sum(SB))

b<-batting %>% filter( playerID == "brocklo01" ) %>% group_by(yearID) %>% summarise ( total = sum(SB))


#########################################################################################
# 4. Consider the Pitching data in the Lahman data set.
#########################################################################################

#---------------------------------------------------------------------------------------#
#a. Which pitcher has won (W) the most number of games?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
wonmost<-pitching %>% group_by(playerID) %>% summarise(wins = sum(W)) %>% arrange(desc(wins))

name <- wonmost[1,1]

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#---------------------------------------------------------------------------------------#
#b. Which pitcher has lost (L) the most number of games?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
lostmost<-pitching %>% group_by(playerID) %>% summarise(losses = sum(L)) %>% arrange(desc(losses))

name <- lostmost[1,1]

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)

#---------------------------------------------------------------------------------------#
#c. Which pitcher has hit the most opponents with a pitch (HBP)?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE
player <- pitching %>% group_by(playerID) %>% summarise(pitch = sum(HBP)) %>% arrange(desc(pitch))

name <- player[1,1]

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#---------------------------------------------------------------------------------------#
#d. Which year had the most number of complete games (CG)?
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

year<- pitching %>% group_by(yearID) %>% summarise(CGsum = sum(CG)) %>% arrange(desc(CGsum))

#---------------------------------------------------------------------------------------#
#e.  Among pitchers who have won at least 100 games, which has the highest winning 
#    percentage? (Winning percentage is wins divided by wins + losses.)
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

winpercent <- (pitching %>% group_by(playerID) %>% summarise (win = sum(W),winper = sum(W)/(sum(W) + sum(L)))) %>% filter( win >=100) %>% arrange(desc(winper))

name <- winpercent[1,1]

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)


#---------------------------------------------------------------------------------------#
#e.   Among pitchers who have struck out at least 500 batters, which has the highest 
#     strikeout to walk ratio? (Strikeout to walk ratio is SO/BB.)
#---------------------------------------------------------------------------------------#

#YOUR CODE HERE

player<- (pitching %>% group_by(playerID) %>% summarise (strike = sum(SO),SW= sum(SO)/(sum(BB)))) %>% filter( strike >=500) %>% arrange(desc(SW))

name <- player[1,1]

name_player <- master %>% filter ( playerID == as.character(name[1,1]) ) %>% select(playerID,nameFirst,nameLast,nameGiven)



#---------------------------------------------------------------------------------------#