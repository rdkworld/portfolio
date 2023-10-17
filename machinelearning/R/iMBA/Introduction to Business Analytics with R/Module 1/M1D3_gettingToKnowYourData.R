############ GETTING TO KNOW YOUR DATAFRAME AND YOUR DATA ###############
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

# Explore the structure of the df and dfw dataframes----
# Let's look at several ways to explore the dataframes
# One powerful way is to click on the table icon to the far right of the dataframe
# name in the Environment window. This will open an Excel-like view of the data
# that you can visually explore to get a feel for what the data is like.
# You can even use the drop-down arrows next to the column label to sort the data
# based on the values of a column, or use the built in Filter tool to show only
# data that meets certain filtering criteria. Another handy thing about this

# You can also get a preview of the dataframes by clicking on the arrow next
# to the name of the dataframe in the Environment window. It will list the name
# of every column, the type of data (we'll talk about that in another lesson),
# and some of the values. You can get this same information, as well as the type
# of the object.

str(df)           # This tells you the structure of the Items dataframe.
str(dfw)          # This tells you the structure of the Weather dataframe.

# If you just want the number of rows and columns, then you can use the functions
# below.

dim(df)           # Returns a vector with the number of rows, and the number of columns.
nrow(df)          # Returns the number of rows.
ncol(df)          # Returns the number of columns.

# Sometimes you just want to know the names of the columns in the dataframe.
# You can find that out by using the names function.

names(df)         # Returns a vector with only the column names

# Referencing and subsetting vectors by location----
v1 <- c(18, 19, 20, 21, 22, 23)     # Create a vector of six numbers

# Use brackets and location to extract specific numbers from the vector.
v1[1]             # Extracts the number from the first spot in the vector.
v1[3]             # Extracts the number in the third spot in the vector.
v1[2:4]           # Extracts the numbers from spots 2 through 4 in the vector.
v1[-1]            # Removes the number in the first spot.
v1[c(1,5)]        # Extracts the numbers from spots 1 and 5 in the vector.
v2 <- v1[c(3,6)]  # Extracts the numbers from spots 3 and 6 and saves them in a new vector.


# Referencing and subsetting dataframes by location----
# Referencing dataframes is similar to referencing vectors. However, since
# dataframes have two dimensions (rows and columns), we first refer to the rows,
# and then use a comma to indicate that the second reference is to the columns.

dfw[1:5, 1:3]         # Extracts the first five rows, and first three columns
dfw[1:5,]             # Extracts all columns of the first five rows
dfw[,c(1,3)]          # Extracts all rows for the first and third column
dfw[1:5,c(-1, -3)]    # Extracts the first five rows and removes columns one and three.
dfw2 <- dfw[,1]       # Extracts all observations of the first column and converts it to a vector, and saves it in dfw2.

# Referencing and subsetting dataframes by column name----
# You can use the $ sign to refer to named elements of a dataframe.

dfw$date                    # Extracts all observations of the date column and converts it to a vector
dfw[1:5,c('date', 'PRCP')]  # Extracts the first five rows of the date and PRCP columns
df$UPC <- NULL              # Drops the UPC column from the df dataframe

# Explore the shape of the data----
# Learning about the shape of the data in the dataframe is also really easy to
# do in R.

# You can get summary statistics about a every column of data by using the summary
# function.

summary(df)       # Returns summary statistics for each numeric column in the Items dataframe.
summary(dfw)      # Returns summary statistics for each numeric column in the Weather dataframe.

# Get a summary of a subset of the columns
summary(df$Price)                     # Returns summary statistics for the Price column in the df dataframe.
summary(df[,c('Price', 'Quantity')])  # Returns summary statistics for the Price and Quantity columns.


# Visually explore the shape of the data----
# There are some quick plotting functions that allow you to get a quick visual
# idea of how the data is distributed.

hist(dfw$TMAX)                          # Histogram of the TMAX column in the dfw dataframe
boxplot(dfw$TMAX)                       # Boxplot of TMAX
plot(dfw$TMAX)                          # Scatter plot of TMAX. X-axis is the index.
plot(dfw$TMAX, type = 'l')              # Line plot of TMAX. X-axis is the index.
plot(dfw$TMIN, dfw$TMAX)                # Scatter plot of TMAX (y-axis) by TMIN (x-axis)
plot(dfw[,c('TMIN', 'TMAX', 'PRCP')])   # All two-way scatter plot combinations for three columns 

# There are other parameters that allow you to customize the look of these plots.
# However, you'll learn about more advanced plotting capabilites in another lesson.

