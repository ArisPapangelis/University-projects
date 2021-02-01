rm(list=ls())

sdata = read.csv("sdata.txt")
library(cluster)

#Question 1
x=c(-4,0,4)
y=c(10,0,10)
centers = data.frame(x,y)
model <- kmeans(sdata, centers)
model$tot.withinss

#Question 2
model$betweenss

#Question 3
model_silhouette = silhouette(model$cluster, dist(sdata))
plot(model_silhouette)
mean_silhouette = mean(model_silhouette[,3])

#Question 4
x2=c(-2,2,0)
y2=c(0,0,10)
centers2 = data.frame(x2,y2)
model2 <- kmeans(sdata, centers2)

model_silhouette2 = silhouette(model2$cluster, dist(sdata))
plot(model_silhouette2)
mean_silhouette2 = mean(model_silhouette2[,3])

which.max(c(mean_silhouette, mean_silhouette2))