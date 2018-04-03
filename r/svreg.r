# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# e1071 provides functions for latent class analysis, short time
# Fourier transform, fuzzy clustering, SVM, shortest path, bagged
# clustering, and naive Bayes
install.packages('e1071')
library(e1071)

# Fit support vector regression to training set
model = svm(y ~ ., data=train, 
						type="eps-regression", 
						kernel="radial")

# Predict test set
y_pred = predict(model, newdata=test)