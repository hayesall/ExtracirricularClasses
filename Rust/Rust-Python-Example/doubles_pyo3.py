import re
import string
import random
import pyo3_myrustlib


def count_doubles(val):
    total = 0
    for c1, c2 in zip(val, val[1:]):
        if c1 == c2:
            total += 1
    return total


def count_doubles_once(val):
    total = 0
    chars = iter(val)
    c1 = next(chars)
    for c2 in chars:
        if c1 == c2:
            total += 1
        c1 = c2
    return total


double_re = re.compile(r"(?=(.)\1)")


def count_double_regex(val):
    return len(double_re.findall(val))


# Solution:
val = "".join(random.choice(string.ascii_letters) for i in range(10000000))
_ANSWER = count_double_regex(val)


def test_solve_count_doubles_rust():
    assert pyo3_myrustlib.count_doubles(val) == _ANSWER


def test_solve_count_doubles_once_rust():
    assert pyo3_myrustlib.count_doubles_once(val) == _ANSWER


def test_solve_c_bytes_once():
    assert pyo3_myrustlib.count_doubles_once_bytes(val) == _ANSWER


def test_solve_rust_slice():
    assert pyo3_myrustlib.count_doubles_slice(val) == _ANSWER


def test_solve_rust_slice_parallel():
    assert pyo3_myrustlib.count_doubles_slice_parallel(val) == _ANSWER


# Benchmarking Between Rust vs. Python

def test_pure_python(benchmark):
    print(benchmark(count_doubles, val))


def test_pure_python_once(benchmark):
    print(benchmark(count_doubles_once, val))


def test_regex(benchmark):
    print(benchmark(count_double_regex, val))


def test_rust(benchmark):
    print(benchmark(pyo3_myrustlib.count_doubles, val))


def test_rust_once(benchmark):
    print(benchmark(pyo3_myrustlib.count_doubles_once, val))


def test_rust_count_doubles_once_bytes(benchmark):
    print(benchmark(pyo3_myrustlib.count_doubles_once_bytes, val))


def test_rust_slice(benchmark):
    print(benchmark(pyo3_myrustlib.count_doubles_slice, val))


def test_rust_slice_parallel(benchmark):
    print(benchmark(pyo3_myrustlib.count_doubles_slice_parallel, val))
