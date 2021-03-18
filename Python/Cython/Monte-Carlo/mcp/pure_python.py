# Copyright © 2012 Hans Petter Langtangen
# Copyright © 2021 Alexander L. Hayes

"""
Scalar Python implementation
============================

This is referred to as the "plain Python implementation" in the post.
"""

import random
import numpy as np


def dice6_py(N, ndice, nsix):
    M = 0
    for i in range(N):
        six = 0
        for j in range(ndice):
            r = random.randint(1, 6)
            if r == 6:
               six += 1
        if six >= nsix:
            M += 1
    p = float(M)/N
    return p


def dice6_vec1(N, ndice, nsix):
    eyes = np.random.randint(1, 7, size=(N, ndice))
    compare = eyes == 6
    throws_with_6 = np.sum(compare, axis=1)  # sum over columns
    nsuccesses = throws_with_6 >= nsix
    M = np.sum(nsuccesses)
    p = float(M)/N
    return p


def dice6_vec2(N, ndice, nsix):
    eyes = np.random.randint(1, 7, (N, ndice))
    six = [6 for i in range(ndice)]
    M = 0
    for i in range(N):
        # Check experiment no. i:
        compare = eyes[i,:] == six
        if np.sum(compare) >= nsix:
            M += 1
    p = float(M)/N
    return p
