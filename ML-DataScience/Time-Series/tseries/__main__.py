# Copyright © 2021 Alexander L. Hayes

import numpy as np
from .keras_version import train_lstm_keras

raw_data = np.array([10, 20, 30, 40, 50, 60, 70, 80, 90])

print(train_lstm_keras(raw_data))
