# Copyright © 2020 Alexander L. Hayes

cdef (unsigned long long) three_var_fib_c(int n, (unsigned long long) a, (unsigned long long) b):
  if n == 1:
    return b
  return three_var_fib_c((n - 1), b, (a + b))

def three_var_fib(int n):
  assert n >= 0
  if n == 0:
    return 0
  return three_var_fib_c(n, 0, 1)
