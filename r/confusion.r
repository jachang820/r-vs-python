# Construct confusion matrix
y_test = test[, ncol(test)]
cm = table(y_test, y_pred)