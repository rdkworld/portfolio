########## LOOPS ###########
# Loops are a powerful way to complete repetitive tasks. We're going to focus
# on for loops since they're used most often. The syntax is similar
# to conditional statements: for(number of iterations){task to complete}

# How do you determine the number of iterations? You have to input a vector, and
# then define a nominal name for the element of a vector.

# Creating a vector that's a sequence of numbers----
# Recall from indexing elements of a vector, that you can create a vector that
# is a sequence of numbers by using starting point:ending point.
1:5         # Create a vector of numbers 1 through 5
4:100       # Create a vector of numbers 4 through 100
5:1         # Create a vector of numbers 5 through 1


# Simple for loop----
# Use a descriptive name to indicate what the variable in the iteration represents.
# The letter i is often used, for index, or iteration. However, any number can
# be used.

# This loop will print i
for(i in 1:5){
  print(i)
}

# This does the same thing, but instead of using i, I used the random letters xuz.
# The point is that you can use any name. Try to make it descriptive so that
# when you come back to your code, or when someone else looks at it, it will be
# easier to understand.
for(xuz in 1:5){
  print(xuz)
}

# Business analytic application of loops: Reading in data----
# Loops are used in numerous ways: reading or writing many data files, fetching
# data from web resources like APIs, performing tests on different batches of 
# observations.

# Here's an example of how to read in multiple data files. We're going to use
# the following files: jan17Items.csv, feb17Items.csv, jan17Weather.csv, and
# feb17Weather.csv. If you're using RStudio Cloud, make sure to upload data to 
# the project. If you're using RStudio on your personal machine, then make sure
# to save the files in the same folder and to set your working directory to that
# location. Recall that you can set your working directory using the setwd()
# function, or by using the Files pane.

# First, create a vector of file names to read in.
filesToImport <- c('jan17Items.csv', 'feb17Items.csv', 'mar17Items.csv')

# Second, create an empty dataframe to which we can stack the data.
allItems <- data.frame()

# Now the for loop
for(file in filesToImport){                       # For each file in the filesToImport vector...
  tempDf <- read.csv(file, stringsAsFactors = F)  # Read in the file, convert it to a dataframe, and name it tempDf
  allItems <- rbind(allItems, tempDf)             # Bind the rows to whatever rows already exist.
  print(file)                                     # Print a status update
}

str(allItems)                                     # Look at the number of rows to see if it looks big enough.
