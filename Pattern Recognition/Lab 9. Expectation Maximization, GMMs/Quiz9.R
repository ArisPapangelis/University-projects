rm(list=ls())
library(mixtools)
kmdata = read.csv("kmdata.txt")
x = kmdata[, 1:2]
y = kmdata[, 3]

#Question 1
plot(x)
plot(x, col=y, pch=15)

#Question 2
model = kmeans(x, 3)
plot(x, col = model$cluster, pch = 15)
points(model$centers, col = 1:length(model$centers), pch = "+", cex = 2)

#Question 3
library(mixtools)
model <- mvnormalmixEM(x, k=3, epsilon=0.01)
model$mu
model$lambda
model$loglik
plot(model, which=2)

clusters = max.col(model$posterior)
centers = matrix(unlist(model$mu), byrow=TRUE, ncol=2)
