// Copyright 2017 Bruno Rocha
// 2020 Edits by Alexander L. Hayes

//! ## Overview
//!
//! This is a recreation of some routines from a RedHat blog post by Bruno Rocha:
//! "*Speed up your Python with Rust*."
//!
//!
//! ## Usage
//!
//! ```bash
//! ./release.sh
//! ```

#[macro_use]
extern crate cpython;
extern crate rayon;

use cpython::{PyResult, Python};
use rayon::prelude::*;

/// Count doubles by zipping two `chars` iterables.
pub fn count_doubles(val: &str) -> u64 {
    let mut total = 0u64;
    for (c1, c2) in val.chars().zip(val.chars().skip(1)) {
        if c1 == c2 {
            total += 1;
        }
    }
    return total;
}

/// Count doubles on a single `chars` iterable.
pub fn count_doubles_once(val: &str) -> u64 {
    let mut total = 0u64;
    let mut chars = val.chars();
    if let Some(mut c1) = chars.next() {
        for c2 in chars {
            if c1 == c2 {
                total += 1;
            }
            c1 = c2;
        }
    }
    return total;
}

/// Count doubles on a single `bytes` iterable.
pub fn count_doubles_once_bytes(val: &str) -> u64 {
    let mut total = 0u64;
    let mut chars = val.bytes();
    if let Some(mut c1) = chars.next() {
        for c2 in chars {
            if c1 == c2 {
                total += 1;
            }
            c1 = c2;
        }
    }
    return total;
}

/// Count doubles on a functional iterable over `byte` windows.
pub fn count_doubles_slice(val: &str) -> u64 {
    let count = val
        .as_bytes()
        .windows(2)
        .filter(|slice| slice[0] == slice[1])
        .count();
    return count as u64;
}

/// Count doubles over parallel windows of `byte`
pub fn count_doubles_slice_parallel(val: &str) -> u64 {
    let count = val
        .as_bytes()
        .par_windows(2)
        .filter(|slice| slice[0] == slice[1])
        .count();
    return count as u64;
}

// Register Python Functions
fn python_count_doubles(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles(&val))
}
fn python_count_doubles_once(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_once(&val))
}
fn python_count_doubles_once_bytes(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_once_bytes(&val))
}
fn python_count_doubles_slice(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_slice(&val))
}
fn python_count_doubles_slice_parallel(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_slice_parallel(&val))
}

py_module_initializer!(
    cpython_myrustlib,
    initcpython_myrustlib,
    PyInit_cpython_myrustlib,
    |py, m| {
        m.add(py, "__doc__", "This module is implemented in Rust")?;
        m.add(
            py,
            "count_doubles",
            py_fn!(py, python_count_doubles(val: &str)),
        )?;
        m.add(
            py,
            "count_doubles_once",
            py_fn!(py, python_count_doubles_once(val: &str)),
        )?;
        m.add(
            py,
            "count_doubles_once_bytes",
            py_fn!(py, python_count_doubles_once_bytes(val: &str)),
        )?;
        m.add(
            py,
            "count_doubles_slice",
            py_fn!(py, python_count_doubles_slice(val: &str)),
        )?;
        m.add(
            py,
            "count_doubles_slice_parallel",
            py_fn!(py, python_count_doubles_slice_parallel(val: &str)),
        )?;
        Ok(())
    }
);

// Tests
#[cfg(test)]
mod tests {

    #[test]
    fn test_count_doubles() {
        assert_eq!(super::count_doubles("00"), 1);
        assert_eq!(super::count_doubles("0011"), 2);
        assert_eq!(super::count_doubles("00bb11a"), 3);
    }

    #[test]
    fn test_count_doubles_once() {
        assert_eq!(super::count_doubles_once("00"), 1);
        assert_eq!(super::count_doubles_once("0011"), 2);
        assert_eq!(super::count_doubles_once("00bb11a"), 3);
    }

    #[test]
    fn test_count_doubles_once_bytes() {
        assert_eq!(super::count_doubles_once_bytes("00"), 1);
        assert_eq!(super::count_doubles_once_bytes("0011"), 2);
        assert_eq!(super::count_doubles_once_bytes("00bb11a"), 3);
    }

    #[test]
    fn test_count_doubles_slice() {
        assert_eq!(super::count_doubles_slice("00"), 1);
        assert_eq!(super::count_doubles_slice("0011"), 2);
        assert_eq!(super::count_doubles_slice("00bb11a"), 3);
    }

    #[test]
    fn test_count_doubles_once_slice_parallel() {
        assert_eq!(super::count_doubles_slice_parallel("00"), 1);
        assert_eq!(super::count_doubles_slice_parallel("0011"), 2);
        assert_eq!(super::count_doubles_slice_parallel("00bb11a"), 3);
    }
}
