############## WORKING WITH FACTORS IN R #################
# Explanation of factors----
# We can't do much analysis with character strings. They first need to be
# converted to a numeric type. However, we'd still like to retain the intrinsic
# meaning of the character string. Factors are a way to retain the intrinsic 
# meaning, but to store it as a numeric type for analysis. The factor type is
# really important when you get further into data visualization.

# Coercing to factor----
x <- c('fox', 'hound', 'hound')     # A character vector
summary(x)                          # We don't get much information about the  vector
plot(x)                             # Can't explore it visually
xf <- factor(x)                     # Coerce the character vector to a factor vector
summary(xf)                         # Tells us the two levels and the frequency of each
plot(xf)                            # Quick visual exploration is possible

# You may have noticed the ordered factor type when working with dates----
# Read in the jan17Items data
df <- read.csv('jan17Items.csv'
               , stringsAsFactors = F
               )
df$Time <- lubridate::ymd_hms(df$Time)   # Convert Time to a time type
df$wday <- wday(df$Time, label = T)      # Create a new column for day of the week
class(df$wday)                           # Notice the ordered factor type
summary(df$wday)                         # The summary is really helpful

# Another example of how character strings are hard to analyze----
class(df$Category)            # Character string
summary(df$Category)          # Not a very helpful summary
unique(df$Category)           # Unique function prints the unique values. We can count them up
plot(df$Category)             # Can't plot it

# Factors are  helpful for analysis----
df$Category2 <- factor(df$Category)      # Create a new factor column for comparison
str(df$Category2)                        # We can see the number of levels
summary(df$Category2)                    # Default order is alphabetic
plot(df$Category2)                       # We can plot it. Defaults to alphabetical order.
# Order is not ideal
# Forcats package----
install.packages('forcats')
library(forcats)

# Convert to factor and order by frequency----
?fct_infreq                                       # Look at how to use it. Also take a look at the fct_inorder and fct_inseq
df$Category3 <- forcats::fct_infreq(df$Category)  # Create a new factor column for comparison
str(df$Category3)                                 # Same number of levels
summary(df$Category3)                             # Notice the summary starts with the largest and ends with the smallest
plot(df$Category3)                                # More helpful ordering of the plot

# You can lump least frequent levels together----
# If there are too many levels, let's keep the top three and group the rest into
# a single level.
?fct_lump                                                # Read the documentation.
df$Category4 <- fct_lump(df$Category, n = 3)             # Create a new factor column for comparison
summary(df$Category4)                                    # Notice that there are only four levels, now
plot(df$Category4)                                       # Plots the levels, but not in the ideal order
df$Category4 <- fct_infreq(fct_lump(df$Category, n = 3)) # Combine the fct_lump with fct_infreq to create a better order
summary(df$Category4)                                    # Descending order
plot(df$Category4)                                       # Better plot

# You can relevel by hand----
# In this case, I'd like it in descending order, but with the Other level to 
# come at the end. I'll make a custom order.
?fct_relevel                  # Read the documentation

# Use the fct_relevel function to create a custom order. Notice that I left off
# Other and it knew where to put it.
df$Category5 <- fct_relevel(df$Category4, 'Salmon and Wheat Bran Salad', 'Chicken', 'general')
plot(df$Category5)        # That's the order I want

# There are other functions that will be more meaningful once you start
# creating aggregations of the data, such by reordering by the level of another 
# variable.
