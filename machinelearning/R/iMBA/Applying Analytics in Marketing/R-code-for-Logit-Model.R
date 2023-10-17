# Probit and Logit Models in R
# Copyright 2013 by Ani Katchova

Data<- read.csv("/Users/hanle/Desktop/Rcode/Insurance.csv")
head(Data, n=5)

# Define variables
Y <- cbind(Data$ins)
X <- cbind(Data$retire, Data$age, Data$hstatusg, Data$hhincome, Data$educyear, Data$married, Data$hisp)

# Descriptive statistics
summary(Y)
summary(X)

table(Y)
table(Y)/sum(table(Y))

# Logit model coefficients
logit<- glm(Y ~ X, family=binomial (link = "logit"))
summary(logit) 

# Logit model odds ratios
exp(logit$coefficients)

# Logit model average marginal effects
LogitScalar <- mean(dlogis(predict(logit, type = "link")))
LogitScalar * coef(logit)

# Logit model predicted probabilities
plogit<- predict(logit, type="response")
summary(plogit)





