// Copyright 2020 Alexander L. Hayes

//! ## Overview
//!
//! Re-implements some of the methods with PyO3 (https://pyo3.rs/v0.11.1/)
//!

use pyo3::prelude::*;
use pyo3::wrap_pyfunction;

pub mod counters;
pub mod utils;
use counters::count_doubles;
use counters::count_doubles_once;
use counters::count_doubles_once_bytes;
use counters::count_doubles_slice;
use counters::count_doubles_slice_parallel;
use utils::random_string;

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
#[pyfunction]
fn python_get_random_alphanumeric(_py: Python, val: u64) -> PyResult<String> {
    Ok(random_string(val))
}

/// Shhh secret docstrings.
#[pymodule]
fn pyo3_myrustlib(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add("count_doubles", wrap_pyfunction!(python_count_doubles)(_py))?;
    m.add(
        "count_doubles_once",
        wrap_pyfunction!(python_count_doubles_once)(_py),
    )?;
    m.add(
        "count_doubles_once_bytes",
        wrap_pyfunction!(python_count_doubles_once_bytes)(_py),
    )?;
    m.add(
        "count_doubles_slice",
        wrap_pyfunction!(python_count_doubles_slice)(_py),
    )?;
    m.add(
        "count_doubles_slice_parallel",
        wrap_pyfunction!(python_count_doubles_slice_parallel)(_py),
    )?;
    m.add(
        "random_string",
        wrap_pyfunction!(python_get_random_alphanumeric)(_py),
    )?;
    Ok(())
}
