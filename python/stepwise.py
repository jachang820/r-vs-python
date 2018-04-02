import pandas as pd

# Import dataset
df = pd.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# These libraries enable matrix algebra and ordinary least squares.
import numpy as np
import statsmodels.formula.api as sm

# Vectorize bias, such that w^T x + b = [b w]^T [1 x] 
X = np.append(np.ones((len(X), 1), dtype=int), X, axis=1)

# Find optimal features
X_opt = X[:, :]
SL_STAY = 0.03
SL_ENTER = 0.05

# Start with all indices excluded
excluded = list(range(len(X[0])))
included = list([])
changed = True

# Loop until no more features are included or excluded
while changed is not (not excluded):

	# Perform forward selection
	X_opt = X[:, excluded]

	# Fit ordinary least squares on excluded list
	# Select best p-value
	model_OLS = sm.OLS(y, X_opt).fit()
	min_index = model_OLS.pvalues.argmin()

	# Include best feature if its p-value is below threshold
	if model_OLS.pvalues[min_index] < SL_ENTER:
		included.append(excluded.pop(min_index))
		changed = True
	
	else:
		changed = False

	# Perform backward elimination
	while changed:
		
		X_opt = X[:, included]

		# Perform new fit, find maximum p-value
		model_OLS = sm.OLS(y, X_opt).fit()
		max_index = model_OLS.pvalues.argmax()

		# Remove feature if its p-value is above threshold
		if model_OLS.pvalues[max_index] > SL_STAY:
			del included[max_index]
		else:
			break

# Report optimal X
print(model_OLS.summary())