######### INTRODUCTION TO OTHER DATA TYPES ##########3
# To this point we've talked about numeric vectors and dataframes.
# You've probably noticed that not all columns of a dataframe are numeric.

# Read in data----
# If you haven't already done so, begin by reading in the jan19Items.csv and 
# the jan19Weather.csv files.
setwd("C:\\Users\\Raghavendra.Kulkarni\\Documents\\GitHub\\R-Hands-on\\iMBA\\Introduction to Business Analytics with R\\")
df <- read.csv('jan17Items.csv'        
               , sep = ','             
               , stringsAsFactors = F  
               )

dfw <- read.csv('jan17Weather.csv'
                , sep = '\t'
                , stringsAsFactors = F
                )

# Consider other data types----
# Character strings: Many of the columns of data are chr type in the df dataframe.
# If you try to perform mathematical operations on them, it won't work. Dealing
# with strings is really important. You'll learn more about them in another lesson(s).

x <- 'fox'                  # A character vector of length 1
y <- c('fox', 'hound')      # A character vector of length 2
mean(df$CashierName)        # An error is triggerd because CashierName is a character vector.

# Dates and Times: You'll notice the the Time column is clearly a time stamp of 
# when the transaction occurred. There are several other formats for dealing with
# dates and times. It's a big topic and we'll cover it in another lesson.

# Factors: Recall how when we read in the data, we manually set the parameter,
# StringsAsFactors = FALSE? That's because R is built for statistics. All of the
# machine learning algorithms operate based on numeric data. So, character strings
# have to be converted to some type of numeric data. R assumes that you want to
# make that conversion from the beginning, which is typically not a good assumption,
# so it converts them to factors. Factors are basically qualitative values with
# a certain number of levels. Try reading in the weather data and set the 
# stringsAsFactors parameter equal to TRUE. Then look at the structure of the
# dataframe, focusing on the date column.

dfw2 <- read.csv('jan17Weather.csv'
                , sep = '\t'
                , stringsAsFactors = T
                )

str(dfw2)       # Notice that the date column is a Factor type with 31 levels, one for each day of the month

# For now, the important thing is to keep character strings as chr type.

# Integers: Are treated similarly to num types. Num types can have decimals. They're
# also known as doubles, and go out to 15 decimal places. Because numeric values
# go out so many decimal places, it can save a lot of memory to store them as integers.
# Thus, if every element of a vector is an integer, R defaults to integer. However,
# if even one value has a decimal, then all values will be coerced to a numeric.


# Coercion----
# There are various ways to convert data to different data types. One way to convert
# numeric variables to strings is to put quotation marks around them. 

a = 5         # A numeric vector of length 1
b = '5'       # A character vector of length 1

# Some coercion occurs automatically. Consider the following example of creating
# a numeric vector that includes a string.
v1 <- c(1,3,5)              # Automatically stored as a numeric vector
v2 <- c(1,3,'5')            #  One string signals R to coerce all values to strings.

# You can coerce a vector of strings to numeric values using the as.numeric function.
v3 <- as.numeric(v2)        # If a string is clearly a numeric character, it's coerced to a numeric value.
v4 <- as.integer(v2)        # Can also coerce to integer vector

# Consider NA and NaN----
# If coercing a vector from a character to numeric and a non-numeric string exists, 
# then it will  be replaced with NA, which means not applicable, or that there's 
# not a value recorded.

v5 <- c(1,3,'five')         # Character vector
v6 <- as.numeric(v5)        # Notice that five was converted to NA

# NaN means that a number does not exist, such as 0/0
v7 <- c(1, 7/3, 0/0)      # Notice that 0/0 is converted to NaN

# You can manually enter NA and NaN
v8 <- c(1, 7/3, NaN, NA)  # Notice how special words are blue.

# NaN and NA are treated the same way, and you have to explicitly tell most functions
# to ignore them or else an error will be triggered. 

summary(df$Price)           # Notice that 200 values are NA's
mean(df$Price)              # R's default is often to try and include NA and NaN in calculations, resulting in errors.
mean(df$Price, na.rm = T)   # Explicitly tell R to remove NA and NaNs from calculations.
min(df$Price, na.rm = T)
