import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Import dataset
dataset = pd.read_csv('data.csv')

# Select appropriate columns
X = dataset.iloc[:, 4:5].values

# Plot dendrogram
import scipy.cluster.hierarchy as sch
linkage = sch.linkage(X, method='ward')
dendrogram = sch.dendrogram(linkage)
plt.title('Dendrogram')
plt.xlabel('Samples')
plt.ylabel('Distance')
plt.show()

# It is difficult to programmatically find longest length in
# dendrogram. Easier to do it visually.

# Predict with specified number of clusters
from sklearn.cluster import AgglomerativeClustering
model = AgglomerativeClustering(n_clusters=5, linkage='ward')
y_pred = model.fit_predict(X)