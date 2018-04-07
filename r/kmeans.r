# Import dataset
df = read.csv('Mall_Customers.csv')

# Select appropriate columns
X = df[4:5]

# Cluster analysis tasks like hierarchical clustering,
# k-means, k-medoids, Gaussian mixture models, DBSCAN, 
# OPTICS. 
install.packages('ClusterR')
library(ClusterR)

# Find optimal number of clusters
max_clusters = 50
crit = "AIC" #AIC or BIC
best_k = Optimal_Clusters_KMeans(X,
						max_clusters=max_clusters,
						criterion=crit,
						initializer="kmeans++",
						seed=42)

# Predict with optimal clusters
model = KMeans_rcpp(X,
						clusters=best_k,
						initializer="kmeans++")