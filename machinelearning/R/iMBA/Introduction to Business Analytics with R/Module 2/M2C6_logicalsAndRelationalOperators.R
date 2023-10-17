########## RELATIONAL OPERATORS ###########
# Logical, or Boolean, types are binary: either TRUE or FALSE----
x <- c(TRUE, FALSE, FALSE, FALSE, TRUE)
class(x)
summary(x)

# TRUE is equal to 1, False is equal to 0
plot(x)
sum(x)
# Greater Than and Less Than Comparisons----
# The result of comparison operators return a boolean value: TRUE or FALSE
20 > 40           # Returns FALSE
20 < 40           # Returns TRUE
20 <= 40          # Returns TRUE
20 >= 40          # Returns FALSE

# Equivalence Comparisons----
# To test if values are equal to each other, use two equal signs. One equal sign
# will attempt to assign a number to a value. You can use equivalence test for
# strings as well as numbers
20 = 40           # Notice the error in assignment message
20 == 40          # Returns FALSE
20 == 20          # Returns TRUE
'cat' == 'cat'    # Returns TRUE

# NA and NaN values require a special test.
20 == NA          # Returns NA
is.na(20)         # Returns FALSE
is.na(NA)         # Returns TRUE

# Not Equivalent Comparison----
# To test if values are not equal to each other, use !=
20 != 40          # Returns TRUE
'cat' != 'cat'    # Returns FALSE

# Vector Comparisons----
# You can also do a pairwise comparison of elements in vectors of the same length.
# It will return a vector of results.
v1 <- c(1,5)
v2 <- c(1,3)
v3 <- c(1,3,5)
v4 <- c(2,NA)
v1 == v2      # Returns a vector with values of TRUE FALSE
v1 > v2       # Returns a vector with values of FALSE TRUE
v1 == v3      # Returns an error because the vectors are different lengths.
v1 > v4       # Returns a vector with values of FALSE NA

# Test if an Item is in a Vector----
# A very handy comparison is to test of an item is in, or not in  a vector. 
# This is done be using %in% to test if an item is in a vector.
# Use ! along with %in% to test if an item is not in a vector.
1 %in% v1         # Returns TRUE because 1 is in v1
2 %in% v1         # Returns FALSE because 2 is not in v1
!1 %in% v1        # This tests if 1 is not in v1. Returns FALSE because 1 is in v1.
!2 %in% v1        # This tests if 2 is not in v1. Returns TRUE because 2 is not in v1.

# Business data applications----
# Read in the data
df <- read.csv('jan17Items.csv'
               , stringsAsFactors = F
               )
# Identify rows of data that meet a certain condition
df$Price > 15                                      # Returns a logical vector with TRUE, FALSE, or NA for each row
ldf <- df[df$Price > 15,]                          # Returns only the rows for which the price is greater than 15, or are NA
brdf <- df[df$Category %in% c('Beef', 'Rice'),]    # Returns only the rows that have a category of Beef or Rice
