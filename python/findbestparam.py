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

# Cross-validate to find best k
from sklearn.cross_validation import cross_val_score
from sklearn.neighbors import KNeighborsClassifier

# Test every odd k between 1 and 51
index = list(range(1, 51, 2))
scores_list = []

for k in index:
	# Perform 10 fold cross-validation
	model = KNeighborsClassifier(n_neighbors=k)
	scores = cross_val_score(model, X_train, y_train, cv=10)
	mean = scores.mean()
	std = scores.std()
	scores_list.append(mean)

	# Report scores
	print("k=%d,  Accuracy %0.2f (+/- %0.2f)" % 
		(mean, std * 2))
	
best_k = index[scores_list.index(max(scores_list))]
print("best k=%d" % (best_k))

# Plot scores
import matplotlib.pyplot as plt
plt.plot(index, scores_list)
plt.xlabel('#Neighbors')
plt.ylabel('Accuracy (Cross-Validation)')
plt.show()