
### Logistic Regression ###

probs <- seq(0,1, by = .1)

odds <- probs/(1 - probs)

logodds <- log(odds)

tab1 <- cbind(probs,odds)

tab2 <- cbind(odds, logodds)

tab3 <- cbind(logodds,probs)



### repeat, for plot

probs <- seq(0,1, length = 100)

odds <- probs/(1 - probs)

plot(probs, odds, type='l')

logodds <- log(odds)

plot(odds, logodds, type='l')

plot(logodds, probs , type = 'l')


# graph of logit

x <- seq(-6,6,length = 100)

logisticfn <- exp(x)/(1 + exp(x))

plot(x, logisticfn, type = 'l')

#**********************************
#*********************************

# Example 1.

discount <- c(0,0,0,0,0,0,50,50,50,50,50,100,100,100,100,150,150,150,200,200)
buy <- c(0,0,0,1,0,0,0,1,0,0,1,1,1,0,1,1,0,1,1,1)

ex1 <-glm(buy~discount, family = binomial)
summary(ex1)



# Get data
current_working_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(current_working_dir)
data <- read.csv(file="cafe.csv",header = TRUE, sep = ",")
head(data, n=5)

# The data is taken from 
# DePaolo, C.A.,& Robinson, D. F.(2011). "Cafe data". Journal of Statistics Education, 19(1).
# https://www.tandfonline.com/doi/pdf/10.1080/10691898.2006.11910586

# I have modified their model by only taking the natural log of the dollar amount.
# I add one to the amount as log(0) undefined.

Amt1 = log(data$Amount+1) 
head(Amt1,n=5)

# fit logistic regression model
lr_model1 <- glm(Vote ~ REP + Amt1, family = binomial, data)
summary(lr_model1)


### Below is the code to run the model run in Preston's paper.
### See https://www.tandfonline.com/doi/pdf/10.1080/10691898.2006.11910586
# Transform Amount to log-transformation.  This transformation "express"
# how many digits are in the dollar amount.

Amt2 = log10(10*data$Amount+1) 
head(Amt2,n=5)

# fit logistic regression model
lr_model2 <- glm(Vote ~ REP+AMT2, family = binomial, data)
summary(lr_model2)

