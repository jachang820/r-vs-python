install.packages('ggplot2')
library(ggplot2)

# Interpolate more points to make it easier to visualize
# model prediction. This is especially necessary for CART
# algorithms to properly show the nodes.
smooth_regression_line = function(test, model) {
	X_grid = seq(min(test$x1), max(test$x1), 0.1)
	y_pred = predict(mode, newdata=X_grid)
	return(list[X_grid, y_pred])
}

# Scatter plot dataset with regression line
scatterplot = function(train, test, y_pred, model, is_smooth) {
	if (is_smooth == TRUE) {
		list[X_grid, y_pred] = smooth_regression_line(test, model)
		test = list[1]
		y_pred = list[2]
	}
	
	ggplot() +
		geom_point(aes(x=train$x1, y=train$y), colour='red') +
		geom_point(aes(x=test$x1, y=test$y), colour='pink') +
		geom_line(aes(x=test$x1, y=y_pred), colour='blue') +
		ggtitle('Prediction') +
		xlab('Independent variable') +
		ylab('Dependent variable')
}