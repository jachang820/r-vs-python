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

# Feature scaling
# Note that features that are factors cannot be scaled. Therefore,
# we must only pick the columns that are numerical data.
train[, 2:3] = scale(train[, 2:3])
test[, 2:3] = scale(test[, 2:3])