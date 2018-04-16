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

# Apply LDA
# Find optimal components with variance ratio
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
lda = LinearDiscriminantAnalysis(n_components=None)
X_train = lda.fit_transform(X_train, y_train)
X_test = lda.transform(X_test)

threshold = 0.60
for i in range(len(pca.explained_variance_ratio_)):
	if np.sum(pca.explained_variance_ratio_[0:(i+1)]) > threshold:
		ldaComp = i + 1
		break

# Apply LDA
pca = PCA(n_components=ldaComp)
X_train = pca.fit_transform(X_train)
X_test = pca.transform(X_test)