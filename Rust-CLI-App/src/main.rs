// Copyright © 2019 Alexander L. Hayes
// MIT License

//! # A Command Line App in 15 minutes
//!
//! Author: [Alexander L. Hayes](https://hayesall.com/)
//!
//! This is my implementation as I'm working through Rust's
//! [CLI app tutorial](https://rust-lang-nursery.github.io/cli-wg/index.html).
//!
//! ## Usage
//!
//! ```bash
//! $ cargo build --release
//! $ ./target/release/cli_app v data/example1.txt
//! v2,v1,v0
//! ```

use structopt::StructOpt;

/// Search for a pattern in a file and display the lines that contain it.
#[derive(StructOpt)]
struct Cli {
    /// Pattern we are searching for
    pattern: String,
    /// Path of the file to read
    #[structopt(parse(from_os_str))]
    path: std::path::PathBuf,
}

/// Match pattern matches in content and write to a buffer.
fn find_matches(contents: &str, pattern: &str) {
    for line in contents.lines() {
        if line.contains(pattern) {
            println!("{}", line);
        }
    }
}

fn main() {
    let args = Cli::from_args();
    let content = std::fs::read_to_string(&args.path)
        .expect("Could not read file.");
    find_matches(&content, &args.pattern);
}

#[test]
fn test_something() {
    assert_eq!(2, 2);
}
