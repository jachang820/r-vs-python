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

# Kernel-based machine learning methods, including SVM,
# spectral clustering, kernel PCA, Gaussian processes,
# QP solver
install.packages('kernlab')
library(kernlab)

# Find threshold
pca = prcomp(train[, -ncol(train)], scale=TRUE)
eigenvalues = pcaComp$sdev^2
variance_ratios = eigenvalues / sum(eigenvalues)
sum = 0.0
threshold = 0.60
for(i in 1:length(variance_ratios)) {
	sum = sum + variance_ratios[i]
	if (sum > threshold) {
		pcaComp = i
	}
}

# Linear kernel would use 'vanilladot'
pca = kpca(~., data=train[,-3], kernel='rbfdot', features=pcaComp)
train_pca = as.data.frame(predict(kpca, train))
test_pca = as.data.frame(predict(kpca, test))
train_pca$y = train$y
test_pca$y = test$y
