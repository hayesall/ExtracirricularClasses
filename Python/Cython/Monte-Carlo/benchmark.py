# Copyright © 2021 Alexander L. Hayes

from mcp.pure_python import dice6_py
from mcp.pure_python import dice6_vec1
from mcp.pure_python import dice6_vec2
from mcp.cython_implementations import dice6_cy1
from mcp.cython_implementations import dice6_cy2
from mcp.cython_implementations import dice6_cy3
from mcp.cython_implementations import dice6_cy4
from mcp.dice import dice6_cwrap


args = (450000, 5, 3)

"""
def test_plain_python(benchmark):
    print(benchmark(dice6_py, *args))
"""


def test_vec_Python_v1(benchmark):
    print(benchmark(dice6_vec1, *args))


"""
def test_vec_Python_v2(benchmark):
    print(benchmark(dice6_vec2, *args))
"""

"""
def test_Cython_random_randint(benchmark):
    print(benchmark(dice6_cy1, *args))
"""


def test_Cython_numpy_random(benchmark):
    print(benchmark(dice6_cy2, *args))


def test_Cython_bit_generator(benchmark):
    print(benchmark(dice6_cy4, *args))


def test_Cython_stdlib_rand(benchmark):
    print(benchmark(dice6_cy3, *args))


def test_c_wrapped(benchmark):
    print(benchmark(dice6_cwrap, *args))
