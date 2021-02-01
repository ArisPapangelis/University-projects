rm(list=ls())

# Import decision tree libraries
library(rpart)
library(rpart.plot)

# Load iris dataset
iris2 = iris[, c(1, 2, 5)]
iris2$Species[c(101:150)] = iris2$Species[c(21:70)]
iris2$Species = factor(iris2$Species)

# Split to training and testing data
trainingdata = iris2[c(1:40, 51:90, 101:140),]
testdata = iris2[c(41:50, 91:100, 141:150),]
rownames(trainingdata) <- NULL
rownames(testdata) <- NULL

# Train a decision tree model and plot it
# model <- rpart(Species ~ ., method = "class", data = trainingdata, minsplit = 10)
model <- rpart(Species ~ ., method = "class", data = trainingdata, minsplit = 20)
# model <- rpart(Species ~ ., method = "class", data = trainingdata, minsplit = 30)
rpart.plot(model, extra = 104, nn = TRUE)

# Apply the model to the test data
xtest = testdata[,1:2]
ytest = testdata[,3]
pred = predict(model, xtest, type="class")

# Create confusion matrix and compute metrics
cm = as.matrix(table(Actual = ytest, Predicted = pred))
accuracy = sum(diag(cm)) / sum(cm)
precision = diag(cm) / colSums(cm)
recall = diag(cm) / rowSums(cm)
f1 = 2 * precision * recall / (precision + recall)
data.frame(precision, recall, f1)

# Uncomment the following lines to get the metrics for the second class
# TP = cm[2, 2]
# FP = cm[1, 2]
# TN = cm[1, 1]
# FN = cm[2, 1]
