// Copyright © 2019 Alexander L. Hayes
// MIT License

//! # Menu
//!
//! Display the title for the guessing game.
//!
//! ### Examples
//!
//! ```rust
//! use rust_guessing_game::menu::title_menu;
//!
//! fn main() {
//!     title_menu();
//! }
//! ```

pub mod menu {

    pub fn title_menu() {
        println!("+---------------+");
        println!("| Guessing Game |");
        println!("+---------------+");
        println!("| Instructions: |");
        println!("| Type a number |");
        println!("| or 'exit' to  |");
        println!("|    leave.     |");
        println!("+---------------+");
    }
}
