// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

#include <stdio.h>

void main (void)
{
    int a = 0;

    switch (a)
    {
        case 0 : printf ("a is equal to 0\n");
        break;

        case 1 : printf ("a is equal to 1\n");
        break;

        default : printf ("a is greater than 1\n");
    }
}
