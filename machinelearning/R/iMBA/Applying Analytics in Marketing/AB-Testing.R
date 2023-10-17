# install.packages("mosaicData")
library(mosaicData)
data(SaratogaHouses)

SaratogaHouses
#################################
##  One-Sample t-test Example  ##
#################################

mean(SaratogaHouses$price)

t.test(SaratogaHouses$price)

# Do a t-test to test whether the true mean housing price in Saratoga is $200000.
t.test(SaratogaHouses$price, mu = 200000)

# The p-value is 4.804e-07, which is smaller than 0.05.
# So, we can reject the null hypotheis under the significance level of 0.05
# and conclude that the true mean housing price in Saratoga is not $200000.


#################################
##  Two-Sample t-test Example  ##
#################################

# Split the price data into two groups.
# Houses in one group have central air and 
# houses in the other group do not have central air.
x <- SaratogaHouses$price[SaratogaHouses$centralAir == "Yes"]
y <- SaratogaHouses$price[SaratogaHouses$centralAir == "No"]

# The two groups have unequal sample sizes.
length(x)
length(y)

# Generate a boxplot of the housing prices of the two groups.
boxplot(x, y)

# Performed an unpairned two-sample t-test to test 
# whether there is a difference in housing prices between the two groups.
# Note that the t.test(x, y) assumes unequal variances by default.
t.test(x, y, paired = F)

# The p-value is 2.2e-16, which is samller than 0.05.
# So, we can we can reject the null hypotheis under the significance level of 0.05
# and conclude that the there is a difference in housing prices between the two groups
