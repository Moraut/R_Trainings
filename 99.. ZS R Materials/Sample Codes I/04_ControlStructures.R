#### 4) Control Structures in R ####

#### ####

#### IF condition ####

x <- 10

# 1
if (x < 6) print(x)
if (x > 6) print(x)

# 2
if (x %% 2)
{
  print(paste0(x, " is an odd number"))
} else {
  print(paste0(x, " is an even number"))
}





# 3
x <- 13

if (x %% 3 == 0)
{
  print(paste0(x, " divisible by 3"))
} else if (x %% 3 == 1) {
  print(paste0(x, " leaves a remainder 1 when divided by 3"))
} else {
  print(paste0(x, " leaves a remainder 2 when divided by 3"))
}




#### IFELSE Condition ####

# Using IFELSE for less complex routines...
x <- 5
ifelse(x %% 2, paste0(x, " is an odd number"), paste0(x, " is an even number"))





#### FOR Loop ####

# 1: Directly loop through a vector
for (i in 1:10) {
  print(i)
}


# 2: Loop through elements of a vector
x <- c("Session 1", "Session 2", "Session 3", "Session 4")

for (i in 1:length(x)) {
  print(x[i])
}



for (i in seq(x)) {
  print(x[i])
}


# 3: Nested Loops
m <- matrix(1:9, ncol = 3)
summ <- 0

for (i in seq(nrow(m))) 
{
  for (j in seq(ncol(m))) 
  {
    summ <- summ + m[i, j]
    print(summ)
  }
}



#### IFELSE Revisit ####

x <- 4

# Works on single value...
if (x %% 2)
{
  print(paste0(x, " is an odd number"))
} else {
  print(paste0(x, " is an even number"))
}


# Does not work correctly for a vector
x <- 1:7

if (1:7 %% 2)
{
  print(paste0(x, " is an odd number"))
} else {
  print(paste0(x, " is an even number"))
}



# To get the right answer, we'll have to wrap up the IF condition inside a FOR loop!!
for (i in 1:7) 
{
  
  if ((i %% 2) == 1)
  {
    print(paste0(i, " is an odd number"))
  } else {
    print(paste0(i, " is an even number"))
  }
  
}



# OR, You can just vectorize it using IFELSE!!
x <- 1:7
ifelse(x %% 2, paste0(x, " is an odd number"), paste0(x, " is an even number"))



# You can use all kinds of conditional statemnts in IFELSE or IF / ELSE control structure
packages <- c("dplyr", "tidyr", "lubridate", "ggplot2")
ifelse("dplyr" %in% packages, "Well Done!!", "Please install it!!")




#### WHILE Loop ####

i <- 1
while (i < 10) 
{
  print(i)
  i <- i + 1
}



#### Use of NEXT in for loop ####
for (i in 1:10) 
{
  if (i %% 2) 
  {
    print(paste0(i, " is an odd number. We only print odd numbers. Odd, isn't it?"))
  } else {
    next
  }
}




#### Use of BREAK in for loop ####
for (i in 1:10) 
{
  if (i < 5) 
  {
    print(paste0("We are at ", i, ". We haven't reached 5 yet"))
  } else {
    print("We reached 5! Time to break the loop!!")
    break
  }
}




#### REPEAT Loop ####
# Always use BREAK with an IF condition to come out of the loop

x <- 1

repeat 
{
  square <- x ** 2
  x <- x + 1
  
  if (square < 125) 
  {
    print(paste0(square, " is less than 125. So, we'll remain in the loop."))
  } else {
    
    print(paste0(square, " is greater than 125... Going out of the loop."))
    break  # VERY IMPORTANT!!... 
  }
  
}


#### WHILE vs REPEAT Loop ####
# (condition vs use of BREAK)





#### SWITCH statement ####

# SWITCH(statement, case = action, ...)

# If the statement is numeric, it uses as an index in the list 
switch(2, "Python", "R", "Spark", "SAS", "SPSS")


switch(2, 2 = "Python", 3 = "R", 1 = "Spark", 6 = "SAS", 9 = "SPSS")
# Will show error


tool <- "R"
switch(tool, 
       "Python" = "Open Source", 
       "R" = "Open Source", 
       "Spark" = "Open Source", 
       "SAS" = "Paid", 
       "SPSS" = "Paid")



# Switch is a good alternative to multiple IF conditions

# Multiple IF / ELSE consitions...
x <- "SAS"

if (x == "Python") {
  print(paste0(x, " is a free software!"))
} else if (x == "R") {
  print(paste0(x, " is a free software!"))
} else if (x == "Spark") {
  print(paste0(x, " is a free software!"))
} else if (x == "SAS") {
  print(paste0(x, " is a paid software."))
} else if (x == "SPSS") {
  print(paste0(x, " is a paid software."))
}



# Alternative SWITCH Statement

software <- "Spark"

switch(software, 
       "Python" = print(paste0(software, " is a free software!")), 
       "R" = print(paste0(software, " is a free software!")), 
       "Spark" = print(paste0(software, " is a free software!")),
       "SAS" = print(paste0(software, " is a paid software.")),
       "SPSS" = print(paste0(software, " is a paid software."))
)




