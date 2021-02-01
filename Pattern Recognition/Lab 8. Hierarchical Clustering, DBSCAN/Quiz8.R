rm(list=ls())
library(dbscan)

dcdata = read.csv("dcdata.txt")
target = dcdata[, 3]
dcdata = dcdata[, 1:2]

#Question 1
plot(dcdata, col = target, pch = 15, main = "Ground Truth")

d = dist(dcdata)

#This fails at clustering
model1 = hclust(d, method = "single")
plot(model1)
clusters = cutree(model1, k = 2)
plot(dcdata, col = clusters, pch=15, main = "Single Linkage")

#This succeeds at clustering
model2 = hclust(d, method = "complete")
plot(model2)
clusters = cutree(model2, k = 2)
plot(dcdata, col = clusters, pch=15, main = "Complete Linkage")

#This partially succeeds at clustering only with eps = 1.25
epsilon = c(0.75, 1, 1.25, 1.5)
for (i in 1:4){
  model3 = dbscan(dcdata, eps = epsilon[i], minPts = 5)
  clusters = model3$cluster
  plot(dcdata, col = clusters+1, pch = 15, main = "DBSCAN")
}

#This succeeds at clustering  
model4 = kmeans(dcdata, 2)
plot(dcdata, col = model4$cluster, pch=15, main = "kMeans")


#Question2
library(MLmetrics)
Accuracy(cutree(model1, k=2), target)

#Question3
Accuracy(cutree(model2, k=2), target)
