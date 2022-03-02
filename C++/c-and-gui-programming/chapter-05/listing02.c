// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Void pointers and casting.
*/

#include <stdio.h>

void main (void)
{
    int intval = 255958283;
    void *vptr = &intval;

    printf ("The value at vptr as an int is %d\n", *((int *) vptr));
    printf ("The value at vptr as a char is %d\n", *((char *) vptr));
}
