library(conjoint)
require(fpc)


fares <- c("$3.1", "$3.7", "$4.3")
duration <- c("10min", "20min")
factor_levels <- as.data.frame(c(fares, duration))
colnames(factor_levels) <- "levels"
data <- expand.grid(fares, duration)
colnames(data) <- c("fares", "duration")

Rating <- c(100,92,71,94,82,60)
data <- cbind(data, Rating)


#Let us make dummy variables 
data$F1 <- ifelse(data$fares == "$3.1",1,0)
data$F2 <- ifelse(data$fares == "$3.7",1,0)
data$D1 <- ifelse(data$duration == "10min",1,0)


#Let us run a regression to get the coefficients of the model

reg <- lm( Rating ~ F1 + F2 + D1, data = data)

coefficients <- as.data.frame(reg$coefficients)
colnames(coefficients) <- 'coefficients'

summary(reg)



