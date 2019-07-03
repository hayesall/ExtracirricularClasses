// Copyright © 2019 Alexander L. Hayes

//! # Factorial Functions
//!
//! Several factorial functions.

/// # `Factorial(n)`
///
/// This is a naive recursive implementation of the factorial function without
/// dynamic programming to solve the sub-problems.
pub fn recursive_fact(n: u32) -> u32 {
    if n < 2 {
        1
    } else {
        n * recursive_fact(n - 1)
    }
}
