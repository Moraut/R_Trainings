#### 3) Date Handling in R ####

#### ####



#### Loading Libraries ####
library(lubridate)


#### 2) Handling Dates in R ####

# R defines a Date datatype to handle date objects  
# Using 'as.Date' Function for character inputs, the output is a Date object internally stored in integer format  

date_1 <- c("2-January/2009","23-June/2007")
date_format <- as.Date(date_1, format = '%d-%B/%Y')
date_format <- format(date_format, format = '%d-%b-%Y')

?strftime


# Working with lubridate Package

# Reading dates as Date-Month-Year or Month-Date-Year Format
date_dmy <- dmy("01-10-2010")


# Extracting information from the date

outlet_sales$year <- year(outlet_sales$date)
outlet_sales$month_num <- month(outlet_sales$date)


# Extracitng more information of Date and Time
nowdate <- now()
year(nowdate)

month(nowdate,label = TRUE)
month(nowdate,label = TRUE, abbr = FALSE)

yday(nowdate)

week(nowdate)
wday(nowdate)
weekdays(nowdate)
weekdays(nowdate, abbreviate = T)

day(nowdate)

hour(nowdate)
minute(nowdate)
second(nowdate)



# Using parse_date_time
x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
parse_date_time(x, c("ymd", "ymd HM"))



# Creating Time Sequence
days_2015 <- seq(ymd("2015/01/01"), ymd("2015/12/31"),  by = "day")
month_2015 <- seq(ymd("2015/01/01"), ymd("2015/12/31"),  by = "month")
week_2015 <- seq(ymd("2015/01/01"), ymd("2015/12/31"),  by = "week")


# Updating / Manipulating the date
month(nowdate) <- 5
month(nowdate) <- month(nowdate) - 3

update(nowdate,year = 2020 , month = 1, day = 10)

nowdate <- nowdate + hours(13)




# Introduction to Intervals

halloween <- ymd("2015-10-31")
christmas <- ymd("2015-12-25")

# Interval No. 1
halloween_christmas <- interval(halloween,christmas)
halloween_christmas

halloween %--% christmas
class(halloween %--% christmas)
as.period(halloween %--% christmas)
as.duration(halloween %--% christmas)


dusshera <- ymd("2015-10-22")
diwali <- ymd("2015-11-11")

# Interval No. 2
dusshera_diwali <- dusshera %--% diwali



# Does any part of this interval overlaps?
int_overlaps(halloween_christmas, dusshera_diwali)


# How much of an overlap is it?
intersect(halloween_christmas, dusshera_diwali)

as.duration(intersect(halloween_christmas, dusshera_diwali))
# Gives an interval as an output

# you can do set operations on this...



# Other operations for interval class
int_start(halloween_christmas)
int_flip(dusshera_diwali)

# Does 23rd Nov 2015 lies between Halloween and Christmas
as.Date("2015-11-23") %within% halloween_christmas



# Introduction to Durations
dminutes(23)
dweeks(2)


# How many days between Halloween and Christmas
halloween_christmas / ddays(1)

as.period(halloween_christmas)
as.period(halloween_christmas, unit = "day")



