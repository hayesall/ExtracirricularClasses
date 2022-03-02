// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

#include <stdio.h>

void main (void)
{
    int a = 0;

    do {
        printf ("a is equal to %d\n", a);
        a++;
    } while (a < 5);

    printf ("a is equal to %d and I've finished\n", a);
}
