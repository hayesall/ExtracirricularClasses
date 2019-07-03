# Copyright © 2019 Alexander L. Hayes
# MIT License

"""
Rod Cutting
-----------

Implementation of the naive top-down recursive rod cutting algorithm from
"Introduction to Algorithms." [1]_

References
----------

.. [1]_ Cormen, Thomas H., Leiserson, Charles E., Rivest, Ronald L.,
   Stein, Clifford. "Dynamic Programming." In *Introduction to Algorithms*,
   3rd Edition.
"""

import numpy as np

def naive_cut_rod(p, n):
    """Cut-Rod

    Cut-Rod algorithm from page 363

    Parameters
    ----------
    p : ndarray
        Numpy array of length prices
    n : int
        Rod length to calculate optimal value for

    Examples
    --------

    >>> import numpy as np
    >>> from pyalgorithms.rod_cutting import naive_cut_rod
    >>> naive_cut_rod(np.array([0, 1, 5, 8, 9, 10, 17, 20, 24]), 7)
    20
    """
    if n == 0:
        return 0
    q = -float("inf")
    for i in np.arange(1, n + 1):
        if i >= p.size:
            _try = -float("inf")
        else:
            _try = p[i]
        q = max(q, _try + naive_cut_rod(p, n - i))
    return q

if __name__ == "__main__":
    prices = np.array([0.0, 1.0, 5.0, 8.0, 9.0, 10.0, 17.0, 17.0, 20.0, 24.0, 30.0])
    for i in range(25):
        print(i, naive_cut_rod(prices, i))
