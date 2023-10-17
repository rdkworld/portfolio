library(conjoint)
require(fpc)
data(chocolate)
str(cprof)


#Calculate utilities provided by each factor level to the first respondent
util <- caUtilities(y = cprefm[1,], x = cprof, z = clevn)
util


#Calculate the part utilties for each of the levels for the first 5 respondents
partutil <- caPartUtilities(y = cprefm[1:5,], x = cprof, z = clevn)

#Conjoint analysis
Conjoint(y = cpref, x = cprof, z = clevn)

#Let us determine the level of importance of each of the factors 
Importance <- caImportance(cprefm, cprof)
Factor <- c("Kind","Price", "Packing", "Weight", "Calorie")

FactorImp <- as.data.frame(cbind(Factor,Importance))


#Segmentation and Cluster Plot
seg <- caSegmentation(cpref, cprof, c = 3)
seg

cluster <- as.data.frame(seg$sclu)
colnames(cluster) <- "Cluster"

plotcluster(seg$util,seg$sclu, pch = 20, xlab = " ", ylab = " ", main = "K-Means Clustering Result")
