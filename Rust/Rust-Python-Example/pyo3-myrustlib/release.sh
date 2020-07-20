# Copyright 2020 Alexander L. Hayes
# MIT License

cargo build --release

if [[ "$?" == "0" ]]; then
 cp target/release/libpyo3_myrustlib.so ../pyo3_myrustlib.so
 echo "Done. Copied libpyo3_myrustlib.so ../pyo3_myrustlib.so"
else
  exit 2
fi
