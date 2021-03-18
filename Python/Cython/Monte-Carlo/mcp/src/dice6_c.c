// Copyright © 2012 Hans Petter Langtangen
// Copyright © 2021 Alexander L. Hayes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
Usage
=====

Compile and run. This will segfault if you don't provide a CLI argument.

```bash
gcc dice6_c.c -o dice6.capp
./dice6.capp 100000
```

Overview
========

There may have been a bug in the original C code
*or*
something changed in the standard library or compilers between 2012 and 2021.

"Dice" faces were generated via:

```c
r = 1 + int(rand()/(RAND_MAX*6.0))
```

But I've changed the approach to:

```c
// Seed the random number generator so the same output is not produced every time.
srand(time(0));

// 1 + (RAND_MAX mod 6)
r = 1 + (rand() % 6);
```

I corrected this in the `dice6_cy3` implementation as well.
*/


double dice6(int N, int ndice, int nsix)
{
  int M = 0;
  int six, r, i, j;

  // Initialize random number generator seeded from system timer.
  // This is okay as long as `dice6` isn't called too many times in a row.
  srand(time(0));

  for (i = 0; i < N; i++) {
    six = 0;
    for (j = 0; j < ndice; j++) {
      r = 1 + (rand() % 6);
      if (r == 6) {
        six += 1;
      }
    }
    if (six >= nsix) {
      M += 1;
    }
  }
  return ((double) M) / N;
}


int main(int nargs, const char* argv[])
{
  int N = atoi(argv[1]);
  int ndice = 6;
  int nsix = 3;
  double p = dice6(N, ndice, nsix);
  printf("C code: N=%d, p=%.6f\n", N, p);
  return 0;
}
