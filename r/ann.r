# Import dataset
df = read.csv('data.csv')

# Create Boolean vector with random split
library(caTools)
split = sample.split(df$y, SplitRatio=0.8)

# Split into training and test set
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Feature scaling
# Pick only numerical columns
train[, 1:2] = scale(train[, 1:2])
test[, 1:2] = scale(test[, 1:2])

install.packages('h2o')
library(h2o)

# Use all cores and auto-tune batch size
h2o.init(nthreads=-1)
model = h2o.deeplearning(y='y',
												 training_frame=as.h2o(train),
												 activation='Rectifier',
												 hidden=c(6,6),
												 epochs=100,
												 train_samples_per_iteration=-2)

# Predict test set
probability = h2o.predict(model, newdata=test[, -ncol(test)])
y_pred = as.vector(probability > 0.5)

# Make confusion matrix
conf = table(test[, -ncol(test)], y_pred)

# Disconnect from h2o server
h2o.shutdown()