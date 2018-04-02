# Import dataset
df = read.csv('data.csv')

drop_missing = function(df) {
	df_new = na.omit(df)
	return(df_new)
}

# Install and load the 'mice' package to simplify imputations. MICE package 
# is also capable of, RPART, logistic regression, Midas Touch, linear
# regression, bootstrapping, linear discriminant analysis, predictive mean
# matching, polynomial regression, quadratic terms, random forests
install.packages('mice')
library(mice)

impute_mean = function(df) {
	# Imputer only works on one column at a time
	helper = function(vec) {
		vec[is.na(vec)] = mice.impute.mean(vec, !is.na(vec))
		return(vec)
	}

	# Apply helper function to each column of data frame
	df_new = sapply(df, function(vec) helper(vec))
	return(df_new)
}

impute_mice = function(df) {
	impute = mice(df, m=100)
	df_new = complete(impute)
	return(df_new)
}