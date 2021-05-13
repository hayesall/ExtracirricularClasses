# Copyright © 2021 Alexander L. Hayes

"""
Optical Character Recognition Example

Usage
-----

    python -m naive_bayes_py
"""

import numpy as np
from .utils import load_training_letters
from .utils import load_letters
from .utils import make_denoised_image
from .utils import Alphabet
from .naive_bayes import NaiveBayesClassifier


alphabet = Alphabet()
train_letters = load_training_letters("courier-train.png")
test_letters = load_letters("00.png")


X_train = np.array([train_letters[letter].array.ravel() for letter in train_letters])
y_train = np.array([alphabet[letter] for letter in train_letters])
X_test = np.array([np.array(letter).ravel() for letter in test_letters])


clf = NaiveBayesClassifier(alpha=1.3)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)


print("".join(alphabet[l] for l in y_pred))
make_denoised_image("output-py.png", y_pred)
