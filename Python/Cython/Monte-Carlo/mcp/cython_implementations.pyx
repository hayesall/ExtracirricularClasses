#  Copyright © 2012 Hans Petter Langtangen
#  Copyright © 2021 Alexander L. Hayes

#cython: language_level=3

import cython
from libc.stdlib cimport rand
import numpy as np
cimport numpy as np
import random


def dice6_cy1(int N, int ndice, int nsix):
    cdef int M = 0
    cdef int six, r
    cdef double p
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


@cython.boundscheck(False)
def dice6_cy2(int N, int ndice, int nsix):
    cdef int M = 0
    cdef int six, r
    cdef double p
    cdef np.ndarray[np.int_t,
                    ndim=2,
                    negative_indices=False,
                    mode='c'] eyes = np.random.randint(1, 7, (N, ndice))
    for i in range(N):
        six = 0
        for j in range(ndice):
            r = eyes[i,j]
            if r == 6:
               six += 1
        if six >= nsix:
            M += 1
    p = float(M)/N
    return p


def dice6_cy3(int N, int ndice, int nsix):
    cdef int M = 0
    cdef int six, r
    cdef double p
    for i in range(N):
        six = 0
        for j in range(ndice):
            r = 1 + int(rand() % 6)
            if r == 6:
               six += 1
        if six >= nsix:
            M += 1
    p = float(M)/N
    return p


@cython.boundscheck(False)
def dice6_cy4(int N, int ndice, int nsix):
    # numpy with bit generators: around 2.5x faster than cy2
    cdef int M = 0
    cdef int six, r
    cdef double p
    rng = np.random.default_rng()
    cdef np.ndarray[np.int_t,
                    ndim=2,
                    negative_indices=False,
                    mode='c'] eyes = rng.integers(1, 7, (N, ndice))
    for i in range(N):
        six = 0
        for j in range(ndice):
            r = eyes[i,j]
            if r == 6:
               six += 1
        if six >= nsix:
            M += 1
    p = float(M)/N
    return p
