# **Python** 🐍 + **Rust** ⚙️ Example

This pulls from a RedHat blog post ["Speed up your Python using Rust"](https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/)
by [Bruno Rocha](https://developers.redhat.com/blog/author/brocha/) and the accompanying [GitHub repository](https://github.com/rochacbruno/rust-python-example/).

This makes a few additions beyond the publication, such as:

1. Parallel iterators with the [`rayon`](https://crates.io/crates/rayon) package
2. Implements in `PyO3`, instead of using `cpython` as in the original post
3. `pyo3-myrustlib` is built like a Rust crate, with `lib.rs` only handling Python wrapping.
  I suspect using Rust's module system in a way similar to this pattern would be more common in
  practice, with the added benefit that each component (`counters.rs`, `utils.rs`)
  can be tested separately.

## Building and Running

This requires a [Rust toolchain](https://www.rust-lang.org/tools/install)
(e.g. cargo) and Python.

### Python Setup

The Python implementations operate entirely out of the standard library, but
a couple dependencies are needed for benchmarking:

```bash
pip install -r requirements.txt
```

### Rust Setup

The `Cargo.toml` in `pyo3-myrustlib` is configured to build a shared object,
which on Ubuntu will result in `target/release/libpyo3_myrustlib.so` being
built. On Windows/macOS this will likely result in something slightly different
(e.g. a `.dylib`).

```bash
cd pyo3-myrustlib/
./release.sh        # cargo build --release; (then move the .so)
cd ..
```

### Running the Benchmarking

With dependencies satisfied, benchmarking should be as simple as:

```bash
pytest doubles_pyo3.py
```

## Unexpected Detours

There's a gem of software engineering wisdom by Martin Fowler:

> "Most programmers, even experienced ones, **are poor judges of how code actually
> performs**. Many of our intuitions are broken by clever compilers, modern
> caching techniques, and the like. The performance of software usually depends
> on just a few parts of the code, and changes anywhere else don't make an
> appreciable difference."
>
> &mdash; Martin Fowler, "Refactoring: Improving the Design of Existing Code." 2nd Edition. Addison-Wesley. pp. 20

I generally found that the `PyO3` extensions were slightly faster, but the
differences were negligible overall. When I started incorporating the
parallel iterators with `rayon`, I was able to get a decent speed up with a
really small change to the code.

### Benchmarking

All of these were still being done with the
[`pytest-benchmark`](https://pytest-benchmark.readthedocs.io/en/latest/)
suite of tools, which provided a table showing the performance of different
implementations in milliseconds:

```console
-------------------------------------------------------------------------------------------- benchmark: 8 tests -------------------------------------------------------------------------------------------
Name (time in ms)                           Min                 Max                Mean            StdDev              Median               IQR            Outliers       OPS            Rounds  Iterations
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
test_rust_slice_parallel                 2.6802 (1.0)        3.7394 (1.0)        2.8409 (1.0)      0.1307 (1.11)       2.8042 (1.0)      0.1140 (1.15)        62;25  351.9985 (1.0)         338           1
test_rust_count_doubles_once_bytes       3.6355 (1.36)       7.5244 (2.01)       3.8326 (1.35)     0.3366 (2.86)       3.7873 (1.35)     0.1289 (1.30)          4;4  260.9174 (0.74)        143           1
test_rust_slice                          5.8683 (2.19)       6.8399 (1.83)       6.0147 (2.12)     0.1177 (1.0)        5.9913 (2.14)     0.1125 (1.13)         27;6  166.2586 (0.47)        163           1
test_rust_once                           6.6432 (2.48)       7.4509 (1.99)       6.7822 (2.39)     0.1258 (1.07)       6.7422 (2.40)     0.0994 (1.0)          21;9  147.4439 (0.42)        147           1
test_rust                               12.0188 (4.48)      13.3313 (3.57)      12.2338 (4.31)     0.2570 (2.18)      12.1412 (4.33)     0.1234 (1.24)         9;11   81.7411 (0.23)         81           1
test_regex                             198.8241 (74.18)    200.5102 (53.62)    199.6364 (70.27)    0.6578 (5.59)     199.6228 (71.19)    1.0584 (10.65)         2;0    5.0091 (0.01)          6           1
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```

`test_regex` is a Python implementation, and is firmly at the bottom of the list
by a wide margin. On average it takes 199 ms
to execute, making it 70x slower than the fastest Rust implementation.

But the benchmarks *only* provide a window into the speed for each function.

### Digging in with cProfile

It wasn't until I switched into the Python standard library's
[`cProfile`](https://docs.python.org/3/library/profile.html) and actually
profiled the actual Python call stack that I figured out why I wasn't seeing
much further speed ups to the program overall:

```console
62304244 function calls in 11.263 seconds

Ordered by: cumulative time

  ncalls  tottime  percall  cumtime  percall filename:lineno(function)
       1    0.683    0.683   11.074   11.074 {method 'join' of 'str' objects}
10000001    2.163    0.000   10.391    0.000 doubles_pyo3.py:39(<genexpr>)
10000000    2.748    0.000    8.228    0.000 /home/hayesall/miniconda3/envs/test/lib/python3.7/random.py:256(choice)
10000000    3.550    0.000    5.017    0.000 /home/hayesall/miniconda3/envs/test/lib/python3.7/random.py:224(_randbelow)
12304238    1.030    0.000    1.030    0.000 {method 'getrandbits' of '_random.Random' objects}
10000001    0.463    0.000    0.463    0.000 {built-in method builtins.len}
10000000    0.437    0.000    0.437    0.000 {method 'bit_length' of 'int' objects}
       1    0.000    0.000    0.190    0.190 doubles_pyo3.py:31(count_double_regex)
       1    0.189    0.189    0.189    0.189 {method 'findall' of 're.Pattern' objects}
       1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
```

The third-to-last line:

```console
ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     1    0.000    0.000    0.190    0.190 doubles_pyo3.py:31(count_double_regex)
```

... measurement of `cumtime` (cumulative time) agrees with the benchmarks for
the `test_regex` in the previous section: it takes around 190 ms for the
function to complete.

But even the slow Python implementation looks fast compared to the call that
took the most cumulative time:

```console
ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     1    0.683    0.683   11.074   11.074 {method 'join' of 'str' objects}
```

That is **11.074 seconds**. There's a `join` call in my code that is
**58x slower** than the slowest Python `count_doubles` method, and
**389x slower** than the fastest Rust implementation.

What was the culprit?

```python
val = "".join(random.choice(string.ascii_letters) for i in range(10000000))
```

The bottleneck in my code was in generating a test case to benchmark the rest
of my code.

### Fixing the *actual* bottleneck

Since I already had a Rust module, I might as well rewrite this section with a
lower-level call:

```rust
use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use std::convert::TryInto;

pub fn random_string(_val: u64) -> String {
    let rand_string: String = thread_rng()
        .sample_iter(&Alphanumeric)
        .take(_val.try_into().unwrap())
        .map(char::from)
        .collect();

    return rand_string;
```

This technically violates the specification assumed by the
`random.choice(string.ascii_letters)` since Rust's
`rand::distributions::Alphanumeric` contains the ASCII letters and numerals;
but any long string of characters is sufficient benchmarking.

Implementing this in Rust drops the time from 11 seconds down to around
0.242 (45x faster).

The 242 milliseconds is still 86x slower than the 2.8 milliseconds required
by `test_rust_slice_parallel`, but both of these feel like rounding errors
compared to the painful 11 seconds I was sitting through while waiting for the
initial benchmarks to run.
