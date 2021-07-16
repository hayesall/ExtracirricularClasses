# *A fairly minimal multi-lingual ctypes demo*

I'd previously written Rust/Python extensions with PyO3, but now I want to
expose something similar for my Julia code. It looks like the cleanest way to
do this across languages is through foreign-function interfaces and the
`ctypes` and `ffi` implementations of individual languages.

This overview provides:

1. C and Rust code
2. Julia and Python code calling into these, via `ccall` and `ctypes` respectively

Drawbacks:

1. Single platform (\*nix)
2. *It works on my machine* and makes no attempt at distributing

## The Functionality

```c
double mean(double a, double b) {
  return (a + b) / 2;
}
```

```rust
#[no_mangle]
pub extern "C" fn mean(a: f64, b: f64) -> f64 {
    return (a + b) / 2.0;
}
```

## Building the Extensions

Build the C dylib (`gcc` and `make`):

```bash
make
```

Build the Rust dylib (`cargo` and the Rust toolchain):

```bash
cargo build
```

## Running the Examples

```bash
python pymean.py
julia jlmean.jl
```

## Further Reading

*Wishing I had a Chrome extension to dump my tabs to a bibliography.*

**Python**

- [`ctypes` - A foreign function library for Python](https://docs.python.org/3/library/ctypes.html). Python Standard Library Reference
- [Python Bindings: Calling C or C++ From Python](https://realpython.com/python-bindings-overview/). Real Python

**Julia**

- [Julia calling C: A minimal example](https://perfectionatic.org/?p=249). Perfectionatic's blog
- [Calling C and Fortran Code](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/). Julia Manual
- [C Interface](https://docs.julialang.org/en/v1/base/c/#ccall). Julia Manual, `Base` documentation
- [Dynamic Linker](https://docs.julialang.org/en/v1/stdlib/Libdl/). Julia Manual, `Standard Library` documentation

**Rust**

- [Cargo Targets](https://doc.rust-lang.org/cargo/reference/cargo-targets.html#the-crate-type-field). The Cargo Book
- [Linkage](https://doc.rust-lang.org/reference/linkage.html). The Rust Reference
- [Unsafe Rust: Using `extern` Functions to Call External Code](https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html#using-extern-functions-to-call-external-code). The Rust Programming Language
- [Calling Rust From Python](https://bheisler.github.io/post/calling-rust-in-python/). Brook Heisler's blog
- [Expose a Rust Library to Other Languages](https://sixtyfps.io/blog/expose-rust-library-to-other-languages.html). Sixty FPS
