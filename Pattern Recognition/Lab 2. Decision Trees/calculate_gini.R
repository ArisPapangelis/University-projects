rm(list=ls())

# Read data from disk
setwd("...")
weather = read.csv("weather.txt")

# Create tables with frequencies for Outlook
absfreq = table(weather[, c(1, 4)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate GINI index of Outlook
GINI_Sunny = 1 - freq["Sunny", "No"]^2 - freq["Sunny", "Yes"]^2
GINI_Rainy = 1 - freq["Rainy", "No"]^2 - freq["Rainy", "Yes"]^2
GINI_Outlook = freqSum["Sunny"] * GINI_Sunny + freqSum["Rainy"] * GINI_Rainy

# Create table with frequencies for Temperature
absfreq = table(weather[, c(2, 4)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate GINI index of Temperature
GINI_Hot = 1 - freq["Hot", "No"]^2 - freq["Hot", "Yes"]^2
GINI_Cool = 1 - freq["Cool", "No"]^2 - freq["Cool", "Yes"]^2
GINI_Temperature = freqSum["Hot"] * GINI_Hot + freqSum["Cool"] * GINI_Cool

# Create table with frequencies for Humidity
absfreq = table(weather[, c(3, 4)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate GINI index of Humidity
GINI_High = 1 - freq["High", "No"]^2 - freq["High", "Yes"]^2
GINI_Low = 1 - freq["Low", "No"]^2 - freq["Low", "Yes"]^2
GINI_Humidity = freqSum["High"] * GINI_High + freqSum["Low"] * GINI_Low
