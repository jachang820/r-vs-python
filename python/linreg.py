import pandas as pd

# Import dataset
df = pdf.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Split into training and test sets
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Fit linear regression to training set
from sklearn.linear_model import LinearRegression
model = LinearRegression()
model.fit(X_train, y_train)

# Predict test set
y_pred = model.predict(X_test)

# Plot predictions using one variable
import matplotlib.pyplot as plt
plt.scatter(X_train[:, 0], y_train, color='red')
plt.scatter(X_test[:, 0], y_test, color='pink')
plt.plot(X_test[:, 0], y_pred, color='blue')
plt.title('Prediction')
plt.xlabel('Independent variable')
plt.ylabel('Dependent variable')
plt.show()