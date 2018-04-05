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

# Fit logistic regression to training set
model = glm(y ~ ., family=binomial, data=train)

# Predict test set
probability = predict(model, type='response', newdata=test[,-ncol(test)])
y_pred = as.numeric(probability > 0.5)