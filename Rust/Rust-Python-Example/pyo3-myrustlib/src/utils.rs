// Copyright 2020 Alexander L. Hayes

//! # Utilities for Creating Random Strings
//!
//! The results on benchmarking several functions looked something like the following:
//!
//! ```text
//! -------------------------------------------------------------------------------------------- benchmark: 8 tests -------------------------------------------------------------------------------------------
//! Name (time in ms)                           Min                 Max                Mean            StdDev              Median               IQR            Outliers       OPS            Rounds  Iterations
//! -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//! test_rust_slice_parallel                 2.6802 (1.0)        3.7394 (1.0)        2.8409 (1.0)      0.1307 (1.11)       2.8042 (1.0)      0.1140 (1.15)        62;25  351.9985 (1.0)         338           1
//! test_rust_count_doubles_once_bytes       3.6355 (1.36)       7.5244 (2.01)       3.8326 (1.35)     0.3366 (2.86)       3.7873 (1.35)     0.1289 (1.30)          4;4  260.9174 (0.74)        143           1
//! test_rust_slice                          5.8683 (2.19)       6.8399 (1.83)       6.0147 (2.12)     0.1177 (1.0)        5.9913 (2.14)     0.1125 (1.13)         27;6  166.2586 (0.47)        163           1
//! test_rust_once                           6.6432 (2.48)       7.4509 (1.99)       6.7822 (2.39)     0.1258 (1.07)       6.7422 (2.40)     0.0994 (1.0)          21;9  147.4439 (0.42)        147           1
//! test_rust                               12.0188 (4.48)      13.3313 (3.57)      12.2338 (4.31)     0.2570 (2.18)      12.1412 (4.33)     0.1234 (1.24)         9;11   81.7411 (0.23)         81           1
//! test_regex                             198.8241 (74.18)    200.5102 (53.62)    199.6364 (70.27)    0.6578 (5.59)     199.6228 (71.19)    1.0584 (10.65)         2;0    5.0091 (0.01)          6           1
//! -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//! ```
//!
//! This appeared to be a definite suggestion that the fastest method was the `rust_slice_parallel`
//! corresponding to the `count_doubles_slice_parallel` method, while the slowest methods were
//! the pure Python implementations. Here we see that the fastest Python implementation based on
//! regular expressions (`test_regex`) was still around 70x slower than the Rust implementation.
//!
//! However, there is some wisdom of software development that amounts to saying "*profiling is
//! important because people are bad at knowing where the actual bottlenecks are.*"
//! An interesting thing I found while profiling my Python routines was that the methods for
//! counting pairs of strings was not the most expensive function. In reality, one of the most
//! expensive functions was this:
//!
//! ```python
//! val = "".join(random.choice(string.ascii_letters) for i in range(10000000))
//! ```
//!
//! Using the built-in `cProfile`, we see that the `count_double_regex(val)` call using the
//! Python `re` library to count doubles accounts for almost no time at all. Where is all the
//! time actually spent? In the random number generator and in the `join` method:
//!
//! ```text
//! 62304244 function calls in 11.263 seconds
//!
//! Ordered by: cumulative time
//!
//! ncalls  tottime  percall  cumtime  percall filename:lineno(function)
//! 1    0.683    0.683   11.074   11.074 {method 'join' of 'str' objects}
//! 10000001    2.163    0.000   10.391    0.000 doubles_pyo3.py:39(<genexpr>)
//! 10000000    2.748    0.000    8.228    0.000 /home/hayesall/miniconda3/envs/test/lib/python3.7/random.py:256(choice)
//! 10000000    3.550    0.000    5.017    0.000 /home/hayesall/miniconda3/envs/test/lib/python3.7/random.py:224(_randbelow)
//! 12304238    1.030    0.000    1.030    0.000 {method 'getrandbits' of '_random.Random' objects}
//! 10000001    0.463    0.000    0.463    0.000 {built-in method builtins.len}
//! 10000000    0.437    0.000    0.437    0.000 {method 'bit_length' of 'int' objects}
//! 1    0.000    0.000    0.190    0.190 doubles_pyo3.py:31(count_double_regex)
//! 1    0.189    0.189    0.189    0.189 {method 'findall' of 're.Pattern' objects}
//! 1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
//! ```
//!
//! Switching to use a Rust definition of `random_string` reduces this huge number of function
//! calls from taking around 11 seconds down to 0.242 seconds.

use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use std::convert::TryInto;

/// Generate a random alphanumeric string (a-z, A-Z, 0-9) of a given length.
pub fn random_string(_val: u64) -> String {
    let rand_string: String = thread_rng()
        .sample_iter(&Alphanumeric)
        .take(_val.try_into().unwrap())
        .map(char::from)
        .collect();

    return rand_string;
}
