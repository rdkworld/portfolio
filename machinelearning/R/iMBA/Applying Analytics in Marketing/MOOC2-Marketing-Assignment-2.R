
#############################################################
#
# Marketing Analytics Assignment 2.
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to perform a conjoint
# analyis.
#
# You will then be asked to interpret the # results.  
#
# For this assignment, you may use any resources necessary
# to be able to execute the code.  However, the interpretation 
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

library(mosaicData)
data("SaratogaHouses")
attach(SaratogaHouses)


#####################################################
# QUESTION 1: Use the str() command on SaratogaHouses

# Broadly describe the data.

#* 
dim(SaratogaHouses)
str(SaratogaHouses)
#*

#Answer : The dataset has 1728 observations and 16 variables. Some of the variabless are price, lotsize, age, 
# landvalue, livingarea, pctCollege. Rest can be got from str command
#* End Question 1
######################################################
# 
#####################################################
# QUESTION 2:
# First we will look at the impact of fuel type on the price.

# Make a box plot of price by fuel type using boxplot()

boxplot(price ~ fuel)


# What is the thick line in the middle of the box represent?
#Answer - Thick line in the middle of 3 box plots is the median price for each of the three fuel types - gas, electric, oi;




# What is the lower and upper edges of the box represent?
#Answer
#Upper edge represents 75th percentile of the price
#Lower edge represents 25th percentile of the price


#* Do the box plots look the same or difference.  Explain in one or two sentences.
#Answer - The box plots itself look the same but median price of houses with gas is more than median price of houses with oil as fuel type
#which is more than houses with electric fuel



#* End Question 2
######################################################

#####################################################
# QUESTION 3:
# 
# Run an ANoVA using Price and Fuel.  Save the results of the ANOVA analysis
# in a variable AOV1 and use the aov() function.
# Display the results using the summary() function
aov1 <- aov(price ~ fuel, data = SaratogaHouses)
summary(aov1)


# What is the null hypothesis?
#Answer - Null hypothesis is houses with different fuel types have same prices 

# What is the p-value for fuel?  Interpret the results.
#p-value for fule is 2e-16 which means it is significant. So, null hypothesis can be rejected. So, we can say houses with different fuel types
#do not have same prices


#* End Question 3
######################################################
# 

#####################################################
# QUESTION 4:
#
# Make a box plot of price by waterfront type using boxplot()
boxplot(price ~ waterfront)



# Do the boxplots look the same or different. Explain.
#The box plots are different. Clearly, house prices of houses with waterfront are high than those without waterfront. However, there are some
#outlier data for houses without waterfront but have high prices

# Run an ANoVA using Price and waterfront  Save the results of the ANOVA analysis
# in a variable AOV2 and use the aov() function.
# Display the results using the summary() function
aov2 <- aov(price ~ waterfront, data = SaratogaHouses)
summary(aov2)

# What is the null hypothesis?
#Null hypothesis is Housing prices of houses with waterfront is same as those without waterfront



# What is the p-value for waterfront?  Interpret the results.
#p-value is 1.21e-10 and is very less. So, it is signifiant, hypothesis can be rejected. i.e Prices of houses with waterfront is different than without


#* End Question 4
######################################################

#####################################################
# QUESTION 5:

# Run the following code

#The following code creates two column vectors. One with all
#the prices of houses that have a water front, and a column of prices
#of houses without water front.

PWithWater <- price[waterfront== "Yes"]
PWoutWater <- price[waterfront=="No"]
 
# Using PWithWater and PWoutWater, perfrom a t-test using t.test()
#Doing an unpaired two-sample t-test
t.test(PWithWater, PWoutWater, paired = F)

# What is the null hypothesis?
#Answer : Price of house with waterfront is same as prices of house without waterfront
#* 

# What is the p-value for the t-test?  Interpret the results.
#p-value is 0.001119 and is significant. So, null hypothesis should be rejected. i.e Prices of house with waterfront is NOT same as prices of houses
#without Waterfront

# Let's assume equal variances of the two groups. Perform a t-test assuming equal
# variances, e.g, t.test(x,y, var.equal=TRUE)

t.test(PWithWater, PWoutWater, paired = F, var.equal = TRUE)

# What is the null hypothesis?
#Answer : Price of house with waterfront is same as prices of house without waterfront if both housing prices have equal variance
#*

# What is the p-value for the t-test?  Intperet the results.
#p-value is 1.21e-10, significant, null hypothesis will be rejected. so, prices are not same
#*



#* End Question 5
######################################################
#####################################################
# QUESTION 6:
# 


# Run an additive ANoVA using Price, waterfront, and fuel.  Save the results of the ANOVA analysis
# in a variable AOV3 and use the aov() function.
# Display the results using the summary() function

# If we assume the two variables are independent, we can use the additive model.
aov3 <- aov(price ~ waterfront + fuel, data = SaratogaHouses)
summary(aov3)


# What is the p-value for waterfront?  Interpret the results.
#p value for both waterfront is  2.29e-11 and is signifcant. So, it predicts the price



# What is the p-value for fuel?  Interpret the results.
#p value for both fuel is  2e-16 and is signifcant. So, it predicts the price



#* End Question 6
######################################################
#####################################################
# QUESTION 7:
# 


# Run an two-way ANoVA using Price, waterfront, and fuel with interaction.
# Save the results of the ANOVA analysis
# in a variable AOV4 and use the aov() function.
# Display the results using the summary() function

# The command below is equivalent to anova3
aov4 <- aov(price ~ waterfront + fuel + waterfront:fuel, data = SaratogaHouses)
summary(aov4)


# What is the p-value for waterfront?  Interpret the results.
#p-value for waterfront is 2.18e-11 and is significant. i.e predicts the price


# What is the p-value for fuel?  Interpret the results.
#p-value for waterfront is < 2e-16 and is significant. i.e predicts the price


# What is the p-value for the interaction of fuel and waterfront?  Interpret the results.

#p-value for interaction term is 0.0513 and > 0.05. So, it is not significant, does not predict the price


# Run the following

interaction.plot(waterfront,fuel,price)

#Interpret the plot as best as you can. 
#Answer - This graph plots impact of fuel type and waterfront on price. Clearly, we can see prices of houses decrease as waterfront moves from Yes to No
#Additionally, price of house with fuel type gas is greater than those with oil than those with electri.



#* End Question 7
######################################################

