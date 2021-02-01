rm(list=ls())

X1 = c(2, 2, -2, -2, 1, 1, -1, -1)
X2 = c(2, -2, -2, 2, 1, -1, -1, 1)
Y = c(1, 1, 1, 1, 2, 2, 2, 2)
alldata = data.frame(X1, X2, Y)

plot(alldata[,c("X1","X2")], col = alldata$Y, pch = c("o","+")[alldata$y])

library(e1071)
library(MLmetrics)

#Question 1
model <- svm(Y ~ ., kernel = "radial",  type = "C-classification", data = alldata, gamma = 1)
pred = predict(model,alldata[,c(1:2)])

Accuracy(pred,alldata$Y)

#Question 2

#Buggy for some reason with probability
#model <- svm(Y ~ ., kernel = "radial",  type = "C-classification", data = alldata, gamma = 1000000, probability = TRUE)
#new_data = data.frame(X1=-2, X2 = -1.9)
#predict(model, new_data, probability = TRUE) 

model <- svm(Y ~ ., kernel = "radial",  type = "C-classification", data = alldata, gamma = 1000000)
new_data = data.frame(X1=-2, X2 = -1.9)
predict(model, new_data) 

#Question 3

# plot classified point
points(-2, -1.9, col = "green", pch = 9)

# create vector for different gamma values
gammavalues = c(0.01, 0.1, 1, 10, 100, 1000, 10000, 100000, 1000000)

# create sequences for data
X1 = seq(min(alldata[, 1]), max(alldata[, 1]), by = 0.1)
X2 = seq(min(alldata[, 2]), max(alldata[, 2]), by = 0.1)

# create data grid
mygrid = expand.grid(X1, X2)
colnames(mygrid) = colnames(alldata)[1:2]

for (gamma in gammavalues) {
  # create svm model
  svm_model = svm(Y ~ ., kernel="radial", type="C-classification", data = alldata, gamma = gamma)
  # run model prediction
  pred = predict(svm_model, mygrid)
  # create matrix to give as z argument to the contour
  Y = matrix(pred, length(X1), length(X2))
  # plot contour with SVM classifier on top of data
  contour(X1, X2, Y, add = TRUE, labels = paste("gamma = ", toString(gamma)), levels = 1.5, col = gamma)
}