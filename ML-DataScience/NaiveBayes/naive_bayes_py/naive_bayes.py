# Copyright © 2021 Alexander L. Hayes
# MIT License

"""
Multiclass-class Naive Bayes Classifier

Overview
--------

Here is a flavor for how the syntax works (this should look familiar if you've
used ``scikit-learn`` before):

.. code-block:: python

    >>> from part3.naive_bayes import NaiveBayesClassifier
    >>> clf = NaiveBayesClassifier(alpha=1)
    >>> clf.fit(X_train, y_train)
    NaiveBayesClassifier(alpha=1)
    >>> clf.predict(X_test)
    [1 1 1 ... 0 0 0]
"""

import numpy as np


class NaiveBayesClassifier:
    """Multiclass NaiveBayesClassifier

    alpha :
        Laplace correction value (Default: 1.0)
    prior : None or array-like
        If None: fit the prior to the training data
    """

    def __init__(self, alpha=1.0, prior=None):
        self.alpha = alpha
        self.classes = None
        self.priors = prior
        self.probs = None

        if prior:
            assert np.sum(prior) == 1.0

    def fit(self, X, y):
        # Warning: This assumes y is discretized into 0/1/2/...

        self.classes, _class_frequency = np.unique(y, return_counts=True)

        if not self.priors:
            self.priors = _class_frequency / np.sum(_class_frequency)

        data = np.c_[y, X]
        self.probs = np.zeros((self.classes.shape[0], X.shape[1]))

        for i, c in enumerate(self.classes):
            _y = np.where(data[:, 0] == c)
            prob = np.sum(data[_y][:, 1:], axis=0)
            prob_denom = np.sum(prob) + prob.shape[0]
            self.probs[i] = np.log((prob + self.alpha) / prob_denom)

        return self

    def predict(self, X):
        return np.argmax(self.priors + np.dot(X, self.probs.T), axis=1)

    def __repr__(self):
        return self.__class__.__name__ + "(alpha=" + str(self.alpha) + ")"
