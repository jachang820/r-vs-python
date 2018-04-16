# Import dataset
df = read.csv('data.csv')

# Select appropriate columns
X = df[4:5]

# Cluster analysis tasks like hierarchical clustering,
# k-means, k-medoids, Gaussian mixture models, DBSCAN, 
# OPTICS.
install.packages('ClusterR')
library(ClusterR)

# Find optimal number of clusters
max_clusters = 50
crit = 'WCSSE' #AIC or BIC
wcss = Optimal_Clusters_KMeans(X,
						max_clusters=max_clusters,
						criterion=crit,
						initializer="kmeans++",
						seed=42)

delta_wcss = vector(mode='numeric', length=max_clusters-2)
for (i in 1:(max_clusters-1) {
  delta_wcss[i] = wcss[i] - wcss[i+1]
}

biggest_ratio = vector(mode='numeric', length=length(delta_wcss)-4)
for (i in 1:(length(delta_wcss)-4) ) {
  biggest_ratio[i] = mean(delta_wcss[i:(i+2]) - 
                     mean(delta_wcss[(i+2):(i+4)])
}

best_k = which.max(biggest_ratio) + 3

# Plot elbow to confirm
library(ggplot2)
wcss = as.vector(wcss)
ggplot() +
  geom_point(aes(x=best_k, y=wcss[best_k]), colour='red') +
  geom_line(aes(x=seq.int(1,length(wcss)), y=wcss), colour='blue') +
  ggtitle('The Elbow Method') +
  xlab('Number of Clusters') +
  ylab('WCSS')

# Predict with optimal clusters
model = KMeans_rcpp(X,
						clusters=best_k,
						initializer="kmeans++",
						seed=42)

# Plot clusters in 2D
# Methods of cluster analysis
install.packages('cluster')
library(cluster)
clusplot(X, 
         model$cluster, 
         lines=0,
         shade=TRUE,
         color=TRUE,
         labels=4,
         plotchar=FALSE,
         main="Title",
         xlab="Component 1",
         ylab="Component 2")

