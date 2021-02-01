rm(list=ls())

# Read dataset into data frame
dn = list(paste("Y", as.character(1949:1960), sep = ""), month.abb)
airmat = matrix(AirPassengers, 12, byrow = TRUE, dimnames = dn)
air = as.data.frame(t(airmat))

# How many passengers have traveled on average on 1951?
mean(air$Y1951)

# What is the maximum passenger number for January and February?
 max(c(unlist(air["Jan",]), unlist(air["Feb",])))

# Compute the cross correlation for all data frame dimensions
cor(air)

# Compute sum for every year and plot it
x = colSums(air)
plot(x, type = 'b', xaxt = 'n', xlab = "", ylab = "#Passengers")
axis(1, at = 1:12, labels = names(x), las = 2)

# Compute sum for every month and all years and plot it
x = rowSums(air)

