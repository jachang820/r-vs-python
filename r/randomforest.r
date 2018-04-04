# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Implements Breiman's random forest algorithm.
install.packages('randomForest')
library(randomforest)

# Fit support vector regression to training set
model = randomForest(y ~ ., data=train, ntree=100)

# Predict test set
y_pred = predict(model, newdata=test)