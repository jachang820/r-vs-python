# Import dataset
df = read.csv('data.csv')

# Encode categorical data into numbers
# Assume we need to convert country names to categories
df$Country = factor(df$Country, 
										levels=c('France', 'Spain', 'Germany'),
										labels=c(1, 2, 3))

# Note that one-hot is not necessary for R.