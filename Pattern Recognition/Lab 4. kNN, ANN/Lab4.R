rm(list=ls())

#kNN
library(class)
knndata = read.csv("knndata.txt")

X_train = knndata[,c("X1","X2")]
Y_train = knndata$Y

plot(X_train, col = Y_train, pch = c("o","+")[Y_train] )

knn(X_train, c(0.7,0.4), Y_train, k=1, prob = TRUE)

knn(X_train, c(0.7,0.4), Y_train, k=5, prob = TRUE)

knn(X_train, c(0.7,0.6), Y_train, k=5, prob = TRUE)


#ANN
anndata = data.frame(X1 = c(0,0,1,1), X2 = c(0,1,0,1), Y = c(1,1,-1,-1))
library(neuralnet)
Y12 = ifelse(anndata$Y>0,1,2)
plot(anndata[,c("X1","X2")], col = Y12, pch = c("o","+")[Y12])

model <- neuralnet(Y ~ X1+X2, anndata, hidden = 0, threshold = 0.000001)
plot(model)

print(model$weights)

#ANN with alldata.txt

alldata = read.csv("alldata.txt")
trainingdata = alldata[1:600,]
testdata = alldata[601:800,]
plot(trainingdata[,c(1,2)], col = trainingdata$y, pch = c("o","+")[trainingdata$y])

#2 layers 2 nodes
model <- neuralnet(y ~ X1+X2, data = trainingdata, hidden = c(2,2), threshold = 0.01)
plot(model)

yEstimateTrain = compute(model,trainingdata[,c(1:2)])$net.result
TrainingError = trainingdata$y - yEstimateTrain
MAE1 = mean(abs(trainingdata$y - yEstimateTrain))
plot(hist(TrainingError, breaks = 20))

yEstimateTest = compute(model,testdata[,c(1:2)])$net.result
TestingError = testdata$y - yEstimateTest
MAE2 = mean(abs(testdata$y - yEstimateTrain))
plot(hist(TestingError, breaks = 20))

#3 layers 2 nodes (vector length is number of layers in hidden)
model <- neuralnet(y ~ X1+X2, data = trainingdata, hidden = c(2,2,2), threshold = 0.01)
plot(model)

yEstimateTrain = compute(model,trainingdata[,c(1:2)])$net.result
TrainingError = trainingdata$y - yEstimateTrain
MAE1 = mean(abs(trainingdata$y - yEstimateTrain))
plot(hist(TrainingError, breaks = 20))

yEstimateTest = compute(model,testdata[,c(1:2)])$net.result
TestingError = testdata$y - yEstimateTest
MAE2 = mean(abs(testdata$y - yEstimateTest))
plot(hist(TestingError, breaks = 20))