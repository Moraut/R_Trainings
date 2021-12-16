################################################################
# Creater: Mohit Raut
# Title : Onc Pod R Trainings__Data Visualization in R
# Date : 5/15/2018
################################################################

library(ggplot2)  
    
#####################################################################################################
# Inspecting the iris dataset in R                                                                                                 
#####################################################################################################

str(iris)
table(iris$Species)

head(iris,10)

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Scatter plot (Bi-variate analysis)
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
plot(iris$Sepal.Length~iris$Petal.Length)


plot(iris$Sepal.Length~iris$Petal.Length, ylab="Sepal Length", xlab="Petal Length", 
     main="Sepal Length vs Petal Length")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# ylab is label for y-axis
# xlab is label for x-axis
# main provides the title
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

plot(iris$Sepal.Length~iris$Petal.Length, ylab="Sepal Length", xlab="Petal Length", 
     main="Sepal Length vs Petal Length", col="violet", pch="*",cex=1.6)

#Color names for ggplot2: http://sape.inf.usi.ch/sites/default/files/ggplot2-colour-names.png

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# col is used to add color
# pch determines the shape of the plot 
# Search google for the chart of PCH symbols used in R plot
# try pch ="@"
# cex controls the symbol size in the plot, default is cex=1; try cex=2

# General Formula:
#  plot(y~x, ylab="y-label", xlab="x-label", main="Title", col="color", pch="shape", cex="size of shape")
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#


#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Histogram
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
hist(iris$Sepal.Width)

hist(iris$Sepal.Width, xlab="Sepal Width", main ="Distribution of Sepal Width", col="darkcyan")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Historgram plot (Univariate Analysis)
# Sepal Width on x-axis min value of Sepal Width
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#


#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Boxplot
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

boxplot(iris$Sepal.Length~iris$Species)

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Boxplot (continuous variable change wrt a categorical variable)
# Sepal Length is a continuous variable
# Species is a categorical variable
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

boxplot(iris$Sepal.Length~iris$Species, xlab="Species", ylab="Sepal Length", main="Sepal Length of various Species", col="burlywood")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# General Formula:
#   boxplot(y~x, ylab="y-label", xlab="x-label", main="Title", col="color")

#  Issues:
#  1. Not of Print Quality
#  2. These are just images so no possibility of overlay

# Enter  ggplot2
# gg- grammar of graphics
# Major components of gg:
#    Data - The dataset for which we want to plot a graph
#    Aesthetics - The metrics onto which we plot our data(Scales)
#    Geometry - Visual Elements to plot the data(boxplot, scatterplot, etc.)
#    Facets - Groups by which we divide the data

# Aesthetics:
#  X-axis
#  Y-axis
#  fill
#  col
#  shape
#  size

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Using ggplot2 package
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

library(ggplot2)
ggplot(data=iris)


#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Aesthetics
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
ggplot(iris,aes(x=Petal.Length,y=Sepal.Length))+geom_point()
ggplot(iris,aes(x=Petal.Length,y=Sepal.Length,col=Species))+geom_point()
ggplot(iris,aes(x=Petal.Length,y=Sepal.Length,shape=Species))+geom_point()
ggplot(iris,aes(x=Petal.Length,y=Sepal.Length,col=Species,shape=Species))+geom_point()

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Geometry
#Historgram
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
ggplot(iris,aes(x=Sepal.Width))+geom_histogram()
ggplot(iris,aes(x=Sepal.Width))+geom_histogram(bins=50)
ggplot(iris,aes(x=Sepal.Width))+geom_histogram(bins=50,fill="palegreen4")
ggplot(iris,aes(x=Sepal.Width))+geom_histogram(bins=50,fill="palegreen4",col="darkcyan")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#position
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
ggplot(data=iris, aes(x=Sepal.Width,fill=Species))+ geom_histogram(binwidth=0.2, col="black")
ggplot(data=iris, aes(x=Sepal.Width,fill=Species))+ geom_histogram(binwidth=0.2, col="black", position="fill")
ggplot(data=iris, aes(x=Sepal.Width,fill=Species))+ geom_histogram(binwidth=0.2, position="fill")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Barplot
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

set.seed(1234)
iris1 = iris[sample(1:nrow(iris), 110), ]

ggplot(data=iris1,aes(x=Species))+geom_bar()
ggplot(data=iris1,aes(x=Species,fill=Species))+geom_bar()

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Pie Chart
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

ggplot(iris1, aes(x=factor(1), fill=Species)) + geom_bar(width=1)+ coord_polar()
ggplot(iris1, aes(x=factor(1), fill=Species)) + geom_bar(width=1)+ coord_polar(theta="y")
ggplot(iris1, aes(x=factor(1), fill=Species)) + geom_bar(width=1)+ coord_polar(theta="X")

cxc=ggplot(iris1, aes(x = factor(Species),fill=Species)) +  geom_bar(width = 1)
cxc
cxc + coord_polar()

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Density Curves
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
d=density(iris$Sepal.Width)
hist(iris$Sepal.Width, breaks=12, prob=TRUE, xlab="Sepal Width", main="Histogram & Density Curve")
lines(d, lty=2, col="blue")

density=ggplot(data=iris, aes(x=Sepal.Width))

density + geom_histogram(binwidth=0.2, color="black", fill="steelblue", aes(y=..density..))+
        geom_density(stat="density", alpha=I(0.2), fill="gray20") +
        xlab("Sepal Width") +  ylab("Density") + ggtitle("Histogram & Density Curve")

density2 = ggplot(data=iris, aes(x=Sepal.Width, fill=Species))


density2 + geom_density(stat="density", alpha=I(0.2)) +
           xlab("Sepal Width") +  ylab("Density") + 
           ggtitle("Histogram & Density Curve of Sepal Width")


#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Smoothing Curves
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

smooth = ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
          geom_point(aes(shape=Species), size=1.5) + 
          xlab("Sepal Length") + 
          ylab("Sepal Width") + 
          ggtitle("Scatterplot with smoothers")

smooth
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Linear model
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
smooth + geom_smooth(method="lm")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Local polynomial regression
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
smooth + geom_smooth(method="loess")

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# generalised additive model
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
smooth + geom_smooth(method="gam", formula= y~s(x, bs="cs"))

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#Faceting
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
facet = ggplot(data=iris, aes(Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point(aes(shape=Species), size=1.5) + geom_smooth(method="lm") +
  xlab("Sepal Length") + ylab("Sepal Width") + ggtitle("Faceting")

facet

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Along rows
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
facet + facet_grid(. ~ Species)

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
# Along columns
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
facet + facet_grid(Species ~ .)
