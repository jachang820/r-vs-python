# Import dataset
df = read.csv('data.csv')

# Start with model with all the features
model = lm(y ~ ., data=df)

# Ordinary Least Squares Regression tools. Includes comprehensive
# regression output, hetereoskedasticity tests, collinearity
# diagnostics, residual diagnostics, measures of influence, model
# fit assessment and variable selection procedures.
install.packages('olsrr')
library(olsrr)

# Generate report for stepwise variable selection with both
# forward selection and backward elimination, and using p-values.
report = ols_step_both_p(model)

# Append predictor column names with dependent variable column,
# assuming dependent variable is the last column.
df_opt = df[, c(report$predictors, tail(names(df), 1))]

# New model with optimal features
model = lm(y ~ ., data=df_opt)