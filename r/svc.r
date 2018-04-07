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

# e1071 provides functions for latent class analysis, short time
# Fourier transform, fuzzy clustering, SVM, shortest path, bagged
# clustering, and naive Bayes
install.packages('e1071')
library(e1071)

# Fit support vector classification to training set
model = svm(y ~ ., data=train, 
						type="C-classification", 
						kernel="radial")

# Predict test set
y_pred = predict(model, newdata=test[, -ncol(test)])