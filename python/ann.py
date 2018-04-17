import numpy as np
import pandas as pd

# Import dataset
df = pdf.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values


# Encode categorical data into numbers
# Assume categorical data on column 1-2
# df.apply() applies function to each column
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
X[:, 1:3] = X[:, 1:3].apply(labelencoder_X.fit_transform)

# Use one-hot encoding to turn one column with n categories
# into n columns, since categories don't have ordering.
onehotencoder = OneHotEncoder(categorical_features=[0])
cat_X = (X[:, 0]).reshape(len(X), 1)
factors = onehotenc.fit_transform(cat_X).toarray()

# Replace categorical labels with factors
X = np.append(X[:, :-1], factors, axis=1)

# Split into training and test sets
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Feature scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)

# Keras is a high-level wrapper around Tensorflow
import keras
from keras.models import Sequential
from keras.layers import Dense

# Initialize neural network
