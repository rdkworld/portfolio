
#############################
##  One-Way ANOVA Example  ##
#############################

attach(InsectSprays)

# We can get a summary of this dataset
# The first column is the counts of insects in agricultural experimental units
# The second column contains 6 types of sprays
dim(InsectSprays)
str(InsectSprays)

# Each type of sprays has the same sample size of 12
tapply(count, spray, length)

# We can generate a boxplot of each type of the spray
boxplot(count ~ spray)

# Run One-Way Anova using aov()
anova <- aov(count ~ spray, data = InsectSprays)
summary(anova)

# Manually Calculate the F statistic
N <- nrow(InsectSprays) # number of Observations
n <- 12                 # number of observations per group
k <- length(unique(InsectSprays$spray)) # Number of groups
grand_mean <- mean(InsectSprays$count)  # Grand Mean
group_mean <- tapply(count, spray, mean) # Mean of each group

SST<-  sum(n*(group_mean - grand_mean)^2)
MST <- SST/(k-1)

SSE <- sum((InsectSprays$count- rep(group_mean, each = n))^2)
MSE <- SSE/(N-k)

F_statistic <- MST/MSE
F_statistic

p_value <- pf(F_statistic, df1=(k-1), df2=(N-k), lower.tail = FALSE)
p_value


#############################
##  Two-Way ANOVA Example  ##
#############################

# install.packages("mosaicData")
library(mosaicData)
data(SaratogaHouses)

# The response variable in this example is the price.
# We want to test whether heating type and sewer type
# will affect the housing price in Saratoga.
head(SaratogaHouses)

# We can check the sample sizes in each combination of the two variables
table(SaratogaHouses$heating, SaratogaHouses$sewer)

# If we assume the two variables are independent, we can use the additive model.
anova2 <- aov(price ~ heating + sewer, data = SaratogaHouses)
summary(anova2)

# If we also want to test whether the two variables interact to affect the housing price,
# we can use an interaction term.
anova3 <- aov(price ~ heating * sewer, data = SaratogaHouses)
summary(anova3)

# The command below is equivalent to anova3
anova4 <- aov(price ~ heating + sewer + heating:sewer, data = SaratogaHouses)
summary(anova4)



