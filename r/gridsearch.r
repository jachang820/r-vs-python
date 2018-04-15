# Import dataset
df = read.csv('data.csv')

# caTools contains several basic utility functions including: moving 
# (rolling, running) window statistic functions, read/write for GIF 
# and ENVI binary files, fast calculation of AUC, LogitBoost classifier, 
# base64 encoder/decoder, round-off-error-free sum and cumsum, etc.
install.packages('caTools')
library(caTools)

# Create Boolean vector with random split
# SplitRatio specifies proportion of training set
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# caret: Classification and Regression Training provides misc functions for 
# training and plotting classification and regression models.
install.packages('caret')
library(caret)

# Apply 10 folds cross-validation
folds = 10
tc = trainControl(method='cv', number=folds)

# Examples for different models
method = 'knn'
if (method == 'knn') {
	
	# Test every odd k from 1 to 51
	grid = expand.grid(k=seq.int(1, 51, 2))

} else if (method == 'svmRadial') {

	# Standard deviation, soft penalty, margin for SVM
	grid = expand.grid(sigma=c(1e4, 1e3, 100, 10, 1, 0.1, 0.01),
										 C=c(1, 10, 100, 1000),
										 epsilon=c(0, 0.01, 0.1, 0.2, 0.5, 1, 2, 4))
}

# Apply grid search to model method with parameters in grid
fit = train(y ~ ., data=train,
						method=method,
						control=tc,
						preProcess=c("center", "scale"),
						tuneGrid=grid

# Report scores
fit

# Plot scores
plot(fit)