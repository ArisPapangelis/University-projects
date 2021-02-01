rm(list=ls())

#Section 2 Preprocessing data
engdata = read.csv("engdata.txt")
pdata = engdata[, 1:2]

pdata = unique(pdata)

transformed <- scale(pdata, center=TRUE, scale=TRUE)
plot(pdata)
plot(transformed)

sampdata = pdata[sample(nrow(pdata), 250, replace=TRUE), ]
plot(pdata)
plot(sampdata)

discAge = cut(pdata$Age, seq(0,80,10))
discSalary = cut(pdata$Salary, seq(0,4000,400), dig.lab = 4)
plot(discAge)
plot(discSalary, las=2)

#Section 3 PCA feature extraction
library(scatterplot3d)
pdata = data.frame(X = c(1,0,-1,0,-1,1), Y = c(0,1,1,-1,0,-1), Z = c(-1,-1,0,1,1,0))
row.names(pdata) <- c("x1", "x2", "x3", "x4", "x5", "x6")
s3d = scatterplot3d(pdata, color="blue", pch=19, scale.y=1.5)
coords <- s3d$xyz.convert(pdata)
text(coords$x,coords$y, labels=row.names(pdata), pos=2)

  #Manually
covmat = cov(pdata)
eigenvalues = eigen(covmat)$values
eigenvectors = eigen(covmat)$vectors
pdata_pc = as.matrix(pdata) %*% eigenvectors[, 1:2]
info_loss = eigenvalues[3] / sum(eigenvalues)

  #With prcomp
pca_model = prcomp(pdata)
eigenvalues = pca_model$sdev^2
eigenvectors = pca_model$rotation
barplot(pca_model$sdev^2 / sum(pca_model$sdev^2))
info_loss = eigenvalues[3] / sum(eigenvalues)

pc <- predict(pca_model, pdata)
plot(pc, col="blue", pch=19)
text(pc, labels=row.names(pdata), pos=2)

#Section 4 Choosing and extracting features
Location = engdata[,5]
engdata = engdata[,1:4]

plot(engdata, col = Location, pch = c("o", "+")[Location])
cor(engdata)

pca_model <- prcomp(engdata, center=TRUE, scale=TRUE)
eigenvalues = pca_model$sdev^2
eigenvectors = pca_model$rotation
barplot(eigenvalues / sum(eigenvalues))

engdata_pc <- as.data.frame(predict(pca_model,engdata)[,1:2])
plot(engdata_pc, col = Location, pch = c("o","+")[Location])

engdata_pc[,3:4] <- 0
engdata_rec = data.frame(t(t(as.matrix(engdata_pc) %*% t(pca_model$rotation)) * pca_model$scale + pca_model$center))
plot(engdata_rec, col=Location, pch = c("o","+")[Location])

info_loss = (eigenvalues[3] + eigenvalues[4]) / sum(eigenvalues)

#Section 5 Non linear feature extraction
library(vegan)
srdata = read.csv("srdata.txt")
scatterplot3d(srdata, angle = 88, scale.y=5)

srdata_dist <- dist(srdata)
isom <- isomap(srdata_dist, ndim=2, k=4)
srdata_2d <- isom$points

colors = srdata_2d[,1] - min(srdata_2d[,1]) + 1
scatterplot3d(srdata, angle=88, scale.y = 5, color=colors)

x11(); plot(srdata_2d, col= colors)