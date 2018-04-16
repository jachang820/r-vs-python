# Import dataset
df = read.csv('data.csv')

# Select appropriate columns
X = df[4:5]

# Plot dendrogram
model = hclust(dist(X, method='euclidean'), method='ward.D')
plot(model,
		 main=paste('Dendrogram'),
		 xlab='Samples',
		 ylab='Distance')

# Find optimal number of clusters
distances = vector(mode='numeric', length=length(model$height)-1)
for (i in 1:(length(model$height)-1)) {
  distances[i] = model$height[i+1] - model$height[i]
}

num_clusters = length(model$height) - which.max(distances) + 1

# Cut tree to retain only specified number of clusters
y_pred = cutree(model, num_clusters)

# Plot clusters in 2D
# Methods of cluster analysis
install.packages('cluster')
library(cluster)
clusplot(X, 
         y_pred, 
         lines=0,
         shade=TRUE,
         color=TRUE,
         labels=4,
         plotchar=FALSE,
         main="Title",
         xlab="Component 1",
         ylab="Component 2")