#### 5) APPLY family in R ####


#### ####

#### Reading Datasets ####
data("mtcars")
str(mtcars)

diamonds <- read.csv("data/diamonds.csv", header = T, stringsAsFactors = F)
str(diamonds)



#### APPLY ####

# apply(array, margin, function)
# array: Could be a vector, matrix, dataframe
# margin: 1 == row, 2 == column
# function: use any function, even user defined

mat1 <- matrix(1:12, nrow = 3, byrow = TRUE)
mat1

# Row-wise sum
apply(mat1, 1, sum)

# Column-wise sum
apply(mat1, 2, sum)

# Application of apply
apply(mtcars[, c(8:11)], 1, mean)




#### LAPPLY ####

ls1 <- list(a = 5:15, b = -12:2, c = rep(34:40, each = 2))
ls1

lapply(ls1, median)

lapply(ls1, '[', 4)

lapply(ls1, length)

# Note that the output of lapply is list itself
class(lapply(ls1, length))




#### SAPPLY ####

sapply(ls1, range)
sapply(ls1, quantile)
sapply(ls1, function(x) quantile(x,probs = seq(0, 1, 0.1)))

# Gives an output as vector or matrice... easier to magivate than navigating sapply
class(sapply(ls1, range))





#### Application of APPLY function ####

# Back to Outlet Data...
outlet_sales <- read.csv("outlet_sales.csv", header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA", "-", "#N/A"))

# Are there NAs in the data
is.na(outlet_sales)


# How many NAs are there in the data?
sum(is.na(outlet_sales))

sum(is.na(outlet_sales$sales_dollars))


for (i in 1:dim(outlet_sales)[2]) 
{
  print(sum(is.na(outlet_sales[, i])))
}


# Use apply function
apply(outlet_sales, 2, function(x) sum(is.na(x)))

apply(outlet_sales, 2, function(x) sum(!is.na(x)))


for(i in 1:10)
  write.csv(paste0("filename_",i,".csv"),____)




# Helpful Links
# https://ramnathv.github.io/pycon2014-r/explore/sac.html
# https://www.datacamp.com/community/tutorials/r-tutorial-apply-family
# http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega








