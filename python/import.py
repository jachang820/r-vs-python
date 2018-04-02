import pandas as pd

# Import dataset
df = pd.read_csv('data.csv')
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

# Display summary statistics
summary = df.describe()
print(summary)

# Examine first 10 rows of data
head = df.head(10)
print(head)

# Display dataset structure
structure = df.info()
print(structure)