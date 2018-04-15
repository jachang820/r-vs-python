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

# Apply PCA
# Default kernel is 'linear', which is same as linear PCA
from sklearn.decomposition import KernelPCA
pca = KernelPCA(n_components=None, kernel='rbf')
X_train = pca.fit_transform(X_train)
X_test = pca.transform(X_test)
explained_variance = pca.explained_variance_ratio_

# Use variance ratio to decide cutoff
# Number of components can also be specified by an int
pca = PCA(n_components=0.60, svd_solver='full', kernel='rbf')
X_train = pca.fit_transform(X_train)
X_test = pca.transform(X_test)