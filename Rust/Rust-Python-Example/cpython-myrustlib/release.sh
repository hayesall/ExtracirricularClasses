# Copyright 2020 Alexander L. Hayes
# MIT License

cargo build --release

if [[ "$?" == "0" ]]; then
 cp target/release/libcpython_myrustlib.so ../cpython_myrustlib.so
 echo "Done. Copied libcpython_myrustlib.so ../cpython_myrustlib.so"
else
  exit 2
fi
