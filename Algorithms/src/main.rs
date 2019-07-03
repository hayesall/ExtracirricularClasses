// Copyright © 2019 Alexander L. Hayes

use algorithms::rod_cutting::naive_cut_rod;
// use algorithms::recursive_fact;

fn main() {
    let prices = vec![0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30];
    println!("{}", naive_cut_rod(&prices, 25));
}
