#### 1) Data Frame Handling in R ####

#### ####

#### Loading Libraries ####
# install.packages(c("dplyr", "tidyr", "ggplot2", "lubridate"))
library(dplyr)
library(ggplot2)





#### Setting Working Directory ####

# GET the working directory
getwd()
# SET the working directory
setwd("C:/ZS-WORK/27_R Session/Session II")

getwd()

#### Reading Datasets ####

# Reading a file with specified delimiter
diamonds <- read.table("C:/ZS-WORK/27_R Session/Session II/diamonds_table.txt", header = TRUE, sep = "\t",stringsAsFactors = FALSE)
# rm(diamonds)

# Reading a file with read.delim
iris <- read.delim("iris_pipe.txt", header = TRUE, sep = "|" , stringsAsFactors = FALSE)
# rm(iris)

# Reading a few lines of data
diamonds_limited <- read.delim("diamonds_table.txt", header = TRUE, sep = "\t" , stringsAsFactors = FALSE, nrows = 1000)
# rm(diamonds_limited)

?read.table

# Reaading RData format
load("diamonds.Rdata")


# Reading through Clipboard

using_clipboard <- readClipboard()
rm(using_clipboard)

using_clipboard_2 <- read.table(file = "clipboard", sep = "\t", header = TRUE)
rm(using_clipboard_2)



#### Writing Datasets ####

# Writing a file with specified delimiter
write.table(diamonds, "diamonds_table.txt")
write.table(diamonds, "diamonds_table.txt", row.names = F, sep = "\t")



# Writing a file with write.csv
write.csv(iris, "iris_pipe.txt", row.names = F, na = "")
rm(iris)

# To save a dataframe or object in .RData format
save(diamonds, file = "diamonds.RData")

# To save all the objects in the R environment
save(list = ls(), file = "Datasets.RData")


# Remove everything from the R environment
rm(list = ls())


#### Exploring a Dataframe ####

# Yet another way of reading datasets.... only for 'internal' datasets
data(mtcars)

# Let's load the diamonds data again
load("diamonds.Rdata")

class(diamonds)

# Dimensions of the data.frame
dim(diamonds)

# To understand the structure of the data frame
str(diamonds)
str(mtcars)


head(diamonds, 10)
tail(diamonds, 10)

View(diamonds)

# Go-through the exploration of data frame from within the view


# Summary of the Datasets
summary(diamonds)





