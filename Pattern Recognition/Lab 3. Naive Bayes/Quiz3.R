rm(list=ls())

library(e1071)
library(MLmetrics)
library(ROCR)

Class = c(1, 1, 0, 0, 1, 1, 0, 0, 1, 0)
P_M1 = c(0.73, 0.69, 0.44, 0.55, 0.67, 0.47, 0.08, 0.15, 0.45, 0.35)
P_M2 = c(0.61, 0.03, 0.68, 0.31, 0.45, 0.09, 0.38, 0.05, 0.01, 0.04)
data = data.frame(Class, P_M1, P_M2)

#Question 1
pred_obj1 = prediction(data$P_M1, data$Class, label.ordering = c("0","1"))
TPRcurve <- performance(pred_obj1,"tpr")
print(TPRcurve)
plot(TPRcurve)

#Question 2
pred_obj2 = prediction(data$P_M2, data$Class, label.ordering = c("0","1"))
Fmeasure <- performance(pred_obj2,"f")
print(Fmeasure)
plot(Fmeasure)


#Question 3 and 4
ROC1 <- performance(pred_obj1,"tpr", "fpr")
print(ROC1)
plot(ROC1, col="red")

ROC2 <- performance(pred_obj2,"tpr", "fpr")
print(ROC2)
plot(ROC2, col="blue", add=TRUE)
abline(0,1, col = "grey")

performance(pred_obj2, "auc")@y.values

performance(pred_obj1, "auc")@y.values