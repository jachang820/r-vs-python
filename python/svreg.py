import numpy as np
import pandas as pd

# Import dataset
df = pdf.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Split into training and test sets
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Feature scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)

def scale_response():
	# Scale the response variable
	sc_y = StandardScaler()
	y_train = sc_y.fit_transform(y_train)
	y_test = sc_y.transform(y_test)

	# Fit support vector regression to training set
	from sklearn.svm import SVR
	model = SVR(kernel="rbf")
	model.fit(X_train, y_train)

	# Predict test set
	y_pred = model.predict(X_test)
	y_pred = sc_y.inverse_transform(y_pred)

# Grid search is also acceptable here
scale_response()