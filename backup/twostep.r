P = ncol(model$centroids)
K = nrow(model$centroids)
N = nrow(X)
Nc = model$obs_per_cluster

cluster_variances = function(X, model) {
  Vc = model$centroids
  for (i in 1:K) {
    Vc[i, ] = t(colSums((X[c(model$clusters == i), ] - model$centroids[i, ])^2))/nrow(X)
  }
  return(Vc)
}

total_variances = function(X, model) {
  P = ncol(model$centroids)
  K = nrow(model$centroids)
  X_mean = colMeans(X)
  V = t(colSums((X - X_mean)^2))/(nrow(X)-1)
  V = matrix(rep(V, K), P, K)
  return(V)
}

Vc = matrix(cluster_variances(X, model), 
            nrow=P,
            byrow=TRUE)
V = matrix(total_variances(X, model),
           nrow=P,
           byrow=TRUE)
LL = -Nc * colSums(log(Vc + V)/2)
D = -2 * rowSums(LL)
BIC = D + 2*K*P*log(N)
AIC = D + 4*K*P