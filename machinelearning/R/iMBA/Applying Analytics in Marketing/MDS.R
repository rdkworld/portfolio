library(stats)

#Obtain data and convert to matrix format
data(eurodist)
eurodist <- as.matrix(eurodist)


#Use cmdscale to convert the matrix into a classical
# multidimensional scale

mds <- cmdscale(eurodist, k = 2, eig = FALSE)

#Flip the y axis to represent the relative positioning of the points 
x <- mds[,1]
y <- mds[,2]
#y <- 0-mds[,2]

#Plot the reduced coordinates to get the spatial map 
plot(x, y, pch = 19, xlim = range(x) + c(0, 600))
text(x, y, pos = 4, labels = colnames(eurodist))

