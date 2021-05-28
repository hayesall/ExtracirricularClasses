# Naïve Bayes - Python

## Implementation Notes

The API mimics `scikit-learn`'s API.

```python
import numpy as np
from naive_bayes_py.naive_bayes import NaiveBayesClassifier

X_train = np.array([[0, 0, 1], [0, 1, 1], [1, 0, 0]])
y_train = np.array([0, 1, 2])

clf = NaiveBayesClassifier()
clf.fit(X_train, y_train)

X_test = np.array([[0, 0, 0], [1, 1, 0], [1, 1, 1]])
print(clf.predict(X_test))
# [0 2 1]
```
