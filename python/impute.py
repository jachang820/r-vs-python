import pandas as pd
from sklearn.preprocessing import Imputer
import fancyimpute

# Import dataset
df = pd.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

def drop_missing(df):
	# Note that dropping missing values require X, y to be redefined.
	df_new = df.dropna()
	return df_new

def impute_mean(X):
	# sklearn Imputer has mean, median, and mode strategies.
	imputer = Imputer(
		missing_values='NaN', 
		strategy='mean'
		axis=0)

	# Fit over data with missing values and transform dataset. Assume that
	# columns 1-2 have missing values.
	imputer = imputer.fit(X[:, 1:3])
	X[:, 1:3] = imputer.transform(X[:, 1:3])
	return X

def impute_mice(X):
	# fancyimpute is a downloadable package capable of kNN, NMM, soft impute,
	# MSE, MICE, and low-rank SVD.
	X_new = fancyimpute.MICE(n_imputations=100).complete(X)
	return X_new