// Copyright © 2019 Alexander L. Hayes
// MIT License

//! # Main Game Loop
//!
//! Based on the 'Guessing Game' example from the
//! [Rust Book](https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html).
//!

use rand::Rng;
use rust_guessing_game::menu::title_menu;
use std::cmp::Ordering;
use std::io;
use std::process::exit;

fn main() {
    title_menu();

    let _secret_number = rand::thread_rng().gen_range(1..101);

    loop {
        // Input from user.
        println!("Guess a number: ");
        let mut _guess = String::new();
        io::stdin()
            .read_line(&mut _guess)
            .expect("Could not read from stdin.");

        // Quit if the user types 'exit'
        if _guess.trim() == "exit" {
            println!("Thanks for playing!");
            exit(0);
        };

        let _guess: u32 = match _guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match _guess.cmp(&_secret_number) {
            Ordering::Less => println!("  Too small."),
            Ordering::Greater => println!("  Too big."),
            Ordering::Equal => {
                println!("  Correct!");
                break;
            }
        }
    }
}
