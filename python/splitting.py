import pandas as pd

# Import dataset
df = pd.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Split into training and test set
# test_size specifies proportion of the test set
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Apply 10 folds cross-validation
from sklearn.model_selection import KFold
kf = KFold(n_splits=10, random_state=None, shuffle=False)
for train_index, validation_index in kf.split(X):
	X_train, X_val = X[train_index], X[validation_index]
	y_train, y_val = y[train_index], y[validaiton_index]
	# Train model here