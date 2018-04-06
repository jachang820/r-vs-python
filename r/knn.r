# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Feature scaling
# Pick only numerical columns
train[, 1:2] = scale(train[, 1:2])
test[, 1:2] = scale(test[, 1:2])

# Various functions for classification, including
# k-NN, learning vector quantization, and self-
# organizing maps.
install.packages('class')
library(class)

# Fit k-NN to training set
y_pred = knn(train[, -ncol(train)], 
						 test[, -ncol(test)],
						 train[, ncol(train)],
						 k=5)
