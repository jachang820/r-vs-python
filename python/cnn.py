import numpy as np
import pandas as pd

# Keras is a high-level wrapper around Tensorflow
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Convolution2D
from keras.layers import MaxPooling2D
from keras.layers import Flatten

# Initialize neural network
model = Sequential()

# Convolve with 3x3.
# Tensorflow backend requires 64x64x3. Theano requires 3x64x64.
model.add(Convolution2D(32, 3, 3, 
												input_shape=(64, 64, 3), 
												activation='relu'))

# Apply max pooling
model.add(MaxPooling2D(pool_size=(2, 2)))

#Add second convolutional layer
model.add(Convolution2D(32, 3, 3, activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

# Flatten
model.add(Flatten())

# Add layers
model.add(Dense(output_dim=128, activation='relu'))
model.add(Dense(output_dim=1, activation='sigmoid'))
model.compile(optimizer='adam', 
							loss='binary_crossentropy', 
							metric=['accuracy'])

# Refer to Keras documentation under image preprocessing
from keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(
				rescale=1./255,
				shear_range=0.2,
				zoom_range=0.2,
				horizontal_flip=True)

test_datagen = ImageDataGenerator(rescale=1./255)

train = train_datagen.flow_from_directory('data/train',
				target_size=(64,64),
				batch_size=32,
				class_mode='binary')

test = test_datagen.flow_from_directory('data/test',
				target_size=(64,64),
				batch_size=32,
				class_mode='binary')

# Fit neural network to training set
model.fit_generator(train,
				samples_per_epoch=8000,
				nb_epoch=25,
				validation_data=test,
				nb_val_samples=2000)

# Predict test set
y_pred = model.predict(X_test)
y_pred = (y_pred > 0.5)

# Make confusion matrix
from sklearn.metrics import confusion_matrix
conf = confusion_matrix(y_test, y_pred)
