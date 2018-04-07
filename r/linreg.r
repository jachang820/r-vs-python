# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Fit linear regression to training set
model = lm(y ~ ., data=train)

# The . indicates a linear combination of all independent 
# variables. The above line is would be the same as
#         reg = lm(y ~ x1 + x2 + x3, data=train)
# if there are 3 features in the dataset.

# Predict test set
y_pred = predict(model, newdata=test[, -ncol(test)])