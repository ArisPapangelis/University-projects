rm(list=ls())

# Read data from disk
setwd("...")
weather = read.csv("weather.txt")

# Import decision tree libraries
library(rpart)
library(rpart.plot)

# Split on Outlook
model <- rpart(Play ~ Outlook, method = "class", data = weather, minsplit=1)
rpart.plot(model, extra = 104, nn = TRUE)

# Split on Temperature
model <- rpart(Play ~ Temperature, method = "class", data = weather, minsplit=1)
rpart.plot(model, extra = 104, nn = TRUE)

# Split on Humidity
model <- rpart(Play ~ Humidity, method = "class", data = weather, minsplit=1)
rpart.plot(model, extra = 104, nn = TRUE)

# Create complete (unpruned) tree
model <- rpart(Play ~ Outlook + Temperature + Humidity, method = "class", data = weather, minsplit=1, minbucket=1, cp=-1)
rpart.plot(model, extra = 104, nn = TRUE)
