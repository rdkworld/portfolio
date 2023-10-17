library(MASS)
set.seed(123)

# Generate x and y from bivariate normal distribution
# corr(x, y) = 0.56
data1 <- mvrnorm(20, mu = c(10, 20), 
               Sigma =matrix(c(5, 3, 3, 10), 2,2))
m <- median(data1[,1])

# Replace the values in each group to be the mean
data2 <- data1
g1 <- which(data2[,1] <= m)
g2 <- which(data2[,1] > m)
mean1 <- mean(data2[g1, 1])
mean2 <- mean(data2[g2, 1])
data2[g1, 1] <- rep(mean1, length(g1))
data2[g2, 1]<- rep(mean2, length(g2))


# Create plots
make_plot <- function(data, categorize){
  data <- as.data.frame(data)
  colnames(data) <- c("x", "y")
  fit <- lm(y~x, data = data)
  a <- fit$coefficients[1]
  b <- fit$coefficients[2]
  r <- summary(fit)$r.squared
  t <- summary(fit)[[4]][2,3]
  p <- summary(fit)[[4]][2,4]
  legend1 <- paste("Y = ", round(a, 2), " + ", round(b,2), "x", sep = "")
  legend2 <- paste("R-squared is", round(r, 2))
  legend3 <- paste("t-value is", round(t, 2))
  legend4 <- paste("p-value is", round(p, 5))
  main = ""
  if(categorize == 0){
    main = "Simple Linear Regression With Continuous Variable"
  } else{
    main = "Simple Linear Regression With Categorized Variable"
  }
  plot(data[,1], data[,2], pch = 20, lwd = 5, col = "darkgrey",
       xlab = "x", ylab = "y", xlim = c(7,15),
       main = main)
  abline(a = a, b = b, col = "red", lwd = 3)
  abline(v = m, col = "blue", lwd = 3)
  legend("bottomright", legend = c(legend1, legend2, legend3, legend4), cex = 1.5)
}

make_plot(data1, 0)
make_plot(data2, 1)
