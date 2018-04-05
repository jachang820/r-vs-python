# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Generalized Linear Models Lasso and Elastic Net (glmnet)
# contains efficient procedures for fitting lasso or 
# elastic-net regularization for linear regression,
# multinomial regression models, Poisson regression,
# multiple-response Gaussian, and the Cox model.
install.packages('glmnet')
library(glmnet)

# Fit regularized linear regression to training set
y_col = ncol(train)
model = glmnet(x=train[,-y_col], y=train[,y_col], alpha=0.5)

# Predict test set
y_pred = predict(model, newdata=test)