// Copyright © 2019 Alexander L. Hayes

//! # Rod Cutting
//!
//! You have a rod of steel and an entrepreneurial attitude for selling portions of
//! this rod for money. But what is the optimal partition of your steel rod such
//! that the amount you earn is maximized?
//!
//! Assume that we know the price `p` that we can sell a rod of `i` inches.
//!
//! The **rod-cutting problem** is defined as follows: "Given a rod of length `n`
//! inches and a table of prices `p` for `i=1,2,..,n`, determine the maximum
//! revenue that may be obtained by selling individual pieces."
//!
//! ## Pseudocode
//!
//! ```pseudo
//! CutRod(p, n)
//!     if n == 0:
//!         return 0
//!     q = -inf
//!     for i = 1 to n:
//!         q = max(q, p[i] + CutRod(p, n - i))
//!     return q
//! ```
//!
//! Here is a portion of lengths of rod, their sale prices, and optimal revenues that may
//! be obtained from selling a rod of such a length.
//!
//! | length i | price p | optimal r                |
//! | :------- | :------ | :----------------------- |
//! | 0        | 0       | 0                        |
//! | 1        | 1       | 1                        |
//! | 2        | 5       | 5                        |
//! | 3        | 8       | 8                        |
//! | 4        | 9       | 10 (length 2 + length 2) |
//! | 5        | 10      | 13 (length 2 + length 3) |
//! | 6        | 17      | 17                       |
//! | ...      | ...     | ...                      |
//!


/// # `CutRod(p,n)`
///
/// Implements the `Cut-Rod` algorithm from page Cormen, Leiserson, Rivest, and Stein
/// "Introduction to Algorithms", Third Edition (Chapter 15, page 360).
///
/// ## Python Version
///
/// ```python
/// # Copyright © 2019 Alexander L. Hayes
/// # MIT License
///
/// import numpy as np
///
/// def naive_cut_rod(p, n):
///     if n == 0:
///         return 0
///     q = -np.float("inf")
///     for i in np.arange(1, n + 1):
///         if i >= p.size:
///             _try = -np.float("inf")
///         else:
///             _try = p[i]
///         q = max(q, _try + naive_cut_rod(p, n - i))
///     return q
///
/// print(naive_cut_rod(np.array([0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30]), 12))
/// ```
///
/// ## Rust Version
///
/// The Rust implementation looks quite similar.
///
/// ```rust
/// pub fn naive_cut_rod(p: &Vec<u32>, n: u32) -> u32 {
///     if n == 0 {
///         return 0
///     }
///     let mut q = u32::min_value();
///     for i in 1..(n + 1) {
///         q = u32::max(q, p[i as usize] + naive_cut_rod(p, n - i));
///     }
///     q
/// }
/// ```
///
pub fn naive_cut_rod(p: &Vec<u32>, n: u32) -> u32 {

    if n == 0 {
        return 0
    }

    let mut q = u32::min_value();

    for i in 1..(n + 1) {

        // Catch the out-of-bounds problem.
        let mut _try;

        if i as usize >= p.len() {
            _try = u32::min_value();
        } else {
            _try = p[i as usize];
        }

        q = u32::max(q, _try + naive_cut_rod(p, n - i));
    }

    q
}

#[cfg(test)]
mod test_naive_cut_rod {
    use crate::rod_cutting::naive_cut_rod;

    #[test]
    fn test_optimal_0() {
        let prices = vec![0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30];
        assert_eq!(0, naive_cut_rod(&prices, 0));
    }

    #[test]
    fn test_optimal_5() {
        let prices = vec![0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30];
        assert_eq!(13, naive_cut_rod(&prices, 5));
    }

    #[test]
    fn test_optimal_9() {
        let prices = vec![0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30];
        assert_eq!(25, naive_cut_rod(&prices, 9));
    }

    #[test]
    fn test_optimal_11() {
        let prices = vec![0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30];
        assert_eq!(31, naive_cut_rod(&prices, 11));
    }

    #[test]
    fn test_optimal_23() {
        let prices = vec![0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30];
        assert_eq!(68, naive_cut_rod(&prices, 23));
    }
}
