
#############################################################
#
# Marketing Analytics Assignment 4.
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to perform a conjoint
# analyis.
#
# You will then be asked to interpret the # results.  
#
# For this assignment, you may use any resources necessary
# to be able to exectute the code.  However, the interpretation 
# should reflect your own thinking.
#
# You are to work on the problem alone, without help 
# from any other person.
#
# In this assignment, you will create a portfolio with only two
# stocks.  Use the sample code for reference.
###############################################################

# INSTRUCTIONS:  Enter your code between the comments line 
# as directed.  Comments begin with a hashtag '#'.

# For example

### Start Code

### End Code

# If you are asked to interpret results, make sure to put your
# answers in a comment line.

################################################################ 

###  required libraries  ###
# Run the following code to load the packages (libraries)
# If the library package does not load properly, make sure 
# that you have installed the package onto  your system.  
# Use the 'Packages' tab in RStudio to install the package.

library(conjoint)
data(ice)


#####################################################
# QUESTION 1: Use the str() command on iprof to
# get the 4 atributes
# Write down the 4 atributes here.  
# Note, Attribute is labeled price, but I think it means
# price discount - see if you agree with my interpretation.
str(iprof)

# Attribute 1 is: Flavour
# Attribute 2 is: Price (or Discount)
# Attribute 3 is: Container
# Attribute 4 is: Topping


#* End Question 1
######################################################
# 
#####################################################
# QUESTION 2:
# run the following:
ilevn

# This diplays the contents of the ilevn variable which
# contains the levels.

# For each level, match the attribute.  
# 
#chocolate - Flavour
#vanilla - Flavour
#Strawberry - Flavor
#$1.5 - Price
#$2.0 - Price
#$2.5 - Price
#cone - Container
#Cup - Container
#yes - Topping yes or no
#no - Topping yes or no



#* End Question 2
######################################################

#####################################################
# QUESTION 3:
# Use the caPartUtilities() function to obtain the utilities provided
# by each factor level to the respondents.
partutil <- caPartUtilities(y = ipref, x = iprof, z = ilevn)
partutil

# Describe the profile that customer 1 (first row) likes best.
#From the results of first row (Customer 1), Customer 1 likes Strawberry, price of $2 in a cup without 
#toppings (attributes chosen have higher values)


#* End Question 3
######################################################
# 
#####################################################
# QUESTION 4: Use the conjoint() command to run the full
#conjoint analysis
Conjoint(ipref, iprof, ilevn)

# What are the factors in order of average importance?
#Flavour(35.13), Price(31.39), Container(20.43) Toppint (13.05)


# Which flavor is most preferred?
#Strawberry is most preferred (0.5)


# Which flavor is least preferred?
#Vanilla ( -0.7222)


# Which price (discount) is most preferred?  and least preferred?
#$2.5 is most preferred, $1.50 is least preferred


# Do customer prefer a cup or a cone?
#Cup (0.9167)


# Do customers prefer topppings or not?
#Yes, prefer toppings (0.125)

# What is the most popular combination (profile)?
#The most popular profile is: Strawberry, $2.50 discount, in a cup with toppings.


# What is the least popular profile?
#Least popular profile is vanilla with price discount of $1.5 in a cone with no toppings




#* End Question 4
######################################################
