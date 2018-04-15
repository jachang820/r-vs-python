import numpy as np
import pandas as pd

# Import dataset
dataset = pd.read_csv('data.csv')

# Select appropriate columns
X = dataset.iloc[:, :].values

import scipy.cluster.hierarchy as sch
dendrogram = sch.dendrogram(sch.linkage(X, method='ward')) # minimize within cluster variance
plt.title('Dendrogram')
plt.xlabel('Customers')
plt.ylabel('Distance')
plt.show()