rm(list=ls())

data(Glass, package = "mlbench")
training = Glass[c(1:50, 91:146), -10]
trainingType = factor(Glass[c(1:50, 91:146), 10])
testing = Glass[51:90, -10]
testingType = factor(Glass[51:90, 10])

#Question 1
pca_model = prcomp(training, center=TRUE, scale=TRUE)
eigenvalues = pca_model$sdev^2
eigenvectors = pca_model$rotation
information_percentage = pca_model$sdev^2 / sum(pca_model$sdev^2)
barplot(information_percentage)
information_percentage[1]

#Question 2
#Keep first 4 principal components
info_loss = sum(eigenvalues[5:9]) / sum(eigenvalues)

#Question 3
library(class)
library(MLmetrics)

y_pred = knn(training, testing, trainingType, k = 3)
Accuracy(y_pred, testingType)
Recall(testingType, y_pred, "2")

#Question 4
# initialize structures
accuracies <- c()
pValues = c(1:9)

# run prediction for different values of p
for (p in pValues) {
  training_pc <- as.data.frame(predict(pca_model, training)[, 1:p])
  testing_pc <- as.data.frame(predict(pca_model, testing)[, 1:p])
  ypred = knn(training_pc, testing_pc, trainingType, k = 3)
  accuracies = c(accuracies, Accuracy(ypred, testingType))
}

# return number of Principal Components that maximizes Accuracy
pValues[which.max(accuracies)]