# Binarize a matrix, such that all values above threshold are
# replaced by a 1, and all other values are replaced by a 0.
# If 'copy' is false, it performs replacement in-place.
from sklearn.preprocessing import binarize
y_pred = binarize(probabilities, threshold=0.5, copy=True)