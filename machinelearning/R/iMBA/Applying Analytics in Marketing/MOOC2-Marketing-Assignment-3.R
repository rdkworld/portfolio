###############################################################
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to build a
# Logit model on a given set of data.
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
# 
#We will create a dataset for this assignment.  The code below will create a 
# data set with three variables x1, x2, and y.  The three column vectors will be
# stored in the dataframe called data.



set.seed(500)
x1 = rnorm(1000)
x2 = rnorm(1000)
z = 1 + 3*x1 + 5*x2        
pr = 1/(1+exp(-z))
y = rbinom(1000,1,pr)
data = data.frame(Y = y,X1 = x1, X2 = x2)

#####################################################
# QUESTION 1: Run a Logit regression to see how the variables X1 and X2
# impact Y. Use the glm() command ans store the results in 'model1'
### Start Code
model1 <- glm(y ~ x1 + x2, family=binomial (link = "logit"))

### End Code

# Run the following to get the results of your Logit regression.  Describe the results

summary(model1)

#Answers
#The coefficients of each of the independent variables(X1 and X2) determine to what extent they affect the odds of Y being 1
#Beta0 or Intercept is 1.2053, log odds of output (y=1) when x1 and x2 are zero
#Beta 1 is 2.9631 * x1 is the difference in log odds of output(y=) where x1 is not zero and x2 is zero
#Beta 2 is 5.1127 * x2 is the difference in log odds of output(y=) where x2 is not zero and x1 is zero

#Odds
#1) When x1=0 and x2=0 : log odds = Beta0 = 2.9631
#Odds = e ^ 2.9631 = 19.35
#probability of y=1 = 19.35/(1+19.35) = 0.95
#2) x1=non-zero and x2=0 : log odds = Beta0 + x1 (Beta1)
#Similarly, odds and probability can be calculated
#3) x2=non-zero and x1=0 : log odds = Beta0 + x1(0) + x2 (Beta2)
#Similarly, odds and probability can be calculated
#4) x1=non-zero and x2=non-zero : log odds = Beta0 + x1 (Beta1) + x2(Beta2)
#Similarly, odds and probability can be calculated



#####################################################
# QUESTION 2: Now that we have the coefficients for the variables.  
# Write down the regression equation for the model.
#Regression equation is
#log-odds of y=1 is 1.2053 + 2.9631x1 + 5.1127x2


# 1. Assume the following values for the independent variables: X1 = 0.3922, X2 = 0.0052

# Calculate the log odds and store in 'logodds1'

logodds1 <- 1.2053 + (2.9631 * 0.3922) + (5.1127 * 0.0052)
logodds1
# Calculate the odds and store in 'Odds1'
odds1 <- exp(logodds1)
odds1
# Calculate the the probability of Y = 1 and store in 'Probability1'
Probability1 <- odds1 / (1+odds1)
Probability1

# Run the following print command
print(paste("The log odds and probability of Y being 1 are", logodds1, "and", Probability1, "repectively."))


# 2. Assume the following values for the independent variables:  X1 = -0.8273, X2 = 0.02274


# Calculate the log odds and store in 'logodds1'
logodds2 <- 1.2053 + (2.9631 * -0.8273) + (5.1127 * 0.02274)
logodds2

# Calculate the odds and store in 'Odds1'
odds2 <- exp(logodds1)
odds2

# Calculate the the probability of Y = 1 and store in 'Probability1'
Probability2 <- odds1 / (1+odds1)
Probability2


# Run the following print command
  print(paste("The log odds and probability of Y being 1 are", logodds2, "and", Probability2, "repectively."))



