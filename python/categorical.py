import pandas as pd

# Import dataset
df = pd.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Encode categorical data into numbers
# Assume categorical data on column 0
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
X[:, 0] = labelencoder_X.fit_transform(X[:, 0])

# Use one-hot encoding to turn one column with n categories
# into n columns, since categories don't have ordering.
onehotencoder = OneHotEncoder(categorical_features=[0])
cat_X = (X[:, 0]).reshape(len(X), 1)
factors = onehotenc.fit_transform(cat_X).toarray()

# Replace categorical labels with factors
import numpy as np
X = np.append(X[:, :-1], factors, axis=1)

# Avoid dummy variable trap
X = X[:, :-1]