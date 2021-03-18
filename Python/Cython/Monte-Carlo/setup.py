#  Copyright © 2021 Alexander L. Hayes

from setuptools import setup
from setuptools import Extension
from Cython.Build import cythonize
import numpy as np


setup(
    name="monte_carlo_examples",
    ext_modules=cythonize(
        [
            "mcp/*.pyx",
            Extension("mcp.dice", ["mcp/dice.pyx"]),
        ],

        # TODO(hayesall): language_level 3 does not work with the pxd files.
        # compiler_directives={"language_level": "3"},
    ),
    include_dirs=[np.get_include()],
    zip_safe=False,
)
