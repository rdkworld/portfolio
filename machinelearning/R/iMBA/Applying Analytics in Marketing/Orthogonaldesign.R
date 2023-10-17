A <- c("A1", "A2", "A3")
B <- c("B1", "B2","B3")
C <- c("C1","C2", "C3")
factor_levels <- as.data.frame(c(A, B, C))
colnames(factor_levels) <- "levels"
data <- expand.grid(A, B, C)
colnames(data) <- c("A", "B", "C")


#Creating a set of profiles for the factors
facdesign <- caFactorialDesign(data = data, type = "orthogonal")
encdesign <- caEncodedDesign(facdesign)
