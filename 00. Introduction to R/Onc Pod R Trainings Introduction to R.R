#---------------------------------------------------------------------------------------------#
#SETTING UP R
#---------------------------------------------------------------------------------------------#


################ Setting up working directorty #################################
setwd("C:/Projects/P99_STAT/10. R Sessions for Onc Pod/00. Introduction to R")


################ Loading required libraries #################################
library(dplyr)
library(ggplot2)

#---------------------------------------------------------------------------------------------#
#LOADING AND INSPECTING DATA IN R
#---------------------------------------------------------------------------------------------#


################ Loading the data as a dataframe object #################################
data=read.csv('train.csv',sep=",")

View(data)


################ Listing down colnames of the data set #################################
colnames(data)
colnames(data)=c("Acc_ID","Month","TRx","Speaker_Programs","Calls","PDE","Emails","Clicks","Samples")
colnames(data)

################ Top and Bottom n rows  #################################
head(data,10)
tail(data,10)

################ Summary Statistics of the data #################################
summary(data)

################Structure of the variable named data #################################
str(data)

#---------------------------------------------------------------------------------------------#
#FILTERING IN R
#---------------------------------------------------------------------------------------------#

################Selecting rows from a dataframe #################################
data[5:7,]
data[which(data$Month==1 | data$PDE>5),]

################Selecting columns from a dataframe #################################
data[,4:5]

mycols=c("Acc_ID","Month","Speaker_Programs","Emails")
data[mycols]

################ Smarter way of filtering data #################################
subset(data, Month==1 & PDE== 10, select= Acc_ID:PDE )


#---------------------------------------------------------------------------------------------#
#DATA TYPE CONVERSION IN R
#---------------------------------------------------------------------------------------------#


################ TO CHARACTER CONVERSION #################################
is.character(data$Month)
data$Month=as.character(data$Month)

################ TO NUMERIC CONVERSION #################################
is.numeric(data$Month)
data$Month=as.numeric(data$Month)

################ TO DATAFRAME CONVERSION #################################

vec1= c(14290,11271,15563,17360,15083)
vec2= c("MOHIT RAUT","JEEVARASAN ELANCHELVAN","VAIBHAV K SINHA","DEEPAK NANDAN","MOHAMMED ZAHIL BIN SIDDIQUE")

emp=data.frame(EMPLOYEE_ID=vec1,EMPLOYEE_NAME=vec2)

summary(emp)
str(emp)
colnames(emp)















