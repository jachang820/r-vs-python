# Import dataset
df = read.csv('data.csv')

# Encode target feature as factor since naiveBayes doesn't 
# recognize response as factors
df$y = factor(df$y, levels=c(0, 1))

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

# Fit naive Bayes to training set
model = naiveBayes(y ~ ., data=train)

# Predict test set
y_pred = predict(model, newdata=test[, -ncol(test)])