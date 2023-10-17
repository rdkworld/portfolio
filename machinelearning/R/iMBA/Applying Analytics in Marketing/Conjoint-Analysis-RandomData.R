library(conjoint)
require(fpc)

pages <- c("less than 500", "500 to 1000", "more than 1000")
genre <- c("fiction", "non-fiction")
author <- c("known", "unknown")
factor_levels <- as.data.frame(c(pages, genre, author))
colnames(factor_levels) <- "levels"
data <- expand.grid(pages, genre, author)
colnames(data) <- c("Pages", "Genre", "Author")


#Creating a set of profiles for the factors
facdesign <- caFactorialDesign(data = data, type = "full")
encdesign <- caEncodedDesign(facdesign)

cor(encdesign)

#Fill in random responses for the 10 respondents for all the 12 profiles created
set.seed(1)
response <- as.data.frame(sample(1:12, 12, rep= FALSE))
for (i in 2 : 10) {
  temp <- as.data.frame(sample(1:12, 12, rep = FALSE)) 
  response <- cbind(response, temp)
}

response <- t(response)
row.names(response) <- c(1:10)
colnames(response) <- c(paste("Profile", c(1:12)))
response <- as.data.frame(response)


#Partial utility
partutil <- caPartUtilities(y = response[1:5,], x = encdesign, z = factor_levels)

util <- caUtilities(y = response, x = encdesign, z = factor_levels)

#Conjoint Analysis
analysis <- Conjoint(response, encdesign, factor_levels)


#Obtaining the importance of each of the factors 
Importance <- caImportance(response, encdesign)
Factor <- c("Pages","Genre", "Author")

FactorImp <- as.data.frame(cbind(Factor,Importance))


#Segmentation and Cluster Plot
pref <- as.vector(t(response))
seg <- caSegmentation(pref, encdesign, c = 2)

cluster <- as.data.frame(seg$sclu)
colnames(cluster) <- "Cluster"

plotcluster(seg$util,seg$sclu, pch = 20, xlab = " ", ylab = " ", main = "K-Means Clustering Result")
