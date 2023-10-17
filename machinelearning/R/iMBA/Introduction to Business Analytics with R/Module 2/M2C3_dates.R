############ WORKING WITH DATES IN R ###############
# Introduction----
# Understanding and knowing how to deal with dates and times is important
# because many data sets have a date or time stamp. 

# Dates and times are a big topic. Some of the complicating factors include:
# differences in formats, time zones, inconsistent number of days in some
# periods (like months, quarters, and years). We're not going to cover all of
# these topics in this lesson, but hopefully we'll give you some tools to
# deal with many scenarios and help you know where you can find more help

# Date format----
# There are a wide variety of ways in which dates are displayed. For instance, in the US, the date
# of April 3, 2005 is often written as it is in this sentence with month, day,
# and then year. It's often abbreviated as 04/03/05. 
# However, some locations and organizations use the day, month, year convention:
# 03/04/05. While others may use year, month, day convention: 05/04/03.
# Without some context it's impossible for a human or a computer to infer what
# format is being used.

# To reduce confusion, a standardized format that is often used is the ISO 8601 
# format. ISO stands for International Organization for Standardization. 
# This format follows the convention of yyyy-mm-dd for dates.

# The ISO 8601 standard for time is similar to dates: yyy-mm-dd hh:mm:ss. UTC
# stands for Coordinated Universal Time. It is at 0 degrees longitude. If not
# explicitly indicated otherwise, times are converted to that time zone. We'll
# save further discussion about time zones for you to investigate on your own.

# Since we use dates to measure quantities of time, a date format in R has two
# parts. The first part is the way it's displayed, which was just mentioned. 
# The second part of a date format is to store it as a numerical value so that
# temporal quantities can be calculated, like how much time has passed.
# In programming languages, dates are typically stored in an integer format that
# represents the number of days that have passed since January 1, 1970.

# Times are stored as the number of seconds that have passed since an epoch.

# Using the base functions in R (and other programming languages) to deal with 
# dates and times is cryptic and hard to remember.

# Examples of date format vs character and numeric format----
date1Words <- 'April 3, 2005'              # Character string format
date1Short <- '04/03/05'                   # Character string format
date1Numeric <- 040305                     # Numeric format

# You can use the as.Date function to convert to a date format
# Be sure and read the documentation about strptime to keep track of the symbols
# used with the format argument.
?as.Date
d1w <- as.Date(date1Words, format = '%B %d, %Y')         # This works
d1s <- as.Date(date1Short, format = '%m/%d/%y')          # This works
d1n <- as.Date(date1Numeric, format = '%m%d%y')          # This does not work. It's trying to calculate 40,305 days since an epic
d1n <- as.Date(date1Numeric, origin = '1970-01-01')      # This converts it to a date format, but the wrong date: 2080-05-08

# Kind of a lot to remember. lubridate makes it much simpler: ymd, or mdy, or ymd_hms...

# Lubridate package----
# The lubridate package makes it easier to convert date and time character 
# strings to date and time types.
install.packages('lubridate')              # Install the package if you haven't already done so in your project.
library(lubridate)                         # Load the functions in the package
d1w <- mdy(date1Words)                     # This works
d1s <- mdy(date1Short)                     # This works
d1n <- mdy(date1Numeric)                   # This works, too!
ymd('2005-04-03')                          # Alternative ordering is easy to remember

# Let's try converting times to a date time format
t1w <- mdy_hms('April 3, 2005 10:20:45')   # This works. Notice the hms at the end.
t1w2 <- ydm_hms('2005, 03 April 10:20:45') # Lubridate understands this unusual format
t1s <- ymd_hms('05/04/03 10:20:45')        # ISO ordering, but not fully correct still works
t1n <- dmy_hm('030405T10:20')              # Notice no seconds and the T separating the time. Still works, but assumes seconds are 0.

# Much simpler!
# Calculating differences in dates and times----
d1n + 28                               # Adds 28 days and returns the date
t1n + 28                               # Adds 28 seconds and returns the time

bom <- ymd('2000-01-01')               # Create a date object for the first day of the millenium
daysSince2000 <- d1n - bom             # Calculates difference in days
class(daysSince2000)                   # Notices that it's not a numeric type
as.numeric(daysSince2000)              # Can convert to a numeric type for additional calculations

t1s - t1n                              # Calculates the number of seconds between two times. Can also be converted to a numeric type.

difftime(d1n, bom, units = 'weeks')    # Use the difftime function to calculate time differences in other units

# Extracting elements from a date/time----
# Often times we want to know the year, day of the month, or day of the week
# for a date. We may want to know the hour of the day or minue of the hour
# for a time. Lubridate makes it very intuitive to get those elements.

year(d1n)                  # Extracts just the year as a number
month(d1n)                 # Extracts the month as a number
month(d1n,label = T)       # Extracts the month with a label (We'll talk about factor types in another lesson)
day(d1n)                   # Extracts the day of the month as a number
wday(d1n)                  # Extracts the day of the week as a number
wday(d1n,label = T)        # Extracts the day of the week with a label
hour(t1s)                  # Extracts the hour of the day as a number
minute(t1s)                # Extracts the minute of the hour as a number
second(t1s)                # Extracts the second of the minute as a number


############### USING TIME FUNCTIONS WITH BUSINESS DATA ###################
# Read in items data and convert Time to date time type----
setwd("C:\\Users\\Raghavendra.Kulkarni\\Documents\\GitHub\\R-Hands-on\\iMBA\\Introduction to Business Analytics with R\\Module 2\\")

df <- read.csv('jan17Items.csv'
               , stringsAsFactors = F
               )
class(df$Time)
summary(df$Time)
df$Time <- ymd_hms(df$Time)
class(df$Time)
summary(df$Time)
# Calculate a new column: day of the week----
df$wday <- wday(df$Time, label = T)
class(df$wday)
summary(df$wday)

# Calculate a new column: hour of the day----
df$hod <- hour(df$Time)
class(df$hod)
summary(df$hod)

