# read data from csv file
data <-read.csv("C:/Users/ducan/Box/iMBA course/EOF/LOGIT/choice.csv", sep=",", header=TRUE)

# fit logistic regression model
lr_model <- glm(Choice ~ Discount, family = binomial, data)
summary(lr_model)

# predict Choices from logistic regression model with sequence of Discount
Discount = seq(0,30)
test_df = as.data.frame(Discount)
test_df$predicted_choice = predict(lr_model, test_df, type="response")

# plot calculated probability
discounts = c(0, 10, 15, 20, 30)
prob = c(0.13, 0.14, 0.50, 0.80, 1.0)
plot(discounts, prob, xlab="Discount (in dollar)",ylab="Prob(Choices)", 
     col="blue4", ylim=c(0,1), pch=20)

# plot predicted logit function
lines(test_df$Discount,test_df$predicted_choice,col="red4",lwd=3)
grid()
