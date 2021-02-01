rm(list = ls())


#Section 2 Gaussian mixtures with expectation maximization
gdata =read.csv("gdata.txt")
x = gdata[,1]
y = gdata[,2]

plot(data.frame(x,0), ylim = c(-0.01,0.25), col=y, xlab="Data", ylab="Density")
lines(density(x), col=y)

  #Manual algorithm
  # Initialize the means and the latent variables
mu = c(0, 1)
lambda = c(0.5, 0.5)
epsilon = 1e-08
log_likelihood = sum(log(lambda[1] * dnorm(x, mean = mu[1], sd = 1) + lambda[2] * dnorm(x, mean = mu[2], sd = 1)))
  # Loop until convergence
repeat {
  # Expectation step
  # Find distributions given mu, lambda (and sigma)
  T1 <- dnorm(x, mean = mu[1], sd = 1)
  T2 <- dnorm(x, mean = mu[2], sd = 1)
  P1 <- lambda[1] * T1 / (lambda[1] * T1 + lambda[2] * T2)
  P2 <- lambda[2] * T2 / (lambda[1] * T1 + lambda[2] * T2)
  # Maximization step
  # Find mu, lambda (and sigma) given the distributions
  mu[1] <- sum(P1 * x) / sum(P1)
  mu[2] <- sum(P2 * x) / sum(P2)
  lambda[1] <- mean(P1)
  lambda[2] <- mean(P2)
  # Calculate the new log likelihood (to be maximized)
  new_log_likelihood = sum(log(lambda[1] * dnorm(x, mean = mu[1], sd = 1) + lambda[2] * dnorm(x, mean = mu[2], sd = 1)))
  # Print the current parameters and the log likelihood
  cat("mu =", mu, " lambda =", lambda, " log_likelihood =", new_log_likelihood, "\n")
  # Break if the algorithm converges
  if (new_log_likelihood - log_likelihood <= epsilon) break
  log_likelihood = new_log_likelihood
}

  #Using mixtools
library(mixtools)
model <- normalmixEM(x, mu = c(0,1), sd.constr = c(1,1))
model$mu
model$lambda
model$loglik
plot(model, which=2)
lines(density(x), lty=2, lwd=2)


#Section 3 Clustering with gaussian mixtures
library(cluster)
library(mixtools)
gsdata = read.csv("gsdata.txt")
target = gsdata[, 3]
gsdata = gsdata[, 1:2]

plot(gsdata, col=target)

model = mvnormalmixEM(gsdata, k = 3, epsilon = 0.1)
plot(model, which=1)
plot(model, which=2)

clusters = max.col(model$posterior)
centers = matrix(unlist(model$mu), byrow=TRUE, ncol=2)

model_silhouette = silhouette(clusters, dist(gsdata))
plot(model_silhouette)

gsdata_ord = gsdata[order(clusters),]
heatmap(as.matrix(dist(gsdata_ord)), Rowv = NA, Colv = NA, col = heat.colors(256), revC = TRUE)


#Section 4 Information criteria
icdata = read.csv("icdata.txt")
x = icdata[, 1]
y = icdata[, 2]

plot(data.frame(x, 0), ylim = c(-0.01, 0.1))
lines(density(x))

AIC = c()
BIC = c()
par(mfrow = c(2, 2))
for (k in 2:5) {
  model <- normalmixEM(x, k = k, epsilon = 0.0001)
  plot(model, which = 2 , main2 = paste("Density (k = ", k, ")", sep = ""))
  numparams = length(model$mu) + length(model$stdev) + length(model$lambda)
  AIC[k] = 2 * numparams - 2 * model$loglik
  BIC[k] = log(length(x)) * numparams - 2 * model$loglik
}
par(mfrow = c(1, 1))

plot(AIC[2:5], type = 'l', xaxt = "n", main = "AIC", ylab = "AIC")
axis(1, at = 1:4, labels = 2:5)

plot(BIC[2:5], type = 'l', xaxt = "n", main = "BIC", ylab = "BIC")
axis(1, at = 1:4, labels = 2:5)