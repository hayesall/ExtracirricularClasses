// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Short introduction to arrays
*/

#include <stdio.h>

void main (void)
{
    int a[10];

    for (int count = 0; count < 10; count++) {
        a[count] = count * 10 + count;
    }

    printf ("The first and second elements of a are %d and %d\n", a[0], a[1]);
    printf ("Or, as pointers, %d and %d\n", *a, *(a+1));
}
