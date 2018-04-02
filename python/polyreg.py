import pandas as pd

# Import dataset
df = pdf.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Transform features to polynomials
from sklearn.preprocessing import PolynomialFeatures
poly_features = PolynomialFeatures(degree=4)
X_poly = poly_features.fit_transform(X)

# Split into training and test sets
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X_poly, y, test_size=0.2)

# Fit polynomial linear regression to training set
poly_model = LinearRegression()
poly_model.fit(X_train, y_train)

# Predict test set
y_pred = model.predict(X_test)