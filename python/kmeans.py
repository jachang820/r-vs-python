import numpy as np
import pandas as pd

# Import dataset
df = pdf.read_csv('data.csv')

# Select appropriate columns
X = df.iloc[:, :].values

# Find optimal number of clusters
from sklearn.cluster import KMeans
wcss = []
for i in range(1, 11):
	kmeans = KMeans(n_clusters=i)
	kmeans.fit(X)
	wcss.append(kmeans.inertia_)
	#calculate elbow

# Predict test set
y_pred = model.predict(X_test)