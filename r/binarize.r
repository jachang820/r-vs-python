# Binarize a matrix, such that all values that satisfy 
# condition are replaced by a 1, and all other values 
# are replaced by a 0.
y_pred = as.numeric(probabilities > 0.5)