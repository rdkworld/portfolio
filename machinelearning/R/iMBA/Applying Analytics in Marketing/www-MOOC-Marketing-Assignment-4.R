
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


# Attribute 1 is: 
# Attribute 2 is: 
# Attribute 3 is: 
# Attribute 4 is: 


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




#* End Question 2
######################################################

#####################################################
# QUESTION 3:
# Use the caPartUtilities() function to obtain the utilities provided
# by each factor level to the respondents.


# Describe the profile that customer 1 (first row) likes best.




#* End Question 3
######################################################
# 
#####################################################
# QUESTION 4: Use the conjoint() command to run the full
#conjoint analysis


# What are the factors in order of average importance?

# Which flavor is most preferred?


# Which flavor is least preferred?



# Which price (discount) is most preferred?  and least preferred?



# Do customer prefer a cup or a cone?



# Do customers prefer topppings or not?


# What is the most popular combination (profile)?



# What is the least popular profile?




#* End Question 4
######################################################
