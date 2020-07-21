// Copyright 2020 Alexander L. Hayes

//! # Double Character Counters
//!
//! > *Given a string of characters, count the number of times two characters are adjacent to
//! > one another.*
//!
//! ## Example Calls:
//!
//! ```
//! let result = count_doubles("000");
//! assert_eq!(result, 2);
//!
//! let result = count_doubles("aabb");
//! assert_eq!(result, 2);
//! ```

extern crate rayon;
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

#[cfg(test)]
mod tests {

    #[test]
    fn test_count_doubles() {
        assert_eq!(super::count_doubles("00"), 1);
        assert_eq!(super::count_doubles("0011"), 2);
        assert_eq!(super::count_doubles("00bb11a"), 3);
        assert_eq!(super::count_doubles("000"), 2);
    }

    #[test]
    fn test_count_doubles_once() {
        assert_eq!(super::count_doubles_once("00"), 1);
        assert_eq!(super::count_doubles_once("0011"), 2);
        assert_eq!(super::count_doubles_once("00bb11a"), 3);
        assert_eq!(super::count_doubles_once("000"), 2);
    }

    #[test]
    fn test_count_doubles_once_bytes() {
        assert_eq!(super::count_doubles_once_bytes("00"), 1);
        assert_eq!(super::count_doubles_once_bytes("0011"), 2);
        assert_eq!(super::count_doubles_once_bytes("00bb11a"), 3);
        assert_eq!(super::count_doubles_once_bytes("000"), 2);
    }

    #[test]
    fn test_count_doubles_slice() {
        assert_eq!(super::count_doubles_slice("00"), 1);
        assert_eq!(super::count_doubles_slice("0011"), 2);
        assert_eq!(super::count_doubles_slice("00bb11a"), 3);
        assert_eq!(super::count_doubles_slice("000"), 2);
    }

    #[test]
    fn test_count_doubles_once_slice_parallel() {
        assert_eq!(super::count_doubles_slice_parallel("00"), 1);
        assert_eq!(super::count_doubles_slice_parallel("0011"), 2);
        assert_eq!(super::count_doubles_slice_parallel("00bb11a"), 3);
        assert_eq!(super::count_doubles_slice_parallel("000"), 2);
    }
}
