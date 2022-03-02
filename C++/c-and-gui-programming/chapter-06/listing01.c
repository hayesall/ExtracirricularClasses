// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Short intro to functions in C
*/

#include <stdio.h>

int sum (int a, int b)
{
    int res;
    res = a + b;
    return res;
}

void main (void)
{
    int y = 2;
    int z = sum (5, y);

    printf ("The sum of 5 and %d is %d\n", y, z);
}
