rm(list=ls())

X1 = c(-2,-2,-1.8,-1.4,-1.2,1.2,1.3,1.3,2,2,-0.9,-0.5,-0.2,0,0,0.3,0.4,0.5,0.8,1)

X2 = c(-2,1,-1,2,1.2,1,-1,2,0,-2,0,-1,1.5,0,-0.5,1,0,-1.5,1.5,0)

Y = c(1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)

alldata = data.frame(X1,X2,Y)

plot(alldata$X1,alldata$X2, col = alldata$Y, pch = c("o","+")[alldata$Y] )

#Question 1
library(class)

knn(alldata[,c("X1","X2")], c(1.5,-0.5), alldata$Y, k=3, prob = TRUE)

#Question 2
knn(alldata[,c("X1","X2")], c(-1,1), alldata$Y, k=5, prob = TRUE)

#Question 3
library(neuralnet)
X1 = c(2,2,-2,-2,1,1,-1,-1)
X2 = c(2,-2,-2,2,1,-1,-1,1)
Y = c(1,1,1,1,2,2,2,2)

alldata = data.frame(X1,X2,Y)

model <- neuralnet(Y ~ X1+X2, data = alldata, hidden = c(2), threshold = 0.01)
plot(model)

yEstimate = compute(model,alldata[,c(1:2)])$net.result
TrainingError = alldata$Y - yEstimate
MAE = mean(abs(TrainingError))
plot(hist(TrainingError, breaks = 20))
