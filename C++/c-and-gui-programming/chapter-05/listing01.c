// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Quick intro to pointers.

Compiling this produces several warnings regarding casting memory addresses
to integers. I'm developing on a 64-bit Ubuntu machine, so such warnings
may not be present on Raspberry Pi devices.
*/

#include <stdio.h>

void main (void)
{
    int a;
    int *ptr_to_a;

    ptr_to_a = &a;

    a = 5;
    printf ("The value of a is %d\n", a);

    *ptr_to_a = 6;
    printf ("The value of a is %d\n", a);

    printf ("\n\nThe value of ptr_to_a is %d \n", ptr_to_a);
    printf ("It stores the value %d \n", *ptr_to_a);
    printf ("The address of a is %d \n", &a);

}
