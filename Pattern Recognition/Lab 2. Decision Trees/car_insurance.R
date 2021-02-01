rm(list=ls())

# Read data from disk
setwd("...")
carIns = read.csv("car_insurance.txt")

absfreq = table(carIns[, 5])
freq = prop.table(absfreq) #Sum of all cells
GINI_all = 1 - freq["No"]^2 - freq["Yes"]^2

print(GINI_all)

# Create tables with frequencies for CustomerID
absfreq = table(carIns[, c(1, 5)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))


# Calculate GINI index of CustomerID
GINI_1 = 1 - freq["1", "No"]^2 - freq["1", "Yes"]^2
GINI_2 = 1 - freq["2", "No"]^2 - freq["2", "Yes"]^2
#This would repeat 20 times, the result would always be 0
GINI_CustomerID = freqSum["1"] * GINI_1 + freqSum["2"] * GINI_2

print(GINI_CustomerID)

# Create table with frequencies for Sex
absfreq = table(carIns[, c(2, 5)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

# Calculate GINI index of Sex
GINI_Male = 1 - freq["M", "No"]^2 - freq["M", "Yes"]^2
GINI_Female = 1 - freq["F", "No"]^2 - freq["F", "Yes"]^2
GINI_Sex = freqSum["M"] * GINI_Male + freqSum["F"] * GINI_Female

print(GINI_Sex)

# Create table with frequencies for CarType
absfreq = table(carIns[, c(3, 5)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

levels(carIns$CarType)

# Calculate GINI index of CarType
GINI_Family = 1 - freq["Family", "No"]^2 - freq["Family", "Yes"]^2
GINI_Sedan = 1 - freq["Sedan", "No"]^2 - freq["Sedan", "Yes"]^2
GINI_Sport = 1 - freq["Sport", "No"]^2 - freq["Sport", "Yes"]^2
GINI_CarType = freqSum["Family"] * GINI_Family+ freqSum["Sedan"] * GINI_Sedan + freqSum["Sport"]*GINI_Sport

print(GINI_CarType)

# Create table with frequencies for Budget
absfreq = table(carIns[, c(4, 5)])
freq = prop.table(absfreq, 1)
freqSum = rowSums(prop.table(absfreq))

levels(carIns$Budget)

# Calculate GINI index of Budget
GINI_High = 1 - freq["High", "No"]^2 - freq["High", "Yes"]^2
GINI_Low = 1 - freq["Low", "No"]^2 - freq["Low", "Yes"]^2
GINI_Medium = 1 - freq["Medium", "No"]^2 - freq["Medium", "Yes"]^2
GINI_VeryHigh = 1 - freq["VeryHigh", "No"]^2 - freq["VeryHigh", "Yes"]^2
GINI_Budget = freqSum["High"] * GINI_High+ freqSum["Low"] * GINI_Low + freqSum["Medium"]*GINI_Medium + freqSum["VeryHigh"]*GINI_VeryHigh

print(GINI_Budget)

library(rpart)
library(rpart.plot)

model <- rpart(Insurance ~ Sex + CarType + Budget, method = "class", data = carIns, minsplit = 1, minbucket = 1, cp = -1 )
rpart.plot(model, extra = 104, nn = TRUE)

