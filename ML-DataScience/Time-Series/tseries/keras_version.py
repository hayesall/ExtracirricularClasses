# Copyright © 2021 Alexander L. Hayes

"""
Quick overview of Stacked LSTM, based on this blog post:
https://machinelearningmastery.com/how-to-develop-lstm-models-for-time-series-forecasting/
"""

import numpy as np
from tensorflow.keras import Sequential
from tensorflow.keras.layers import LSTM
from tensorflow.keras.layers import Dense


def split_sequence(sequence, n_steps):
	X, y = list(), list()
	for i in range(len(sequence)):
		end_ix = i + n_steps
		if end_ix > len(sequence)-1:
			break
		seq_x, seq_y = sequence[i:end_ix], sequence[end_ix]
		X.append(seq_x)
		y.append(seq_y)
	return np.array(X), np.array(y)

def get_model(n_steps, n_features):
    model = Sequential()
    model.add(LSTM(50, activation="relu", return_sequences=True, input_shape=(n_steps, n_features)))
    model.add(LSTM(50, activation="relu"))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    return model


def train_lstm_keras(raw_data):

    N_STEPS = 3
    N_FEATURES = 1

    X, y = split_sequence(raw_data, N_STEPS)
    X = X.reshape((X.shape[0], X.shape[1], N_FEATURES))

    model = get_model(N_STEPS, N_FEATURES)
    model.fit(X, y, epochs=200, verbose=0)

    x_input = np.array([70, 80, 90])
    x_input = x_input.reshape((1, N_STEPS, N_FEATURES))
    yhat = model.predict(x_input)

    return yhat
