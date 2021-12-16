setwd("C:/Users/dr4171/Documents/Projects/Data Mining w R/code")

library(plyr)
library(ggplot2)

# --------------------------------------------------------------------------
# 0. Import
# --------------------------------------------------------------------------

bnames <- read.csv("bnames.csv", stringsAsFactors = FALSE)
head(bnames)

# --------------------------------------------------------------------------
# 1. Make some quick summaries
# --------------------------------------------------------------------------

letter <- function(x, n = 1) {
	if (n < 0) {
		nc <- nchar(x)
		n <- nc + n + 1
	}
	tolower(substr(x, n, n))
}
vowels <- function(x) {
	nchar(gsub("[^aeiouAEIOU]", "", x)) / 
	nchar(x)
}

bnames <- mutate(bnames,
	first = letter(name, 1),
	last = letter(name, -1),
	length = nchar(name),
	vowels = vowels(name)
)


# Some summaries
ddply(bnames, c("first"), summarise, 
	tot = sum(percent) /
	sum(bnames$percent))

ddply(bnames, c("last"), summarise, 
	tot = sum(percent) /
	sum(bnames$percent))

with(bnames,
	sum(length * percent) / sum(percent))

temp <- bnames[!duplicated(bnames$name),]
head(arrange(temp, -length))
head(arrange(temp, vowels))
head(arrange(temp, -vowels))

temp <- ddply(bnames, c("length"), summarise, prop = sum(percent) / sum(bnames$percent))

windows()
ggplot(temp, aes(x = length, y = prop)) + 
geom_bar(stat = "identity") + 
geom_text(aes(label = paste(round(prop * 100, 1), "%", sep = "")), vjust = -0.5)


# --------------------------------------------------------------------------
# Summary of first name popularity over time
# --------------------------------------------------------------------------
fl <- ddply(bnames, c("year", "sex", "first"), summarise, tot = sum(percent))

windows()
ggplot(fl) + 
geom_line(aes(x = year, y = tot, colour = sex)) + 
facet_wrap(~ first, ncol = 6)

# --------------------------------------------------------------------------
# % of people with top 100 name over time
# --------------------------------------------------------------------------
bnames <- arrange(bnames, year, sex, -percent)
bnames$count <- 1

top100 <- ddply(bnames, c("year", "sex"), transform, count = cumsum(count))
top100 <- subset(top100, count <= 100)
top100 <- ddply(top100, c("year", "sex"), summarise, tot = sum(percent))

windows()
ggplot(top100) + 
geom_line(aes(x = year, y = tot, group = sex, colour = sex)) + 
scale_y_continuous(limits = c(0, 1))

# --------------------------------------------------------------------------
# Track popularity over time of top 20 names (in 2008)
# --------------------------------------------------------------------------
top20 <- head(arrange(subset(bnames, year == 2008), -percent)$name, 20)
top20 <- subset(bnames, name %in% top20 & year >= 1989)
top20 <- ddply(top20, 
	c("year", "name"), summarise, 
	percent = sum(percent))

windows()
ggplot(top20) + 
geom_line(aes(x = year, y = percent)) + 
facet_wrap(~ name, ncol = 5)

