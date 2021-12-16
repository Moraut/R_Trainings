################################################################
# Creater: Mohit Raut
# Title : Onc Pod R Trainings__Data Manipulation in R
# Date : 4/11/2018
################################################################

######################################################################################################
# Loading the required libraries and setting the default working directory 
######################################################################################################


library(dplyr)
library(tidyr)
library(stringr)
setwd("C:/Projects/P99_STAT/10. R Sessions for Onc Pod/00. Introduction to R")

######################################################################################################
# Loading the data set
######################################################################################################

data=read.csv('train.csv',sep=',',header=TRUE)

######################################################################################################
# Checking the structure and contents of the data
######################################################################################################

str(data)
tail(data,5)
summary(data)
glimpse(data)

data[1:5,c('Emails','Clicks')]

######################################################################################################
# SELECT: Selecting columns
######################################################################################################

#Using columns name
select(data,Month,Emails)
head(select(data, Month:Clicks, -(PDE:Emails)),5)

#Using columns indicies
colnames(data)
colnames(data)[4]="SP"
colnames(data)
colnames(select(data, 1:4,-2))

write.csv(data,"temp1.csv")
#Helpers for select() 

#columns starting with
head(select(data, starts_with("clic",ignore.case = FALSE)),5)
head(select(data, starts_with("clic",ignore.case = TRUE)),5)

#columns ending with
head(select(data, ends_with("rx")),5)

#columns containing with
head(select(data, -ends_with("rx")),5)

#columns matching with
head(select(data, matches('rx|mails')),5)

#columns from a given list
temp=c('Emails' ,'Trx')
head(select(data, one_of(temp)),5)

#columns based on data type
head(select_if(data,is.numeric),5)

#columns based on data type
head(select_all(data, toupper),5)

######################################################################################################
# MUTATE: Creating additonal columns from existing data
######################################################################################################

#simple addtion operation to create a new column
head(mutate(data, direct_promo=Calls+PDE),5)

#calculating difference from averaage of the column
head(mutate(data, calls_diff_avg=Calls-mean(Calls)),5)

#map in text values
month_abb=month.abb
month_abb
head(mutate(data, MOnth_text=month_abb[Month]))

#create custom flags using ifelse
head(mutate(data, High_Calls_Flag=ifelse(Calls>mean(Calls),1,0)))

head(mtcars,5)

#create custom flags using multiple conditonal statements
head(mutate(mtcars,call_segment =case_when( mpg>20 ~ 'HIGH', mpg > 10 ~ 'MEDIUM', TRUE ~ 'LOW')),5)

#recoding values in a column
head(mutate(data,month_name=recode(Month,"1" ="January",.default="other")))

#merging columns in R
con_data=unite(data,temp, Calls,PDE, sep=":")
head(con_data)

#spliting columns in R
split_data=separate(con_data,temp,into=c("col1","col2"),sep=":")
head(split_data)

######################################################################################################
# FILTER: Creating additonal columns from existing data
######################################################################################################

#conditonal filtering of rows
head(filter(data,Month==1))

#conditonal filtering of rows
head(filter(data,Month==1 & Account=="A1B012"),5)

#rows containing certain values
filter(data, Account %in% c("A1B012", "A2B012"))

#rows not containing certain values
filter(data, !Account %in% c("A1B012", "A1B012"))

#rows containing a specific string
head(filter(data,str_detect(Account, pattern = "11B0")),5)

#filtering rows using logic gates 
head(filter(data,xor(Calls > 100, PDE > 15)),5)

#filtering empty rows 
head(filter(data,is.na(Emails)),5)

######################################################################################################
# ARRANGE: Rearrange rows 
######################################################################################################

#arranging rows by columns
head(arrange(data, Calls))

#arranging rows by columns
head(arrange(data, desc(Trx)))

#arranging rows by columns
head(arrange(data, desc(Trx), SP))

#Random n samples of data
sample_n(data, 5)

#Random nth fraction  samples of data
sample_frac(data, 0.0009)

#Random nth fraction  samples of data
head(data,5)
group_by(data, Account)

#Top n rows of the data
top_n(data,7)

######################################################################################################
# Summarise: Summarising data  
######################################################################################################

#Summarise data by column
summarise(data,x=mean(PDE),y=max(PDE))

#Summarise data by column
summarise(data,average_PDE=mean(PDE),average_Calls=mean(Calls),average_emails=mean(Emails))

#Summarise data by column
data1=subset(data,select=Month:Samples)
summarise_all(data1,max,na.rm=TRUE)

#Summarise data by based on data types
summarise_if(data,is.numeric,max,na.rm=TRUE)

#Summarise data by based on data types
group_by(data,Account)%>%summarise(average_calls=mean(Calls))

#Summarise data by on specific levels using group_by and pipe operator
group_by(data,Account)%>%summarise_if(is.numeric,mean,na.rm=TRUE)
