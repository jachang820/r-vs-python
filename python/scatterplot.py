import matplotlib.pyplot as plt

# Interpolate more points to make it easier to visualize
# model prediction. This is especially necessary for CART
# algorithms to properly show the nodes.
def smooth_regression_line(X_test, model):
	X_grid = np.arange(min(X_test), max(X_test), 0.1)
	X_grid = X_grid.reshape((len(X_grid), 1))
	y_pred = model.predict(X_grid)
	return X_grid, y_pred

# Scatter plot dataset with regression line
def scatterplot(X_train, X_test, y_train, y_test, y_pred, model, is_smooth):
	if is_smooth == True:
		X_test, y_pred = smooth_regression_line(X_test, model)
		
	plt.scatter(X_train[:, 0], y_train, color='red')
	plt.scatter(X_test[:, 0], y_test, color='pink')
	plt.plot(X_test[:, 0], y_pred, color='blue')
	plt.title('Prediction')
	plt.xlabel('Independent variable')
	plt.ylabel('Dependent variable')
	plt.show()
