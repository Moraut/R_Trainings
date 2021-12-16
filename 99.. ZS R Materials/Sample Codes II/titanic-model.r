setwd("C:/Users/dr4171/Documents/Projects/Data Mining w R/code")

library(plyr)
library(ggplot2)
library(rpart)
library(randomForest)
library(arules)
library(arulesViz)

# --------------------------------------------------------------------------
# 0. Import
# --------------------------------------------------------------------------

titanic <- read.csv("titanic.csv", stringsAsFactors = FALSE)
head(titanic)

# --------------------------------------------------------------------------
# 1. Investigate
# --------------------------------------------------------------------------

table(titanic$Survived)	# numeric
table(titanic$Pclass) # numeric
table(titanic$Sex) # factor
table(titanic$Embarked) # factor
table(titanic$SibSp) # numeric
table(titanic$Parch) # numeric

windows()
ggplot(titanic) + geom_histogram(aes(x = Age))

windows()
ggplot(titanic) + geom_histogram(aes(x = Fare))

head(arrange(titanic, -Fare))

titanic <- mutate(titanic, miss = ifelse(grepl("Miss.", Name), 1, 0), mrs = ifelse(grepl("Mrs.", Name), 1, 0))
titanic$Age[is.na(titanic$Age)] <- median(titanic$Age, na.rm = TRUE)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)

table(complete.cases(titanic[,c("Survived", "Pclass", "Sex", "Embarked", "SibSp", "Parch", "Age", "Fare", "miss", "mrs")]))

# --------------------------------------------------------------------------
# 2. Make a single tree model
# --------------------------------------------------------------------------
single.tree <- rpart(
	Survived ~ ., 
	titanic[,c("Survived", "Pclass", "Sex", "Embarked", "SibSp", "Parch", "Age", "Fare", "miss", "mrs")],
	control = rpart.control(minbucket = 50))
		
single.tree <- prune(single.tree, cp = single.tree$cptable[which.min(single.tree$cptable[,"xerror"]), "CP"])
windows()
plot(single.tree, uniform = TRUE, margin = 0.2)
text(single.tree, use.n = TRUE)

# --------------------------------------------------------------------------
# 3. Random Forest model
# --------------------------------------------------------------------------
fit.rf <- randomForest(
	Survived ~ ., 
	data = titanic[,c("Survived", "Pclass", "Sex", "Embarked", "SibSp", "Parch", "Age", "Fare", "miss", "mrs")], 
	ntree = 500, proximity = FALSE, keep.forest = TRUE, importance = TRUE)

imp.ratings <- data.frame(var = rownames(fit.rf$importance), inc.mse = fit.rf$importance[,1], stringsAsFactors = FALSE)
imp.ratings <- arrange(imp.ratings, inc.mse)
imp.ratings$var <- factor(imp.ratings$var, levels = imp.ratings$var, ordered = TRUE)

windows()
ggplot(imp.ratings) + 
geom_bar(aes(x = var, y = inc.mse)) + 
coord_flip()

# --------------------------------------------------------------------------
# 4. Association rules model
# --------------------------------------------------------------------------
trans <- titanic[,c("Survived", "Pclass", "Sex", "Embarked", "SibSp", "Parch", "Age", "Fare", "miss", "mrs")]

trans$Age <- cut(trans$Age, quantile(trans$Age, probs = c(0, 0.1, 0.9, 1)), include.lowest = TRUE, labels = FALSE)
trans$Fare <- cut(trans$Fare, quantile(trans$Fare, probs = c(0, 0.1, 0.9, 1)), include.lowest = TRUE, labels = FALSE)

trans <- mutate(trans,
	Survived = ifelse(Survived == 1, "Yes", "No"),
	SibSp = ifelse(SibSp > 0, "Yes", "No"),
	Parch = ifelse(Parch > 0, "Yes", "No"),
	Age = ifelse(Age == 1, "Child", ifelse(Age == 2, "Adult", "Elderly")),
	Fare = ifelse(Fare == 1, "Super Saver", ifelse(Fare == 2, "Economy", "Delux")),
	miss = ifelse(miss == 1, "Yes", "No"),
	mrs = ifelse(mrs == 1, "Yes", "No"))

trans <- as.data.frame(apply(trans, 2, as.factor))

rules <- apriori(trans, 
	parameter = list(minlen = 2, support = 0.05, confidence = 0.8),
	appearance = list(rhs = c("Survived=No", "Survived=Yes"), default = "lhs"),
	control = list(verbose = TRUE))

# have 218 rules!
inspect(head(rules))

# some appear to be redundant; toss em
subset.matrix <- is.subset(rules, rules)
subset.matrix[lower.tri(subset.matrix, diag = TRUE)] <- NA
redundant <- apply(subset.matrix, 2, sum, na.rm = TRUE) > 0

rules.pruned <- rules[!redundant]
# 11 rules left; that's more like it

inspect(rules.pruned)

# visualize
plot(rules.pruned, method="graph", control=list(type="items", arrowSize = 0.5, alpha = 1))