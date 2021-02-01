rm(list=ls())

#Section 2 k-Means
X = c(7, 3, 1, 5, 1, 7, 8, 5)
Y = c(1, 4, 5, 8, 3, 8, 2, 9)
rnames = c("x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8")
kdata = data.frame(X, Y, row.names = rnames)
plot(kdata, pch=15)
text(kdata, labels = row.names(kdata), pos = 2)

model = kmeans(kdata, centers = kdata[1:3,])
model$centers
model$cluster
cohesion = model$tot.withinss
separation = model$betweenss

plot(kdata, col = model$cluster, pch =15)
text(kdata, labels = row.names(kdata), pos=2)
points(model$centers, col = 1:length(model$centers), pch="+", cex=2)

#Section 3 k-Means and evaluation metrics
library(cluster)
cdata = read.csv("cdata.txt")
target = cdata[,3]
cdata = cdata[, 1:2]

plot(cdata, col=target)
SSE <- (nrow(cdata)-1) * sum(apply(cdata,2,var))
for (i in 2:10)
  SSE[i] <- kmeans(cdata, centers=i)$tot.withinss
plot(1:10, SSE, type="b", xlab="Number of Clusters", ylab="SSE")

model = kmeans(cdata, centers=3)
model$centers
model$cluster

cohesion = model$tot.withinss
separation = model$betweenss

plot(cdata, col = model$cluster)
points(model$centers, col = 4, pch = "+", cex=2)

  #Silhouette
model_silhouette = silhouette(model$cluster, dist(cdata))
plot(model_silhouette)
mean_silhouette = mean(model_silhouette[,3])

  #Heatmap
cdata_ord = cdata[order(model$cluster),]
heatmap(as.matrix(dist(cdata_ord)), Rowv = NA, Colv = NA, col = heat.colors(256), revC = TRUE)

#Section 4 k-Medoids
library(cluster)
Rank = c("High", "Low", "High", "Low", "Low", "High")
Topic = c("SE", "SE", "ML", "DM", "ML", "SE")
conferences = data.frame(Rank, Topic)

model = pam(conferences,3)
model$medoids
model$clustering
conferences[model$id.med,]

L1 = levels(conferences$Rank)
L2 = levels(conferences$Topic)
plot(model$data, xaxt = "n", yaxt = "n", pch=15, col = model$clustering)
axis(1, at = 1:length(L1), labels = L1)
axis(2, at = 1:length(L2), labels = L2)
points(conferences[model$id.med,], col=1:3, pch="o", cex=2)
