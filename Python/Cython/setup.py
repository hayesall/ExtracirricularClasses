from setuptools import setup
from Cython.Build import cythonize

setup(
    name='fib_demo',
    ext_modules=cythonize("Fibo/*.pyx"),
    zip_safe=False,
)
