// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Emulating functions with multiple returns using pointers.

I've tweaked the main function by pulling the `sum_and_diff` call
out of the `printf` call, since mutating the value at address
`&diff` occurs, which might be a bit of an anti-pattern.
*/

#include <stdio.h>

int sum_and_diff (int a, int b, int *res)
{
    int sum;

    sum = a + b;
    *res = a - b;

    return sum;
}

int main (void)
{
    int b = 2;
    int sum;
    int diff;

    sum = sum_and_diff(5, b, &diff);

    printf ("The sum of 5 and %d is %d\n", b, sum);
    printf ("The difference of 5 and %d is %d\n", b, diff);
}
