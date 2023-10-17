############ STACKING DATA #############
# Many datasets are created by combining observations together from smaller 
# datasets if the data is stored in different files. This may also occur when 
# you split the data into smaller segments, apply a transformation, and then 
# join it together again.
# The cbind function joins columns of data together. The rbind function joins
# rows of data together.

# Read in the three files: jan17Items.csv, feb17Items.csv, mar17Items.csv----
# First download the three files, and store them in a meaningful location. 
# If you're using RStudio Cloud, upload the files to the project using the Files
# pane. If you're using RStudio on your personal machine, set the working
# directory to the folder where the files are stored using the setwd() function
# or by using the Files pane.

j <- read.csv('jan17Items.csv', stringsAsFactors = F)     # Reads in January data
f <- read.csv('feb17Items.csv', stringsAsFactors = F)     # Reads in February data
m <- read.csv('mar17Items.csv', stringsAsFactors = F)     # Reads in March data

# Stack the rows of data together using rbind----
# In this case, we want to use the rbind function to add all the rows of data
# into one file.
?rbind                                          # Look at the documentation

allItems <- rbind(j, f, m)                      # Binds the three dataframes into a new dataframe by stacking them on top of each other
str(allItems)                                   # Visually inspect the newly created dataframe
nrow(allItems) == nrow(j) + nrow(f) + nrow(m)   # Make sure that the row number is equal to the sum of the three individual dataframes.

# Stack columns together using cbind----
# First, break the allItems dataframe into two separate dataframes
leftSide <- allItems[,c(1:12)]              # Put the first 12 columns into a new dataframe, leftSide
rightSide <- allItems[,c(13:24)]            # Put the last 12 columns into a new dataframe, rightSide

str(leftSide)                               # Visually inspect to see if it's what you thought it would/should be
str(rightSide)                              # Visually inspect to see if it's what you thought it would/should be

# Now join the columns of data together
allItems2 <- cbind(leftSide, rightSide)     # Create a new dataframe, allItems2 by stacking columns next to each other

############## NOTES ABOUT CBIND AND RBIND ###################
# Before joining rows and columns, you'll need to make sure that the datasets
# share certain characteristics, or else an error will be triggered.
# rbind only works if the number of columns and column names are the same----
test <- rbind(leftSide, rightSide)          # An error is triggered when none of the column names are the same
test <- rbind(j, leftSide)                  # An error is triggered even though some of the column names are the same

# rbind coerces column type to character if there's a discrepancy----
# If the column names are the same, but the types are different, then some of the
# observations are coerced so that they're all the same type. If there's a 
# difference in column type, it usually gets coerced to be a character type.

f2 <- read.csv('feb17Items.csv')    # Read in the February data, and leave the default setting of strings being converted to factors
str(f2)                             # Notice all of the factor types
str(j)                              # Recall that the j dataframe has character types instead of factor types.
test <- rbind(j,f2)                 # All of the column names are the same, so it stacks the rows together
str(test)                           # Notice that there are no factor types. They were coerced to character.

# cbind only works if the number of rows is equal----
ctest <- cbind(j,f)                 # An error is triggered, which indicates that the row numbers are different.

############# ADDING AND DROPPING COLUMNS TO A DATAFRAME ###############
# You may want to add a column of data so that you can stack rows together. 
# Create a new column of sequential numbers----

j13 <- j[,1:3]                    # Create a subset of j that only includes the first three columns
f24 <- f[,2:4]                    # Create a subset of f that only includes columns two through four
jf24 <- rbind(j13,f24)            # Try stacking the data using rbind. An error is triggered.
names(j13)                        # Inspect the names of j13
names(f24)                        # Inspect the names of f24 and visually confirm similarities and differences
# names(j13) %in% names(f24)        # Find out which column names of j13 are in f24.
# setdiff(names(j13), names(f24))   # This is a new function. It compares the contents and returns what is in j13, which is not in f24.
# setdiff(names(f24), names(j13))   # Similar to the above function, but this returns what is in f24 that is not in j13.
j13$Time <- NULL                  # Drops the Time column from j13
j13$StoreCode <- 1:nrow(j13)      # Creates a new column in j13 equal to a series of numbers from 1 to the number of rows in j13
jf24 <- rbind(j13, f24)           # Successfully stacks the rows together
str(jf24)                         # Visually inspect the structure

# Create a new column of NAs using the rep function----
# The rep function repeats a value or set of values multiple times, and comes in
# very handy.
?rep                              # Read the help documentation

rep(NA, 5)                        # Creates a vector of five NA values
rep(1:3, 2)                       # Creates a vector that repeats 1 through 3 twice
j13$StoreCode <- rep(NA, nrow(j13))  # Replaces the StoreCode column with a column of NAs
jf24 <- rbind(j13, f24)           # Binds the rows of j13 and f24 together
str(jf24)                         # Visually inspect the structure

# Note: There are simpler ways to manipulate dataframes.In another lesson you'll
# learn about simpler ways to accomplish these and other data manipulation tasks
# using functions created by others. However, this is an opportunity to illustrate
# how you can use base functions in a creative way. Hopefully, it will also help 
# you appreciate the simpler ways.