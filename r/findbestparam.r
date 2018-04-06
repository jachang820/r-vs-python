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
# Test every odd k from 1 to 51
folds = 10
tc = trainControl(method='cv', number=folds)
fit = train(y ~ ., data=train,
						method="knn",
						metric="Accuracy",
						control=tc,
						preProcess=c("center", "scale"),
						tuneGrid=expand.grid(k=seq.int(1, 51, 2))

# Report scores
fit

# Plot scores
plot(fit)