import pandas as pd

# Import dataset
df = pd.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Split into training and test set
# test_size specifies proportion of the test set
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Apply 10 folds cross-validation
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score
model = LinearRegression()
scores = cross_val_score(model, X_train, y_train, cv=10)

# Report score
print("Accuracy %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))