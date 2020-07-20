// Copyright 2020 Alexander L. Hayes

//! ## Overview
//!
//! Re-implements some of the methods with PyO3 (https://pyo3.rs/v0.11.1/)

extern crate rayon;

use pyo3::prelude::*;
use pyo3::wrap_pyfunction;
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


#[pyfunction]
fn python_count_doubles(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles(&val))
}
#[pyfunction]
fn python_count_doubles_once(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_once(&val))
}
#[pyfunction]
fn python_count_doubles_once_bytes(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_once_bytes(&val))
}
#[pyfunction]
fn python_count_doubles_slice(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_slice(&val))
}
#[pyfunction]
fn python_count_doubles_slice_parallel(_py: Python, val: &str) -> PyResult<u64> {
    Ok(count_doubles_slice_parallel(&val))
}


/// Shhh secret docstrings.
#[pymodule]
fn pyo3_myrustlib(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add("count_doubles", wrap_pyfunction!(python_count_doubles)(_py))?;
    m.add("count_doubles_once", wrap_pyfunction!(python_count_doubles_once)(_py))?;
    m.add("count_doubles_once_bytes", wrap_pyfunction!(python_count_doubles_once_bytes)(_py))?;
    m.add("count_doubles_slice", wrap_pyfunction!(python_count_doubles_slice)(_py))?;
    m.add("count_doubles_slice_parallel", wrap_pyfunction!(python_count_doubles_slice_parallel)(_py))?;
    Ok(())
}

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
