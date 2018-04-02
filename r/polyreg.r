# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Fit polynomial linear regression to training set
poly_model = lm(y ~ polym(x1, x2, x3, degree=4), data=train)

# Predict test set
y_pred = predict(poly_model, newdata=test)