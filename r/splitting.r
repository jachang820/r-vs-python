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
cvIndex = createFolds(train$y, folds, returnTrain = TRUE)
tc = trainControl(index=cvIndex, method='cv', number=folds)