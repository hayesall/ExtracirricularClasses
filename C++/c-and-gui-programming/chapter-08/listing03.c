// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
An *easier* way to compare two strings using
`strcmp` from the string.h library.
*/

#include <stdio.h>
#include <string.h>

void main (void)
{
    char str1[10] = "first";
    char str2[10] = "second";

    if (strcmp (str1, str2) == 0) {
        printf ("The two strings are identical.\n");
    } else {
        printf ("The two strings are different.\n");
    }
}
