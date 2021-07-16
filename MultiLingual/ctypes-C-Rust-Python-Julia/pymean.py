# Copyright © 2021 Alexander L. Hayes

"""
CDLL and ctypes for calling a C-like function from Python
"""

from ctypes import c_double
import ctypes
import pathlib


class MyCLib:
    def __init__(self):
        lib = pathlib.Path().absolute() / "libmean.so"
        self.c_lib = ctypes.CDLL(lib)

    def mean(self, a, b):
        _mean = self.c_lib.mean
        _mean.restype = c_double
        return _mean(c_double(a), c_double(b))

    def __repr__(self):
        return "MyCLib"


class MyRustLib:
    def __init__(self):
        lib = pathlib.Path().absolute() / "target/release/librustmeanffi.so"
        self.c_lib = ctypes.CDLL(lib)

    def mean(self, a, b):
        _mean = self.c_lib.mean
        _mean.restype = c_double
        return _mean(c_double(a), c_double(b))

    def __repr__(self):
        return "MyRustLib"


if __name__ == "__main__":

    libs = [MyCLib(), MyRustLib()]

    for i, j in [(10.0, 20.0), (1.0, 2.0), (10, 20), (1, 2.9)]:
        print([(lib, lib.mean(i, j)) for lib in libs])
