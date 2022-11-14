// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
"Printing to somewhere other than stdout", or:
"Writing to strings"
*/

#include <stdio.h>

void main (void)
{
    int val = 12;
    char string[50];

    sprintf (string, "The value of val is %d\n", val);

    printf ("%s", string);
}
