# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Recursive Partitioning (RPART) for classification, regression,
# and survival trees. Implements most functionality from 1984
# book by Breiman, Friedman, Olshen and Stone. 
install.packages('rpart')
library(rpart)

# Fit CART classifier to training set
model = rpart(y ~ ., data=train, 
							control=rpart.control(minsplit=1))

# Predict test set
y_pred = predict(model, newdata=test[, -ncol(test)], type="class")

# Plot dendrogram
plot(model)
text(model)