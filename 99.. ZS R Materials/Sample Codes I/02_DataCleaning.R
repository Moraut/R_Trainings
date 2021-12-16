#### 2) Data Cleaning in R ####

#### ####


#### Reading a csv file ####

outlet_sales <- read.csv("outlet_sales.csv", header = TRUE, stringsAsFactors = FALSE)
View(outlet_sales)
str(outlet_sales)

outlet_sales <- read.csv("outlet_sales.csv", header = TRUE, stringsAsFactors = FALSE, na.strings = "")
outlet_sales <- read.csv("outlet_sales.csv", header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA", "-", "#N/A"))




#### Data Cleaning ####

# Change all column names to small letters with "_" instead of "."
names(outlet_sales)

gsub(pattern = ".", replacement = "_", x = tolower(names(outlet_sales)))
# BEWARE OF THE REGULAR EXPRESSIONS!

names(outlet_sales) <- gsub(pattern = "\\.", replacement = "_", x = tolower(names(outlet_sales)))
names(outlet_sales)


#### Variable 'Cleaning' ####

# Column: brand_name
# Goal: small_letters with "_" instead of spaces

unique(outlet_sales$brand_name)
outlet_sales$brand_name <- gsub(pattern = " ", replacement = "_", x = tolower(outlet_sales$brand_name))
unique(outlet_sales$brand_name)




# Column: product_code
# Goal: Convert into zero padded string

outlet_sales$product_code <- paste0("P_",sprintf("%010d", outlet_sales$product_code))


# Column: sales_dollars
# Goal: Convert accounting format into numeric format

outlet_sales$sales_dollars <- gsub(pattern = ",", replacement = "", x = outlet_sales$sales_dollars)
outlet_sales$sales_dollars <- gsub(pattern = "\\$", replacement = "", x = outlet_sales$sales_dollars)
outlet_sales$sales_dollars <- gsub(pattern = "\\(", replacement = "-", x = outlet_sales$sales_dollars)
outlet_sales$sales_dollars <- gsub(pattern = "\\)", replacement = "", x = outlet_sales$sales_dollars)

outlet_sales$sales_dollars <- as.numeric(outlet_sales$sales_dollars)

# Column: sales_dollars_1
# Goal: Convert accounting format into numeric format

# Peeking into regular expressions...

outlet_sales$sales_dollars_1 <- gsub(pattern = "[,\\$\\(\\)]", replacement = "", x = outlet_sales$sales_dollars_1)
outlet_sales$sales_dollars_1 <- gsub(pattern = "[:punct:]", replacement = "", x = outlet_sales$sales_dollars_1)
outlet_sales$sales_dollars_1 <- as.numeric(outlet_sales$sales_dollars_1)





# Column: outlet_bp_id
# Goal: Zero padding

outlet_sales$outlet_bp_id <- sprintf("%115d", outlet_sales$outlet_bp_id)





# Column: Outlet_hierarchy
# Goal: Convert into ORDINAL factors
unique(outlet_sales$outlet_hierarchy)

sort(unique(outlet_sales$outlet_hierarchy))

str(outlet_sales)
outlet_sales$outlet_hierarchy <- factor(outlet_sales$outlet_hierarchy, levels = c("Hierarchy 1", "Hierarchy 2", "Hierarchy 3"))
str(outlet_sales)

outlet_sales$outlet_hierarchy <- factor(outlet_sales$outlet_hierarchy, levels = c("Hierarchy 1", "Hierarchy 2", "Hierarchy 3"), ordered = TRUE)
str(outlet_sales)






# Column: outlet_zip_code5
# Goal: Zero padding

outlet_sales$outlet_zip_code5 <- sprintf("%05d", outlet_sales$outlet_zip_code5)





# Column: date
# Goal: small_letters with no "_" instead of spaces

outlet_sales$date <- strptime(outlet_sales$date, format = "%m/%d/%Y")

# More about Date Handling later...





# Column: random_percentage
# Goal: Convert it into numeric format

outlet_sales$random_percentage <- as.numeric(gsub(pattern = "\\%", replacement = "", x = outlet_sales$random_percentage))/100
str(outlet_sales)



#### Taking care of NAs ####


sum(outlet_sales$sales_dollars)

# Are there NAs in the data
is.na(outlet_sales)


# How many NAs are there in the data?
sum(is.na(outlet_sales))

sum(is.na(outlet_sales$sales_dollars))
#... how to check this for every column at one go?.... wait for the apply family

sum(outlet_sales$sales_dollars, na.rm = TRUE)


## Use of complete.cases

complete.cases(outlet_sales$sales_dollars)

sum(complete.cases(outlet_sales$sales_dollars))
sum(!complete.cases(outlet_sales$sales_dollars))


outlet_sales_new <- outlet_sales[complete.cases(outlet_sales$sales_dollars), ]




















