from .cyFibo import three_var_fib

import argparse

PARSER = argparse.ArgumentParser()
PARSER.add_argument("-n", "--number", help="Fibonacci number to calculate.")
ARGS = PARSER.parse_args()

print(three_var_fib(int(ARGS.number)))
