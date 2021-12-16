################################################################
# Creater: Mohit Raut
# Title : Onc Pod R Exercise Solution Script Data Manipulation in R
# Date : 6/13/2018
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

movies%>%
  group_by(Title)%>%
      summarize(meanRating=mean(Rating),numRating=n())%>%
          filter(numRating>=30)%>%arrange(desc(meanRating))

#---------------------------------------------------------------------------------------#
#b. Which genre has been rated the most? 
#   (For the purpose of this, consider Comedy and Comedy|Romance completely different genres,for example.)									
#---------------------------------------------------------------------------------------#

movies%>%
  group_by(Genres)%>%
    summarize(num_rating=n())%>%
      arrange(desc(num_rating))
    
#---------------------------------------------------------------------------------------#
#c. Which movie in the genre Comedy|Romance that has been rated at least 75 times has the 
#   lowest mean rating? Which has the highest mean rating?									
#---------------------------------------------------------------------------------------#

movies%>%
  filter(Genres=='Comedy|Romance')%>%
    group_by(Title)%>%
      summarize(num_rating=n(),mean_rating=mean(Rating))%>%
        filter(num_rating>=75)%>%
          arrange(mean_rating)

#---------------------------------------------------------------------------------------#
#d. Which movie that has a mean rating of 4 or higher has been rated the most times?									
#---------------------------------------------------------------------------------------#

movies%>%
  group_by(Title)%>%
    summarize(num_rating=n(),mean_rating=mean(Rating))%>%
      filter(mean_rating>=4.0)%>%
        arrange(desc(num_rating))

#---------------------------------------------------------------------------------------#
#e. Which user gave the highest mean ratings?									
#---------------------------------------------------------------------------------------#

movies%>%
  group_by(UserID)%>%
    summarize(user_mean_rating=mean(Rating))%>%
      arrange(desc(user_mean_rating))

    
#########################################################################################
#2. Consider the Batting data set in the Lahman library.This gives the batting statistics 
#   of 101,332 players who have played baseball from 1871 through 2015.
#########################################################################################


#=======================================================================================#
#Batting and Pitching Datasets
require(Lahman)
str(Batting)
str(Pitching)
?Batting #data description
#=======================================================================================#

#---------------------------------------------------------------------------------------#
#a. Which player has been hit-by-pitch the most number of times?									
#---------------------------------------------------------------------------------------#

#Checking the unique values present in the HBP column
unique(Batting$HBP)

left_join((Batting%>%
              group_by(playerID)%>%
                  summarize(count_HBP=sum(HBP,na.rm=TRUE))%>%
                    arrange(desc(count_HBP))
           )[1,],select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#b. How many doubles were hit in 1871?									
#---------------------------------------------------------------------------------------#

Batting%>%
    group_by(yearID)%>%
      summarize(double_count=sum(X2B, na.rm=TRUE))

#---------------------------------------------------------------------------------------#
#c. Which team has the most number of home runs?
#---------------------------------------------------------------------------------------#

Batting%>%
  group_by(teamID)%>%
    summarize(home_runs_count=sum(HR, na.rm=TRUE))%>%
      arrange(desc(home_runs_count))
      
#---------------------------------------------------------------------------------------#
#d. Which player who has played in at least 500 games has scored the most number of runs
#   per game?									
#---------------------------------------------------------------------------------------#

left_join((Batting%>%
  group_by(playerID)%>%
    summarize(count_games=sum(G),count_runs=sum(R))%>%
      filter(count_games>=500)%>%
        mutate(average_runs_per_game=count_runs/count_games)%>%
          arrange(desc(average_runs_per_game)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#e. Which player has the most lifetime at bats without ever having hit a home run?
#---------------------------------------------------------------------------------------#

left_join((Batting%>%
  group_by(playerID)%>%
    summarise(home_runs=sum(HR),at_bats=sum(AB))%>%
      filter(home_runs==0)%>%
        arrange(desc(at_bats)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")
        
#---------------------------------------------------------------------------------------#
#f. Which player who was active in 2015 has the most lifetime at bats without ever having 
#   hit a home run?
#---------------------------------------------------------------------------------------#

left_join((Batting%>%
  filter(yearID==2015)%>%
    group_by(playerID)%>%
      summarise(home_runs=sum(HR),at_bats=sum(AB))%>%
        filter(home_runs==0)%>%
          arrange(desc(at_bats)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#########################################################################################
# 3. More questions on the Batting data set.
#########################################################################################

#---------------------------------------------------------------------------------------#
#a. Which player has hit the most triples in a single season since 1960?
#---------------------------------------------------------------------------------------#

left_join((Batting%>%
  filter(yearID>=1960)%>%
    group_by(playerID,yearID)%>%
      summarize(num_triples=sum(X3B))%>%
        arrange(desc(num_triples)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#b. In which season did the major league leader in triples have the fewest triples?
#---------------------------------------------------------------------------------------#
temp=toString(
              (Batting%>%
                group_by(playerID)%>%
                summarize(num_triples=sum(X3B))%>%
                  arrange(desc(num_triples))%>%
                    select(playerID))[1,])


left_join((Batting%>%
  filter(playerID==temp)%>%
      group_by(playerID,yearID)%>%
        summarize(num_triples=sum(X3B))%>%
          arrange(num_triples)%>%
            top_n(1,yearID))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#c. In which season was there the biggest difference between the major league leader in 
#   stolen bases (SB) and the player with the second most stolen bases?
#---------------------------------------------------------------------------------------#

temp=Batting%>%
        group_by(playerID,yearID)%>%
        summarise(SB_count=sum(SB))%>%
          filter(!is.na(SB_count) & SB_count>0)%>%
            arrange(yearID,desc(SB_count))%>%
              ungroup()%>%
                mutate(year=as.numeric(yearID))

library(tidyr)
temp

temp$year=as.numeric(temp$yearID,length="0L")

unique(select(temp,"year","SB_count"))%>%
  group_by(year)%>%
    arrange(desc(SB_count))%>%
      mutate(rank=dense_rank(-SB_count)) %>%
        arrange(year)%>%
          filter(rank<3)%>%
    spread(rank,SB_count)%>%
        filter(!is.na(1)&!is.na(2))%>%
          set_colnames(c("year", "rank_1", "rank_2"))%>%
            mutate(SB_diff=rank_1-rank_2)%>%
              arrange(desc(SB_diff))
  
#########################################################################################
# 4. Consider the Pitching data in the Lahman data set.
#########################################################################################

#---------------------------------------------------------------------------------------#
#a. Which pitcher has won (W) the most number of games?
#---------------------------------------------------------------------------------------#

left_join((Pitching%>%
  group_by(playerID)%>%
    summarise(num_w=sum(W))%>%
      arrange(desc(num_w)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#b. Which pitcher has lost (L) the most number of games?
#---------------------------------------------------------------------------------------#

left_join((Pitching%>%
  group_by(playerID)%>%
    summarise(num_l=sum(L))%>%
      arrange(desc(num_l)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#c. Which pitcher has hit the most opponents with a pitch (HBP)?
#---------------------------------------------------------------------------------------#

left_join((Pitching%>%
  group_by(playerID)%>%
    summarise(num_hbp=sum(HBP))%>%
      arrange(desc(num_hbp)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#d. Which year had the most number of complete games (CG)?
#---------------------------------------------------------------------------------------#

Pitching%>%
  group_by(yearID)%>%
    summarise(sum_CG=sum(CG))%>%
      arrange(desc(sum_CG))

#---------------------------------------------------------------------------------------#
#e.  Among pitchers who have won at least 100 games, which has the highest winning 
#    percentage? (Winning percentage is wins divided by wins + losses.)
#---------------------------------------------------------------------------------------#

left_join((Pitching%>%
    group_by(playerID)%>%
      summarise(wins=sum(W),losses=sum(L))%>%
        filter(wins>=100)%>%
          mutate(win_percent=wins/(wins+losses))%>%
            arrange(desc(win_percent)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#
#e.   Among pitchers who have struck out at least 500 batters, which has the highest 
#     strikeout to walk ratio? (Strikeout to walk ratio is SO/BB.)
#---------------------------------------------------------------------------------------#

left_join((Pitching%>%
  group_by(playerID)%>%
    summarise(SO_sum=sum(SO),walk=sum(BB))%>%
      filter(SO_sum>=500)%>%
        mutate(SO_to_BB_ratio=SO_sum/(SO_sum+walk))%>%
          arrange(desc(SO_to_BB_ratio)))[1,],
        select(Master,playerID,nameFirst,nameLast),by="playerID")

#---------------------------------------------------------------------------------------#