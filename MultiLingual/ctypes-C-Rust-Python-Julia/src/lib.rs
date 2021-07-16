// Copyright © 2021 Alexander L. Hayes

#[no_mangle]
pub extern "C" fn mean(a: f64, b: f64) -> f64 {
    return (a+b) / 2.0;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mean_1() {
        assert_eq!(mean(10.0, 20.0), 15.0);
    }

    #[test]
    fn test_mean_2() {
        assert_eq!(mean(5.0, 10.0), 7.5);
    }
}
