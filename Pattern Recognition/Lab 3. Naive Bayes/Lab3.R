rm(list=ls())

traffic = read.csv("traffic.txt")
library(e1071)


#Without Laplace Smoothing
model <- naiveBayes(HighTraffic ~ . , data = traffic)
print(model)

trvalue <- data.frame(Weather=factor("Hot", levels(traffic$Weather)), Day = factor("Vacation", levels(traffic$Day)))

predict(model,trvalue)

predict(model,trvalue, type = "raw")

#With Laplace Smoothing
model <- naiveBayes(HighTraffic ~ . , data = traffic, laplace = 1)
print(model)

trvalue <- data.frame(Weather = factor("Hot", levels(traffic$Weather)), Day = factor("Weekend", levels(traffic$Day)))
predict(model,trvalue)
predict(model,trvalue, type = "raw")


#ROC
data(HouseVotes84, package = "mlbench")
votes = na.omit(HouseVotes84)

library(e1071)
library(MLmetrics)
library(ROCR)

trainingdata = votes[1:180,]
testingdata = votes[181:232,]

model <- naiveBayes(Class ~ ., data=trainingdata)
xtest = testingdata[,-1]
ytest = testingdata[,1]

pred = predict(model,xtest)
predprob = predict(model,xtest, type = "raw")

ConfusionMatrix(pred,ytest)
Precision(ytest,pred,"democrat")
Recall(ytest,pred,"democrat")

pred_obj = prediction(predprob[,1], ytest, label.ordering = c("republican","democrat"))
ROCcurve <- performance(pred_obj,"tpr","fpr")

plot(ROCcurve, col = "blue")
abline(0,1, col = "grey")

performance(pred_obj, "auc")
