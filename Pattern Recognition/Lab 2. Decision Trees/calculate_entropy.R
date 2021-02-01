rm(list=ls())

# Read data from disk
setwd("...")
weather = read.csv("weather.txt")

# Calculate entropy of Play
freq = prop.table(table(weather[, c(4)]))
Entropy_All = - freq["No"] * log2(freq["No"]) - freq["Yes"] * log2(freq["Yes"])

# Create tables with frequencies for Outlook
absfreq = table(weather[, c(1, 4)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate Information Gain of Outlook
Entropy_Sunny = - freq["Sunny", "No"] * log2(freq["Sunny", "No"]) - freq["Sunny", "Yes"] * log2(freq["Sunny", "Yes"])
Entropy_Rainy = - freq["Rainy", "No"] * log2(freq["Rainy", "No"]) - freq["Rainy", "Yes"] * log2(freq["Rainy", "Yes"])
GAIN_Outlook = Entropy_All - freqSum["Sunny"] * Entropy_Sunny - freqSum["Rainy"] * Entropy_Rainy

# Create tables with frequencies for Temperature
absfreq = table(weather[, c(2, 4)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate Information Gain of Temperature
Entropy_Hot = - freq["Hot", "No"] * log2(freq["Hot", "No"]) - freq["Hot", "Yes"] * log2(freq["Hot", "Yes"])
Entropy_Cool = - freq["Cool", "No"] * log2(freq["Cool", "No"]) - freq["Cool", "Yes"] * log2(freq["Cool", "Yes"])
GAIN_Temperature = Entropy_All - freqSum["Hot"] * Entropy_Hot - freqSum["Cool"] * Entropy_Cool

# Create tables with frequencies for Humidity
absfreq = table(weather[, c(3, 4)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate Information Gain of Humidity
Entropy_High = - freq["High", "No"] * log2(freq["High", "No"]) - freq["High", "Yes"] * log2(freq["High", "Yes"])
Entropy_Low = - freq["Low", "No"] * log2(freq["Low", "No"]) - freq["Low", "Yes"] * log2(freq["Low", "Yes"])
GAIN_Humidity = Entropy_All - freqSum["High"] * Entropy_High - freqSum["Low"] * Entropy_Low
