// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Reading values from a string, or your first
introduction to parsing good data.
*/

#include <stdio.h>

void main (void)
{
    int val;
    char string[10] = "250";

    sscanf (string, "%d", &val);

    printf ("The value in the string is %d\n", val);
}
