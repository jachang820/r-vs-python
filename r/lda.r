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

# Apply LDA
install.packages('MASS')
library(MASS)
lda = lda(groups ~ ., data=train)
train = as.data.frame(predict(lda, train))
