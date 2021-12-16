###11
demo(persp)

demo(graphics)

rm(list = ls())

###12
5 + 38

23 + 
  16

###13
x <- 10

x <- 10
y = 5
20 -> z

###14
class(31)
class(108.5)
class("ZS")
class(TRUE)
class(3 + 5i)

###16
x <- 31L
x <- 108.5
x <- "ZS"
x <- TRUE
x <- 3 + 5i

###17
x <- 'ZS'
x <- T
x <- (5 < 6)

###18
x <- ZS
x <- True
x <- true

###20
#if x not defined earlier
#x <- 10
is.na(x)  #Not Available
is.nan(x) #Not a Number
is.infinite(x)  #Infinity

###23
vec1 <- c('kapil','nishant','aritra')
vec2 <- 1:10
vec3 <- seq(1,10)
vec4 <- rep(5,10)
vec5 <- (vec4 > 8)

#Q1 What will be the class of vec5?
#Q2 What values will be in vec5?

###24
vec6 <- c(1,"R", TRUE)
class(vec6)

#Q : What will be the class of the following vector :
vec7 <- c(TRUE,10.2,5)
class(vec7)

#Q: Assign 10.1 to a variable and coerce it into an integer
x <- 10.1
class(x)
x <- as.integer(x)
class(x)

###27
as.numeric("1")
as.character(TRUE)

###28
vec1 <- 1:10
vec2 <- 11:20
vec3 <- vec1 + vec2
vec3

vec3 <- vec1*vec2
vec3

###29
vecA <- 1:10
vecB <- 11:15
vecC <- vecA + vecB
vecC

###30
vecA <- 1:10
vecB <- 4
vecC <- vecA + vecB
vecC

###31
vecA <- 1:10
vecB <- c(21,48)
vecC <- vecA + vecB
vecC

###32 Q: What is the relationship between the length of two vectors for recycling to hold ? 
vecA <- 1:10
vecB <- c(5,10,15)
vecC <- vecA + vecB

#Right Method
vecA <- 1:15
vecC <- vecA + vecB
vecC

###33
vec <- 5:14

vec[5]
vec[7]
vec[0]
vec[-5]

vec[2:5]
vec[c(3,6)]
vec[-6:-3]
vec[c(3,-5)]

vec[c(TRUE,FALSE)]

###34
vec <- 1:10

vec[vec > 5]
vec[vec <= 2]
vec[vec == 5]
vec[vec != 6]
vec[vec %in% c(2, 5, 7)]
vec[vec > 5 & vec < 8]
vec[vec < 5 | vec == 7]
vec[!(vec > 8)]

###35
x <- c(1,2,3,4,5,6,7,8,9,NA)
is.finite(x)
any(x < 0)
all(x > 5)

any(x > 0, na.rm = TRUE)

any(is.na(x))







###40
mat <- matrix(5:20,nrow = 4)
mat[3,4]

###42
mat[,2]

###44
mat[2:3,3:4]

###45 Q: How to select the 2nd and 4th column of mat ?
mat[,c(2,4)]

###49
nam <- c("Kapil","Nishant","Aritra","Charu")
age <- c(31,25,29,23)
sex <- c("M","M","M","F")
train <- c(TRUE,TRUE,FALSE,FALSE)
test <- list(name = nam,age = age, sex = sex, trainer = train)

###50
test[2]

#Q: What will be the type of test[2] ?

class(test[2])

###51
test[[2]]

#Q : What will be the class of test[[2]] ?
class(test[[2]])

###52
test$age

#Q: What will be the class of test$2 ?
class(test$age)

###62
nam <- c("Kapil","Nishant","Aritra","Charu")
age <- c(31,25,29,23)
sex <- c("M","M","M","F")
train <- c(TRUE,TRUE,FALSE,FALSE)
test <- data.frame(name = nam,age = age, sex = sex, trainer = train)

names(test)

###63 Q : what is the class of test[2,2]
test[2,2]

class(test[2,2])

###64
test$age

#Q: What is the class of test$age ?
class(test$age)

###65
test$age
test$age[2]
test$age[test$age > 25]
test[test$age > 25,2]
test[test$age %in% c(29,25)]
test[,"sex"]





###Example of a list having multiple class types
list1 <- list(age = c(35,25,22), #vector
              name = c("Kapil","Nishant","Abhinav"), #vector 
              mat = matrix(1:9,nrow = 3), #matrix
              df = data.frame(nam = c("John","Robb","Arya"), sex = c("M","M","F")), #data frame
              small_list = list(nam = c("Eddard","Tyrion","Theon"), house = c("Stark","Lannister","Greyjoy"))) #list

#Q : How to subset df inside list1 ?
list1$df$nam
list1$df$sex

#Q : What if I only require 2nd row of the data frame df ?
list1$df[2,]

#Q : Whati if I only need element present in 3rd row, 1st column of the data frame df?
list1$df[3,1]






