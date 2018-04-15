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

# Examples for different models
method = 'knn'
if method == 'knn':
	from sklearn.neighbors import KNeighborsClassifier
	model = KNeighborsClassifier(n_neighbors=k)

	# Test every odd k from 1 to 51
	grid = [{'n_neighbors': list(range(1, 51, 2))}]

else if method == 'svmRadial':
	from sklearn.svm import SVR
	model = SVR(kernel='rbf')

	# Standard deviation, soft penalty, margin for SVM
	grid = [{'kernel': ['rbf'],
					 'gamma': [1e-4, 1e-3, 0.01, 0.1, 1, 10, 100],
					 'C': [1, 10, 100, 1000],
					 'epsilon': [0, 0.01, 0.1, 0.2, 0.5, 1, 2, 4]}]

# Apply grid search to model method with parameters in grid
from sklearn.grid_search import GridSearchCV
grid_search = GridSearchCV(model, param_grid=grid, cv=10)
grid_search.fit(X_train, y_train)

# Report best
print(grid_search.best_params_)

# Report score
print("Cross-validation score %0.2f" % grid_search.best_score_)