#!/usr/bin/env bash

# Copyright © 2019 Alexander L. Hayes
# MIT License

# Build release and start the server
cargo build --release
STATUS=$?

if [[ "$STATUS" -ne "0" ]]; then
    echo "cargo build failed"
    exit 1
fi

./target/release/main > server.log &

# Set the PID of the web server
PID="$!"
echo "Running the server on: $PID"

# Talk to the server with Firefox
open -a "Firefox" "http://127.0.0.1:7878/sleep"
open -a "Firefox" "http://127.0.0.1:7878/sleep"
open -a "Firefox" "http://127.0.0.1:7878/sleep"
open -a "Firefox" "http://127.0.0.1:7878/sleep"
open -a "Firefox" "http://127.0.0.1:7878"

# Press any key to
read -r -n 1 -s -p "Press any key to stop the server... "
echo ""
kill "$PID"
