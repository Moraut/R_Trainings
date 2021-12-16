################################################################
# Creater: Mohit Raut
# Title : Onc Pod R Trainings__Transforming Data in R
# Date : 4/18/2018
################################################################

######################################################################################################
# Loading the required libraries and setting the default working directory 
######################################################################################################

library(dplyr)
library(tidyr)
library(stringr)
setwd("C:/Projects/STAT/10. R Sessions for Onc Pod/02. Transforming Data in R")

######################################################################################################
#Data Pivoting
######################################################################################################

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Create a dataframe in R
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

stocks=data.frame(time = as.Date('2009-01-01')+0:9,X = rnorm(10,0,1), Y= rnorm(10,0,2), Z=rnorm(10,0,4))
head(stocks,5)

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Pivoting down data
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

stocks_g=gather(stocks, stock, price, -time)
head(stocks_g,5)

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Pivoting down data
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

stocks_s=spread(stocks_g, stock, price)
head(stocks_s,5)

head(spread(stocks_g,time, price),5)

######################################################################################################
#Data Joins
######################################################################################################

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Checking Datasets
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

band_members
band_instruments

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Left Join
#return all rows from x, and all columns from x and y. Rows in x with no match in y will have NA values 
#in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

left_join(band_members,band_instruments,by="name")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Right Join
#return all rows from y, and all columns from x and y. Rows in y with no match in x will have NA values
#in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

right_join(band_instruments,band_members,by="name")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Full Join
#return all rows and all columns from both x and y. Where there are not matching values, returns NA for 
#the one missing.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

full_join(band_instruments,band_members,by="name")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Inner Join
#return all rows from x where there are matching values in y, and all columns from x and y. If there are
#multiple matches between x and y, all combination of the matches are returned.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

inner_join(band_members,band_instruments,by="name")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Semi Join
#return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs
#from an inner join because an inner join will return one row of x for each matching row of y, where a semi join
#will never duplicate rows of x.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

semi_join(band_members,band_instruments,by="name")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Anti Join
#return all rows from x where there are not matching values in y, keeping just columns from x.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

anti_join(band_instruments,band_members,by="name")

######################################################################################################
#Lead and Lag Functions
######################################################################################################

data=data.frame(year=2000:2005,value=(0:5)^2)
head(data,5)
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Lead
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

mutate(data,prev=lead(value,1))
mutate(data,prev=lead(value,5))

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Lag
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

mutate(data,prev=lag(value,1))
mutate(data,prev=lag(value,5))


