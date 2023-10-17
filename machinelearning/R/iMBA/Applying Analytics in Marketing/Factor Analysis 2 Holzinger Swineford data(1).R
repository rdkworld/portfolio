library(psych)
library(MBESS)
data(HS.data)


str(HS.data)

hs <- HS.data

#HS example 1
hs1 <-cbind(hs$paragrap,hs$sentence,hs$wordm,hs$addition,hs$counting )

colnames(hs1) <- c('para','sent','word','add','count')


cormatrix <- cor(hs1)

KMO(cormatrix)

#Scree plot
parallel <- fa.parallel(cormatrix, fm = 'minres', fa = 'fa')

# From the Scree plot, we can see that the graph flattens out at either 3 or 4. 

# Now, we perform the Factor Analysis using the fa() function. We will run the analysis for 3 factors under orthogonal rotation and oblique rotation - and then analyse the results.


twofac <- fa(hs1, nfactors = 2, rotate = "varimax",fm="minres")
twofac
print(twofac$loadings, cutoff = 0.4)

# Confirmatory Factor Analysis

library(lavaan)

HS.model <- 'verb =~ para + sent + word
             quant =~ add + count'

HS.model <- 'verb =~ para + sent 
             quant =~ add + count + word'


fit <- cfa(HS.model, data=hs1)
fit

library(semPlot)
semPaths(fit, style = "lisrel")

facScores <- data.frame(twofac$scores)

facScores <- cbind(hs$visual,facScores)
colnames(facScores) <- c("visual","verbal", "quant")

attach(facScores)

# Run the regression on the train dataset
reg <- lm(visual ~ verbal +quant)
summary(reg)

