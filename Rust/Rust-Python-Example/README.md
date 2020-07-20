# Rust Python Example

This pulls from a RedHat blog post ["Speed up your Python using Rust"](https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/)
by [Bruno Rocha](https://developers.redhat.com/blog/author/brocha/) and the accompanying [GitHub repository](https://github.com/rochacbruno/rust-python-example/).

This makes a few additions beyond the publication, such as:

1. Parallel iterators with the [`rayon`](https://crates.io/crates/rayon) package
2. Some notes on `cpython` (as used in the original post) vs. `PyO3` (a fork of `cpython`).
