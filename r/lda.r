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
train[, -ncol(train)] = scale(train[, -ncol(train)])
test[, -ncol(test)] = scale(test[, -ncol(test)])

# Functions to support Venables and Ripley
# "Modern Applied Staitstics with S" (2002)
install.packages('MASS')
library(MASS)

# Apply LDA
lda = lda(groups ~ ., data=train)
train_lda = predict(lda, train)
train = as.data.frame(cbind(train_lda$x, train_lda$class))
test_lda = predict(lda, test)
test = as.data.frame(cbind(test_lda$x, test_lda$class))

# LDA can classify data using posteriors
y_pred = apply(test_lda$posterior, 1, which.max)
