import numpy as np
import pandas as pd

# Import dataset
df = pdf.read_csv('data.csv')

# Select appropriate columns
X = df.iloc[:, :].values

# Find inertia of each of k clusters
from sklearn.cluster import KMeans
max_clusters = 10
wcss = []
for i in range(1, max_clusters + 1):
	model = KMeans(n_clusters=i)
	model.fit(X)
	wcss.append(kmeans.inertia_)

# Find optimal number of clusters using elbow method
# Difference in slope on either side of a point is the elbow
delta_wcss = []
for i in range(1, max_clusters - 2):
	delta_wcss = (wcss[i-1] - wcss[i]) - (wcss[i] - wcss[i+1])

best_k = delta_wcss.index(max(delta_wcss)) + 1

# Plot elbow to confirm
import matplotlib.pyplot as plt
plt.plot(range(1, max_clusters + 1), wcss)
plt.scatter(best_k, wcss[best_k - 1], marker='o', c='red')
plt.title("The Elbow Method")
plt.xlabel("Number of Clusters")
plt.ylabel("WCSS")
plt.show()

# Predict with optimal clusters
model = KMeans(n_clusters=best_k)
y_pred = model.fit_predict(X)

# Plot clusters in 2D
x1 = 0
x2 = 1
for i in y_pred:
	plt.scatter(X[y_pred == i, x1], 
							X[y_pred == i, x2], 
							s=100, 
							c=np.random.rand(3,), 
							label="Cluster " + i)

plt.scatter(model.cluster_centers_[:, x1],
						model.cluster_centers_[:, x2],
						s=200,
						c='black',
						label="Centroids")

plt.legend()
plt.show()